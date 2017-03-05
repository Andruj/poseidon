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
  final app.Firebase firebase;
  final Logger log = new Logger('CalendarComponent');

  @Input()
  app.Region region;

  @Input()
  String id;

  CalendarComponent(this.firebase);

  ngOnInit() {}

}
