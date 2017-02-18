// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'region',
  styleUrls: const ['src/components/region_component.css'],
  templateUrl: 'src/components/region_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, appProviders],
)
class RegionComponent implements OnInit {
  final Firebase firebase;
  final Logger log = new Logger('RegionComponent');

  @Input()
  Region region;

  RegionComponent(this.firebase);

  ngOnInit() {
    log.info(region);
  }
}
