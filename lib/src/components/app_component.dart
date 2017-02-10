// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'app',
  styleUrls: const ['src/components/app_component.css'],
  templateUrl: 'src/components/app_component.html',
  directives: const [materialDirectives, NgClass],
  providers: const [materialProviders, appSingletons, appProviders],
)
class AppComponent {
  final Firebase firebase;
  final Logger log = new Logger('AppComponent');

  bool isTransparent = true;

  AppComponent(this.firebase) {
    firebase.onUser.listen((_) => log.info('obtained user information.'));
  }

  login(UIEvent event) => firebase.authenticate(new GoogleAuthProvider());
}
