// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'map',
  styleUrls: const ['src/components/map_component.css'],
  templateUrl: 'src/components/map_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, appProviders],
)
class MapComponent implements OnInit, AfterViewChecked {
  final Firebase firebase;
  final Logger log = new Logger('MapComponent');

  GMap map;

  @Input()
  Region region;

  @Input()
  String id;

  MapComponent(this.firebase) {}

  ngAfterViewChecked() {
    Element mapElement = document.getElementById("map");
    if(mapElement != null) {
      log.info('initializing Google Maps.');
      final mapOptions = new MapOptions()
        ..zoom = 8
        ..center = new LatLng(-34.397, 150.644);

      map = new GMap(document.getElementById("map"), mapOptions);
    }
  }

  ngOnInit() {}
}
