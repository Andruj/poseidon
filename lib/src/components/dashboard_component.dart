// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@RouteConfig(const [
  const Route(
      path: '/regions',
      component: RegionsComponent,
      name: 'Regions',
      useAsDefault: true)
])
@Component(
  selector: 'dashboard',
  styleUrls: const ['src/components/dashboard_component.css'],
  templateUrl: 'src/components/dashboard_component.html',
  directives: const [ROUTER_DIRECTIVES, materialDirectives, appDirectives],
  providers: const [materialProviders, appProviders],
)
class DashboardComponent implements OnInit {
  final Firebase firebase;
  final Router router;
  final Logger log = new Logger('DashboardComponent');

  String displayName;
  String photoUrl;

  bool isDrawing = false;
  DashboardComponent(this.firebase, this.router);

  bool isSelected = true;

  ngOnInit() {
    if (firebase.hasUser) {
      displayName = firebase.user.displayName;
      photoUrl = firebase.user.photoURL;
    }
  }

  newRegion() {
    log.info('creating a new region for ${displayName}.');
    firebase.addRegion('Hello World');
  }
}
