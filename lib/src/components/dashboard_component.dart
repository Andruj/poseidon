// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'dashboard',
  styleUrls: const ['src/components/dashboard_component.css'],
  templateUrl: 'src/components/dashboard_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, appProviders],
)
class DashboardComponent {
  final Firebase firebase;
  final Logger log = new Logger('DashboardComponent');

  DashboardComponent(this.firebase);
}
