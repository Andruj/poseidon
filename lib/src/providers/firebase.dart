part of providers;

const apiKey = "AIzaSyA40Ox4yGic0PW4z9mJSwxp3U4Wi3vsTag";
const authDomain = "poseidon-ed88d.firebaseapp.com";
const databaseUrl = "https://poseidon-ed88d.firebaseio.com";
const storageBucket = "poseidon-ed88d.appspot.com";
const messagingSenderId = "74668054832";

@Injectable()
class Firebase {
  final Logger log = new Logger('Firebase');

  Database _database;
  Auth _auth;

  DatabaseReference fbRoot;
  DatabaseReference fbRegions;

  Map<String, Region> regions = {};
  User user;

  /// Triggers an event when the [UserInfo] is loaded from Firebase.
  EventEmitter onUser = new EventEmitter();

  Firebase() {
    initializeApp(
        apiKey: apiKey,
        authDomain: authDomain,
        databaseURL: databaseUrl,
        storageBucket: storageBucket);

    _database = database();
    _auth = auth();

    _auth.onAuthStateChanged.listen(setup);
  }

  /// Authenticates a [AuthProvider] with Firebase.
  authenticate(AuthProvider provider) async {
    try {
      log.info('authenticating with ${provider.providerId}?');
      await _auth.signInWithRedirect(provider);
    } catch (e, stackTrace) {
      log.severe('failure authenticating.', e, stackTrace);
    }
  }

  setup(AuthEvent event) {
    if (event.user != null) {
      user = event.user;
      log.info('authenticated ${user.displayName}.');

      // Set up the database access points for the user.
      fbRoot = _database.ref('users').child(user.uid);
      fbRegions = fbRoot.child('regions');

      fbRegions.onChildAdded
          .listen(Sync.add(regions, (r) => new Region.fromMap(r)));
      fbRegions.onChildRemoved.listen(Sync.remove(regions));

//       Must happen after the region is added.
      fbRegions.onChildAdded.listen(addListeners);

      onUser.emit(user);
    }
  }

  addListeners(QueryEvent event) {
    DatabaseReference fbRegion = fbRegions.child(event.snapshot.key);
    Region region = regions[event.snapshot.key];

    fbRegion
        .child('watchlist')
        .onChildAdded
        .listen(Sync.add(region.watchlist, DateTime.parse));

    fbRegion
        .child('watchlist')
        .onChildRemoved
        .listen(Sync.remove(region.watchlist));

    fbRegion
        .child('locations')
        .onValue
        .listen(Sync.overwrite((Map<String, Map> data) {
      region.locations = new Map.fromIterables(
          data.keys, data.values.map((v) => new Location.fromMap(v)));
    }));
  }

  get hasUser => user != null;

  addRegion(Region region) => fbRegions.push(region.toMap());

  updateRegion(String id, Region region) =>
      fbRegions.child(id).update(region.toMap());

  deleteRegionById(String id) => fbRegions.child(id).remove();

  addLocation(String id, Location location) =>
      fbRegions.child(id).child(Region.locationsKey).push(location.toMap());

  addWatcher(String id, DateTime time) =>
      fbRegions.child(id).child('watchlist').push(time.toIso8601String());

  deleteWatcherById(String regionId, String id) =>
      fbRegions.child(regionId).child('watchlist').child(id).remove();

  deleteStationById(String regionId, String stationId) => fbRegions
      .child(regionId)
      .child(Region.locationsKey)
      .child(stationId)
      .remove();
}

/// Provides useful closures to simplify [Firebase] callback chaining.
class Sync {
  static overwrite(convert) {
    return (QueryEvent event) => convert(event.snapshot.val() ?? {});
  }

  static add(model, convert) {
    return (QueryEvent event) {
      model[event.snapshot.key] = convert(event.snapshot.val());
    };
  }

  static remove(Map model) {
    return (QueryEvent event) => model.remove(event.snapshot.key);
  }
}
