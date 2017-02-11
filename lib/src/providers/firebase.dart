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
  DatabaseReference userRef;

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
      User user = event.user;

      if (user != null) {
        log.info('authenticated ${user.displayName}.');
        this.user = user;
        userRef = _database.ref('users').child(user.uid);
        onUser.emit(User);
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

  List<String> get regions {
    userRef.onValue.listen((e) {
      DataSnapshot snapshot = e.snapshot;
      log.info(snapshot);
    });
  }

  addRegion(String name) async {
    userRef.child('regions').set('San Luis Obispo, CA');
  }
}
