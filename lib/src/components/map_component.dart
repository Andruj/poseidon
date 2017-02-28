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
class MapComponent implements AfterViewInit, OnChanges {
  final Logger log = new Logger('MapComponent');

  final Firebase firebase;
  final Geo geo;
  final Noaa noaa;

  final List<Marker> markers = [];

  /// Determines whether the map should be in a display or add state.
  bool _addingLocation = false;
  bool _firstRender = true;

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
    log.info('refreshing the map.');
    if (isAddModeEnabled) {
      endAddMode();
    }

    _clearMap();
    _displaySelectedStations();
  }

  ngAfterViewInit() {
    map = new GMap(this.mapReference.nativeElement, map_config.options);

    map.onDragend.listen(_resetMarkers);

    _clearMap();
    _displaySelectedStations();

    // Grab the current location if available.
    // Breaks in Dartium.
  }

  triggerAddMode() {
    _addingLocation = true;
    // Set the map to edit mode.
    map.options = map_config.editOptions;
    _clearMap();
    _resetMarkers(null);
  }

  endAddMode() {
    _addingLocation = false;
    // Reset the options (styles) for the map.
    map.options = map_config.blankOptions;

    _clearMap();
    _displaySelectedStations();
  }

  resize() {
    event.trigger(map, 'resize', null);
    _centerOnMarkers();
  }

  get isAddModeEnabled => _addingLocation;

  /// A callback that resets the markers when the bounds on the map change.
  _resetMarkers(MouseEvent event) async {
    if (_addingLocation) {
      Map data = await noaa.getStations(map.bounds);
      // If edit mode is turned off midway through the request, don't render.
      if (_addingLocation) {
        _clearMap();
        data['results'].forEach(_initializeStation);
      }
    }
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
        List<String> keys = _getStationIds(station);

        if (keys.isEmpty) {
          firebase.addStation(id, station);
        } else {
          keys.forEach((String key) => firebase.deleteStationById(id, key));
        }
      }
    });

    markers.add(marker);
  }

  /// Clears the map markers and the markers list.
  _clearMap() {
    for (Marker marker in markers) {
      marker.map = null;
    }
    markers.clear();
  }

  _displaySelectedStations() {
    region.stations.values.forEach(_initializeStation);
  }

  _getStationIds(station) => region.stations.keys
      .where((key) => region.stations[key]['id'] == station['id'])
      .toList();

  _isInRegion(Map station) => _getStationIds(station).isNotEmpty;

  _centerOnMarkers() async {
    if (markers.isEmpty) {
      // Broken on Dartium.
      // map.center = await geo.currentLocation;
    } else {
      LatLngBounds computed = new LatLngBounds();
      markers.map((marker) => marker.position).forEach(computed.extend);
      map.center = computed.center;
      map.fitBounds(computed);
      // Ensure no markers are up against the edge.
      map.zoom = map.zoom - 1;
    }
  }
}
