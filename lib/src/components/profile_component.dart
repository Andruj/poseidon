// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'profile',
  templateUrl: 'src/components/profile_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class ProfileComponent implements OnInit {
  final Logger log = new Logger('ProfileComponent');

  ProfileComponent();

  ngOnInit() {
  }
}
