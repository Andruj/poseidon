// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'calendar',
  styleUrls: const ['src/components/calendar_component.css'],
  templateUrl: 'src/components/calendar_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class CalendarComponent implements OnChanges {
  final Logger log = new Logger('CalendarComponent');
  final app.Firebase firebase;
  final app.Weather weather;

  @Input()
  app.Region region;

  @Input()
  String id;

  app.Snapshot ceiling;

  List<app.Forecast> forecasts;

  /// The zipped snapshots from each forecast.
  List<app.Snapshot> aggregates;

  Map<int, List<app.Snapshot>> days = {};

  CalendarComponent(this.firebase, this.weather);

  select(app.Snapshot snapshot) {
    log.info(snapshot);
    if (snapshot.watching) {
      firebase.addWatcher(id, snapshot.time);
    } else {
      region.watchlist.remove(region.watchlist.keys
          .firstWhere((k) => region.watchlist[k] == snapshot.time));

      update();
    }
  }

  /// Updates the region on firebase.
  update() {
    log.info('updating $id to $region');
    firebase.updateRegion(id, region);
  }

  ngOnChanges(_) => _setup();

  _setup() async {
    log.info('onChanges: refreshing snapshots.');
    log.info(region);
    days.clear();

    forecasts =
        await Future.wait(region.locations.values.map(weather.getForecast));

    aggregates = quiver.zip(forecasts.map((forecast) => forecast.data)).map(
        (snaps) => new app.Snapshot.fromSnapshots(snaps as List<app.Snapshot>));

    ceiling = aggregates.reduce((a, b) => a.wind > b.wind ? a : b);

    aggregates.forEach((app.Snapshot s) {
      if (days.containsKey(s.time.day)) {
        days[s.time.day].add(s);
      } else {
        days[s.time.day] = [s];
      }
    });
  }
}
