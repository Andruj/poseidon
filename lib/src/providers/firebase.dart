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
  DatabaseReference _ref;
  DatabaseReference root;
  DatabaseReference regions;

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
        root = _database.ref('users').child(user.uid);
        regions = root.child('regions');

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

  addRegion(String name) async {
    root.child('regions').set('San Luis Obispo, CA');
  }
}

class Region {
  final String name;

  static Region fromJSON(Map json) {
    return new Region(json['name']);
  }

  const Region(this.name);

  @override
  String toString() {
    return '''

[Region
    (name: $name)]''';
  }
}