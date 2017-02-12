// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'watchlist',
  template: '<material-spinner></material-spinner>',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, appProviders],
)
class WatchListComponent implements OnInit {
  final Logger log = new Logger('WatchListComponent');

  WatchListComponent();

  ngOnInit() {
  }
}
