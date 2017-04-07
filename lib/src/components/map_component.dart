// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'map',
  styleUrls: const ['src/components/map_component.css'],
  templateUrl: 'src/components/map_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class MapComponent implements AfterViewInit, OnChanges {
  final Logger log = new Logger('MapComponent');
  final app.Firebase firebase;
  final app.Geo geo;
  final app.Weather sky;

  @ViewChild('map')
  ElementRef mapReference;

  @Input()
  Map locations;

  @Input()
  String id;

  /// The current markers on the map.
  final List<Marker> markers = [];

  /// Determines whether the map should be in a display or add state.
  bool _addingLocation = false;
  bool _shouldResize = true;

  /// The Google Map for the component.
  GMap map;

  MapComponent(this.firebase, this.geo, this.sky);

  /// If the data has changed, redraw the map. If we are still in edit mode,
  /// it means the edit went through, so end the edit mode.
  ngOnChanges(_) {
    log.info('onChanges.');
    if (isAddModeEnabled) {
      endAddMode();
    }

    _clearMap();
    _displayLocations();
  }

  ngAfterViewInit() {
    log.info('afterViewInit.');
    map = new GMap(this.mapReference.nativeElement, map_config.options);
    map.onClick.listen(_addLocation);

    _clearMap();
    _displayLocations();

    // Grab the current location if available.
    // Breaks in Dartium.
  }

  triggerAddMode() {
    _addingLocation = true;
    // Set the map to edit mode.
    map.options = map_config.editOptions;
    markers.forEach(_changeIcon);
  }

  endAddMode() {
    _addingLocation = false;
    // Reset the options (styles) for the map.
    map.options = map_config.blankOptions;

    _clearMap();
    _displayLocations();
  }


  resize() {
    if(_shouldResize) {
      log.info('resize.');

      event.trigger(map, 'resize', null);
      centerOnMarkers();

      _shouldResize = false;
    }
  }


  get isAddModeEnabled => _addingLocation;

  /// Clears the map markers and the markers list.
  _clearMap() {
    for (Marker marker in markers) {
      marker.map = null;
    }

    markers.clear();
  }

  _changeIcon(Marker marker) {
    marker.icon = isAddModeEnabled ? "/pin_selected.png" : "/pin.png";
  }

  /// Displays all the location on the map.
  _displayLocations() => locations.values.forEach(_displayLocation);

  /// Adds a new location to the region in firebase, not the model.
  _addLocation(MouseEvent event) {
    if (isAddModeEnabled) {
      firebase.addLocation(id, new app.Location.fromLatLng(event.latLng));
    }
  }

  /// Generates a marker for a station from D.
  _displayLocation(app.Location location) {
    final options = new MarkerOptions()
      ..position = location.position
      ..map = map
      ..icon = isAddModeEnabled ? "/pin_selected.png" : "/pin.png";

    final marker = new Marker(options)
      ..onClick.listen((_) {
        if (_addingLocation) {
          String locationId = utils.key(locations, location);

          if (locationId != null) {
            firebase.deleteStationById(id, locationId);
          }
        }
      });

    markers.add(marker);
  }

  /// Centers the map based on the coordinates in locations.
  centerOnMarkers() {
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
