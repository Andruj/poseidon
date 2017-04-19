// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@RouteConfig(const [
  const Route(
      path: '/regions',
      component: RegionsComponent,
      name: 'Regions',
      useAsDefault: true),
  const Route(
    path: '/profile',
    component: ProfileComponent,
    name: 'Profile',
  ),
  const Route(
    path: '/overview',
    component: OverviewComponent,
    name: 'Overview',
  ),
])
@Component(
  selector: 'dashboard',
  styleUrls: const ['src/components/dashboard_component.css'],
  templateUrl: 'src/components/dashboard_component.html',
  directives: const [ROUTER_DIRECTIVES, materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class DashboardComponent implements OnInit {
  final app.Firebase firebase;
  final Router router;
  final Logger log = new Logger('DashboardComponent');

  bool isMenuOpen = false;

  String displayName;
  String photoUrl;

  DashboardComponent(this.firebase, this.router);

  toggleMenu() {
    isMenuOpen = !isMenuOpen;
  }

  bool get isMenuClosed => !isMenuOpen;

  isSelected(String button) => AppComponent.currentRoute.endsWith(button);

  ngOnInit() {
    if (firebase.hasUser) {
      displayName = firebase.user.displayName;
      photoUrl = firebase.user.photoURL;
    }
  }

  navigateTo(String location) {
    router.navigate([location]);
    isMenuOpen = false;
  }
}
