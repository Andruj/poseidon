// Copyright (c) 2017, Andrew Peterson. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

part of components;

@Component(
  selector: 'snapshot',
  styleUrls: const ['src/components/snapshot_component.css'],
  templateUrl: 'src/components/snapshot_component.html',
  pipes: const [appPipes],
  directives: const [materialDirectives, appDirectives],
  providers: const [materialProviders, app.providers],
)
class SnapshotComponent {
  final Logger log = new Logger('SnapshotComponent');

  @Input()
  app.Snapshot snapshot;


  SnapshotComponent() {
  }
}
