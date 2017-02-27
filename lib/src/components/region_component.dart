// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

const _calendarTab = 0;
const _mapTab = 1;
const _windTab = 2;

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

  @ViewChild(MapComponent)
  MapComponent mapComponent;

  @Input()
  Region region;

  @Input()
  String id;

  @Output("delete")
  final EventEmitter onDelete = new EventEmitter<String>();

  /// Determines whether the 'add location' FAB is visible to the user.
  bool inMapTab = false;


  bool showDeleteDialog = false;

  RegionComponent(this.firebase);

  ngOnInit() {}

  /// Deletes a region from Firebase.
  delete() {
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
    if(mapComponent.isAddModeEnabled) {
      mapComponent.endAddMode();
    }
    else {
      mapComponent.triggerAddMode();
    }
  }

  tabChanged(TabChangeEvent event) =>
      inMapTab = event.newIndex == _mapTab;
}
