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
class CalendarComponent implements OnInit {
  final Logger log = new Logger('CalendarComponent');
  final app.Firebase firebase;
  final app.Weather weather;

  @Input()
  app.Region region;

  @Input()
  String id;

  List<app.Forecast> forecasts;

  /// The zipped snapshots from each forecast.
  List<app.Snapshot> aggregates;

  CalendarComponent(this.firebase, this.weather);

  ngOnInit() {
    (() async {
      forecasts =
          await Future.wait(region.locations.values.map(weather.getForecast));

      log.info('received ${forecasts.length} forecasts.');

      aggregates = quiver
          .zip(forecasts.map((forecast) => forecast.data))
          .map((snaps) => new app.Snapshot.fromSnapshots(snaps as List<app.Snapshot>));

      log.info(aggregates.first);
    })();
  }
}
