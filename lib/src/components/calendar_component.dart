// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'calendar',
  styleUrls: const ['src/components/calendar_component.css'],
  templateUrl: 'src/components/calendar_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, appProviders],
)
class CalendarComponent implements OnInit {
  final Firebase firebase;
  final Logger log = new Logger('CalendarComponent');

  @Input()
  Region region;

  @Input()
  String id;

  CalendarComponent(this.firebase);

  ngOnInit() {}

}
