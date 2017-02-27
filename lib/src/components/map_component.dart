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
class MapComponent implements AfterViewChecked, AfterViewInit {
  final Firebase firebase;
  final Geo geo;
  final Noaa noaa;
  final Logger log = new Logger('MapComponent');

  final List<Marker> markers = [];

  final options = new MapOptions()
    ..zoom = 8
    ..center = new LatLng(35.272491, -120.7054055);

  /// Determines whether the map should be in a display or add state.
  bool addingLocation = false;

  GMap map;

  @Input()
  Region region;

  @Input()
  String id;

  @ViewChild('map')
  ElementRef mapReference;

  MapComponent(this.firebase, this.geo, this.noaa);

  ngAfterViewChecked() {
    // Refresh the map since the tab height changed.
    event.trigger(map, 'resize', null);
  }

  ngAfterViewInit() {
    log.info('initializing Google Maps.');
    map = new GMap(this.mapReference.nativeElement, options);

    map.onDragend.listen(_resetMarkers);

    map.onClick.listen((MouseEvent event) {
      if (addingLocation) {
        log.info('coordinates: ${event.latLng}');
        addingLocation = false;
      }
    });

    region.stations.values.forEach(_initializeStation);

    // Grab the current location if available.
    // Breaks in Dartium.
//    geo.currentLocation.then((LatLng center) => map.center = center);
  }

  /// A callback that resets the markers when the bounds on the map change.
  _resetMarkers(MouseEvent event) async {
    if (addingLocation) {
      _clearMap();

      Map data = await noaa.getStations(map.bounds);
      data['results'].forEach(_initializeStation);
    }
  }

  /// Clears the map markers and the markers list.
  _clearMap() {
    for(Marker marker in markers) {
      marker.map = null;
    }

    markers.clear();
  }

  /// Generates a marker for a station from NOAA.
  _initializeStation(Map station) {
    MarkerOptions opts = new MarkerOptions()
      ..position = new LatLng(station['latitude'], station['longitude'])
      ..map = map
      ..title = station['name'];

    Marker marker = new Marker(opts);
    marker.onClick.listen((_) {
      firebase.addStation(id, station);
      addingLocation = false;
    });

    markers.add(marker);
  }
}
