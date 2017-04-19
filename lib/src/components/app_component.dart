// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@RouteConfig(const [
  const Route(
      path: '/', component: LoginComponent, name: 'Login', useAsDefault: true),
  const Route(
      path: '/dashboard/...', component: DashboardComponent, name: 'Dashboard')
])
@Component(
  selector: 'app',
  styleUrls: const ['src/components/app_component.css'],
  templateUrl: 'src/components/app_component.html',
  directives: const [
    ROUTER_DIRECTIVES,
    materialDirectives,
    appDirectives,
    NgClass
  ],
  providers: const [
    ROUTER_PROVIDERS,
    materialProviders,
    app.singletons,
    app.providers
  ],
)
class AppComponent {
  final app.Firebase firebase;
  final Router router;
  final Logger log = new Logger('AppComponent');
  static String currentRoute = 'dashboard/regions';

  bool isTransparent = true;

  final List<String> breadcrumbs = [];

  String get mobileTitle => breadcrumbs.isNotEmpty ? breadcrumbs.last : 'Loading..';

  AppComponent(this.firebase, this.router) {
    firebase.onUser.listen((_) {
      log.info('obtained user information.');
      router.navigate(['/Dashboard']);
      isTransparent = false;
    });

    router.onStartNavigation.listen((String path) {
      log.info('navigating to $path');

      currentRoute = path == 'dashboard' ? 'dashboard/regions' : path;

      if (path.isEmpty) {
        breadcrumbs.add('Poseidon');
      } else {
        List<String> locations = path.split('/');

        String poseidon = breadcrumbs.first;
        breadcrumbs.clear();
        breadcrumbs.add(poseidon);
        breadcrumbs.addAll(locations);
      }
    });
  }
}
