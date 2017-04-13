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
class SnapshotComponent implements OnChanges {
  final Logger log = new Logger('SnapshotComponent');
  final app.Firebase firebase;

  @ViewChild('windOverlay')
  ElementRef overlayReference;

  @Output("select")
  EventEmitter onSelect = new EventEmitter();

  @Input()
  String regionId;

  @Input()
  bool watching = false;

  @Input()
  String watchlistId;

  @Input()
  app.Snapshot ceiling;

  @Input()
  app.Snapshot snapshot;

  SnapshotComponent(this.firebase) {}

  ngOnChanges(_) {
    log.info('onChanges.');

    // Calculate ratio of the snapshot's wind with the max windspeed
    // for the calendar, cap to a max of 70%.
    num height = (snapshot.wind / ceiling.wind) * 70;

    overlayReference.nativeElement.style.height = '$height%';
  }

  select() {
    if (!watching) {
      firebase.addWatcher(regionId, snapshot.time);
    } else {
      log.info('Deleting watchlist element.');
      firebase.deleteWatcherById(regionId, watchlistId);
    }
  }
}
