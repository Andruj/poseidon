// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'regions',
  styleUrls: const ['src/components/regions_component.css'],
  templateUrl: 'src/components/regions_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class RegionsComponent implements OnInit {
  final app.Firebase firebase;
  final Logger log = new Logger('RegionsComponent');

  final Map<String, app.Region> regions;

  bool fabVisible = true;
  bool showDialog = false;
  String newRegionName = "";

  RegionsComponent(app.Firebase firebase)
      : this.firebase = firebase,
        this.regions = firebase.regions;

  ngOnInit() {
    log.info("there are${regions.isNotEmpty ? "" : " no"} regions here.");
  }

  addRegion() {
    if (newRegionName.isNotEmpty) {
      log.info('onClick: setting up new region.');
      firebase.addRegion(new app.Region(newRegionName, {}));

      // Close the dialog after adding a region.
      resetDialog();
    }
  }

  toggleFab() => fabVisible = !fabVisible;

  resetDialog() {
    showDialog = false;
    newRegionName = "";
  }

  get fabHidden => !fabVisible;
}
