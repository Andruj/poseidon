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

  DatabaseReference _userNode;
  DatabaseReference _regionsNode;

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

    _auth.onAuthStateChanged.listen((AuthEvent event) {
      if (event.user != null) {
        user = event.user;
        log.info('authenticated ${user.displayName}.');

        // Set up the database access points for the user.
        _userNode = _database.ref('users').child(user.uid);
        _regionsNode = _userNode.child('regions');

        // Clear the regions and fill the empty map with the new data.
        // This is not optimal, but since regions currently are so light,
        // the computation is ignored.
        _regionsNode.onValue.listen((QueryEvent event) {
          // We always clear, since if they delete the last region
          // it will not go into next branch.
          regions.clear();

          if (event.snapshot.exists()) {
            Map<String, Map> data = event.snapshot.val();

            regions.addAll(new Map.fromIterables(data.keys,
                data.values.map((json) => new Region.fromMap(json))));

            log.info('acquired ${regions.length} regions.');
          }
        });

        onUser.emit(user);
      }
    });
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

  get hasUser => user != null;

  addRegion(Region region) => _regionsNode.push(region.toMap());

  updateRegion(String id, Region region) =>
      _regionsNode.child(id).update(region.toMap());

  deleteRegionById(String id) => _regionsNode.child(id).remove();

  addLocation(String id, Location location) => _regionsNode
      .child(id)
      .child(Region.locationsKey)
      .push(Location.toMap(location));

  deleteStationById(String regionId, String stationId) => _regionsNode
      .child(regionId)
      .child(Region.locationsKey)
      .child(stationId)
      .remove();
}
