// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@RouteConfig(const [
  const Route(
      path: '/login',
      component: LoginComponent,
      name: 'Login',
      useAsDefault: true),
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
    appSingletons,
    appProviders
  ],
)
class AppComponent {
  final Firebase firebase;
  final Router router;
  final Logger log = new Logger('AppComponent');

  bool isTransparent = true;

  final List<String> breadcrumbs = [];

  AppComponent(this.firebase, this.router) {
    firebase.onUser.listen((_) {
      log.info('obtained user information.');
      router.navigate(['/Dashboard']);
      isTransparent = false;
    });

    router.onStartNavigation.listen((String path) {
      log.info('navigating to $path');
      // The base path.
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
