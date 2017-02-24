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
class MapComponent implements OnInit, AfterViewChecked, AfterViewInit {
  final Firebase firebase;
  final Geo geo;
  final Logger log = new Logger('MapComponent');


  /// Determines whether the map should be in a display or add state.
  bool shouldAddLocation = false;

  GMap map;

  @Input()
  Region region;

  @Input()
  String id;

  @ViewChild('map')
  ElementRef mapReference;

  MapComponent(this.firebase, this.geo);

  ngAfterViewChecked() {
    // Refresh the map since the tab height changed.
    event.trigger(map, 'resize', null);
  }

  ngAfterViewInit() {
    log.info('initializing Google Maps.');
    final mapOptions = new MapOptions()
      ..zoom = 8
      ..center = new LatLng(-34.397, 150.644);

    map = new GMap(this.mapReference.nativeElement, mapOptions);


    map.onClick.listen((MouseEvent event) {
      // Ideally what happens here is that we populate the current bounds
      // with all wind sensors, not just the user selected ones (but
      // distinguish among the two) then let the user pick one
      // to add.
      if(shouldAddLocation) {
        log.info('coordinates: ${event.latLng}');
        shouldAddLocation = false;
      }
    });

    // Grab the current location if available.
    // Breaks in Dartium.
//    geo.currentLocation.then((LatLng center) => map.center = center);
  }

  ngOnInit() {
  }

}
