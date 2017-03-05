// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

class TabIndex {
  static final int calendar = 0;
  static final int map = 1;
  static final int details = 2;
}

@Component(
  selector: 'region',
  styleUrls: const ['src/components/region_component.css'],
  templateUrl: 'src/components/region_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class RegionComponent {
  final Logger log = new Logger('RegionComponent');
  final app.Firebase firebase;
  final app.Weather weather;

  @ViewChild(MapComponent)
  MapComponent mapComponent;

  @Input()
  app.Region region;

  @Input()
  String id;

  /// Triggers when the delete button is pressed. Used for UI purposes.
  @Output("delete")
  final EventEmitter onDelete = new EventEmitter<String>();

  /// Determines whether the 'add location' FAB is visible to the user.
  bool inMapTab = false;

  /// The flag determining whether the "Delete" dialog if visible.
  bool showDeleteDialog = false;

  /// Delay in milliseconds to resize the map after changing to the tab.
  static const int _delay = 250;

  RegionComponent(this.firebase, this.weather);

  /// Deletes a region from Firebase.
  delete() {
    log.info('deleting {$id: $region}');
    firebase.deleteRegionById(id);
    onDelete.emit(id);

    showDeleteDialog = false;
  }

  /// Updates the region on firebase.
  update() {
    log.info('updating $id to $region');
    firebase.updateRegion(id, region);
  }

  toggleAddMode() {
    if (mapComponent.isAddModeEnabled) {
      mapComponent.endAddMode();
    } else {
      mapComponent.triggerAddMode();
    }
  }

  tabChanged(TabChangeEvent event) {
    inMapTab = event.newIndex == TabIndex.map;

    // Hack. We wait for the DOM to load the tab then resize the map.
    if (inMapTab) {
      new Future.delayed(
          const Duration(milliseconds: _delay), mapComponent.resize);
    }
  }
}
