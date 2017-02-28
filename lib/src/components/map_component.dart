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
class MapComponent implements AfterViewChecked, AfterViewInit, OnChanges {
  final Firebase firebase;
  final Geo geo;
  final Noaa noaa;
  final Logger log = new Logger('MapComponent');

  final List<Marker> markers = [];

  final options = new MapOptions()
    ..zoom = 8
    ..center = new LatLng(35.272491, -120.7054055);

  /// Determines whether the map should be in a display or add state.
  bool _addingLocation = false;

  GMap map;

  @Input()
  Region region;

  @Input()
  String id;

  @ViewChild('map')
  ElementRef mapReference;

  MapComponent(this.firebase, this.geo, this.noaa) {}

  /// If the data has changed, redraw the map. If we are still in edit mode,
  /// it means the edit went through, so end the edit mode.
  ngOnChanges(_) {
    if(isAddModeEnabled) {
      endAddMode();
    }

    _clearMap();
    _displaySelectedStations();
  }

  ngAfterViewChecked() {
    // Refresh the map since the tab height changed.
    event.trigger(map, 'resize', null);
  }

  ngAfterViewInit() {
    log.info('initializing Google Maps.');
    map = new GMap(this.mapReference.nativeElement, options);

    map.onDragend.listen(_resetMarkers);

    _clearMap();
    _displaySelectedStations();

    // Grab the current location if available.
    // Breaks in Dartium.
//    geo.currentLocation.then((LatLng center) => map.center = center);
  }

  triggerAddMode() {
    log.info('entering edit mode.');
    _addingLocation = true;

    map.options = new MapOptions()..styles = map_config.addModeStyles;
    _clearMap();
    _resetMarkers(null);
  }

  endAddMode() {
    log.info('ending edit mode for map.');
    _addingLocation = false;

    map.options = new MapOptions()..styles = [];

    _clearMap();
    _displaySelectedStations();
  }

  get isAddModeEnabled => _addingLocation;

  /// A callback that resets the markers when the bounds on the map change.
  _resetMarkers(MouseEvent event) async {
    if (_addingLocation) {
      Map data = await noaa.getStations(map.bounds);
      _clearMap();
      data['results'].forEach(_initializeStation);
    }
  }

  /// Clears the map markers and the markers list.
  _clearMap() {
    for (Marker marker in markers) {
      marker.map = null;
    }

    markers.clear();
  }

  /// Generates a marker for a station from NOAA.
  _initializeStation(Map station) {
    MarkerOptions opts = new MarkerOptions()
      ..position = new LatLng(station['latitude'], station['longitude'])
      ..map = map
      ..icon = isAddModeEnabled && _isInRegion(station)
          ? "/pin_selected.png"
          : "/pin.png"
      ..title = station['name'];

    Marker marker = new Marker(opts);
    marker.onClick.listen((_) {
      if (_addingLocation) {
        List<String> keys = region.stations.keys
            .where((key) => region.stations[key]['id'] == station['id'])
            .toList();

        if (keys.isEmpty) {
          firebase.addStation(id, station);
        } else {
          keys.forEach((String key) => firebase.deleteStationById(id, key));
        }
      }
    });

    markers.add(marker);
  }

  _displaySelectedStations() =>
    region.stations.values.forEach(_initializeStation);

  _isInRegion(Map station) {
    List<String> keys = region.stations.keys
        .where((key) => region.stations[key]['id'] == station['id'])
        .toList();

    return keys.isNotEmpty;
  }

}
