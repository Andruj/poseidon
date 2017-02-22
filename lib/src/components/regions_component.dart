// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'regions',
  styleUrls: const ['src/components/regions_component.css'],
  templateUrl: 'src/components/regions_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, appProviders],
)
class RegionsComponent implements OnInit, OnDestroy {
  final Firebase firebase;
  final Logger log = new Logger('RegionsComponent');

  Map<String, Region> regions = {};

  RegionsComponent(this.firebase) {
    regions = firebase.regions;
  }

  ngOnInit() {
    log.info("there are ${regions.isNotEmpty ? "" : "no"} regions here.");
  }

  ngOnDestroy() {
  }
}
