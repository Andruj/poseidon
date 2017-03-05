// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'details-comp',
  styleUrls: const ['src/components/details_component.css'],
  templateUrl: 'src/components/details_component.html',
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class DetailsComponent implements OnInit {
  final app.Firebase firebase;
  final Logger log = new Logger('DetailsComponent');

  @Input()
  app.Region region;

  @Input()
  String id;

  DetailsComponent(this.firebase);

  ngOnInit() {}

  /// Updates the region on firebase.
  update() {
    log.info('updating $id to $region');
    firebase.updateRegion(id, region);
  }
}
