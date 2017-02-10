// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'app',
  styleUrls: const ['src/components/app_component.css'],
  templateUrl: 'src/components/app_component.html',
  directives: const [materialDirectives],
  providers: const [materialProviders, appSingletons, appProviders],
)
class AppComponent {
  FirebaseService firebase;
  AppComponent(this.firebase);

  login(UIEvent event) =>
    firebase.authenticate(new GoogleAuthProvider());
}
