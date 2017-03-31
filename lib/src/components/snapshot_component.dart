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
  String id;

  @ViewChild('windOverlay')
  ElementRef overlayReference;

  @Output("select")
  EventEmitter onSelect = new EventEmitter();

  @Input()
  String regionId;

  @Input()
  app.Snapshot ceiling;

  @Input()
  app.Snapshot snapshot;

  @Input()
  app.Region region;


  SnapshotComponent(this.firebase) {
  }

  ngOnChanges(_) {
    if(region.watchlist.containsValue(snapshot.time)) {
      snapshot.watching = true;

      id = region.watchlist.keys.firstWhere((k) {
        return region.watchlist[k] == snapshot.time;
      });
    }

    // Calculate ratio of the snapshot's wind with the max windspeed
    // for the calendar, cap to a max of 70%.
    num height = (snapshot.wind / ceiling.wind) * 70;

    overlayReference.nativeElement.style.height = '$height%';

    if(id != null) {
      log.info('database id: $id.');
    }

  }

  select() {
    snapshot.watching = !snapshot.watching;

    if(snapshot.watching) {
      firebase.addWatcher(regionId, snapshot.time);
    } else {
      log.info('Deleting watchlist element.');
      firebase.deleteWatcherById(regionId, id);
    }
    onSelect.emit(null);
  }



}
