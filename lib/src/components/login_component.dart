// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'login',
  styleUrls: const ['src/components/login_component.css'],
  templateUrl: 'src/components/login_component.html',
  directives: const [materialDirectives, appDirectives, NgClass],
  providers: const [materialProviders, appProviders],
)
class LoginComponent {
  final Firebase firebase;
  final Logger log = new Logger('LoginComponent');

  LoginComponent(this.firebase);

  login(UIEvent event) => firebase.authenticate(new GoogleAuthProvider());
}
