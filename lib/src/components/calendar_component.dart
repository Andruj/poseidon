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
  Map<String, DateTime> watchlist;

  @Input()
  Map<String, app.Location> locations;

  @Input()
  String id;

  app.Snapshot ceiling;

  List<app.Forecast> forecasts;

  /// The zipped snapshots from each forecast.
  List<app.Snapshot> aggregates;

  Map<int, List<app.Snapshot>> days = {};

  CalendarComponent(this.firebase, this.weather);

  ngOnChanges(_) => _setup();

  isWatching(app.Snapshot s) => watchlist.containsValue(s.time);
  getWatchlistKey(app.Snapshot s) => utils.key(watchlist, s.time);


  _setup() async {
    log.info('onChanges.');
    days.clear();

    if (locations.isNotEmpty) {
      forecasts =
          await Future.wait(locations.values.map(weather.getForecast));

      // Aggregate each location's forecast to an average snapshot per region.
      aggregates = quiver.zip(forecasts.map((forecast) => forecast.data)).map(
          (snaps) =>
              new app.Snapshot.fromSnapshots(snaps as List<app.Snapshot>));

      // Find the most windy snapshot.
      ceiling = aggregates.reduce((a, b) => a.wind > b.wind ? a : b);

      // Split the snapshot into days.
      aggregates.forEach((app.Snapshot s) {
        if (days.containsKey(s.time.day)) {
          days[s.time.day].add(s);
        } else {
          days[s.time.day] = [s];
        }
      });

    }
  }
}
