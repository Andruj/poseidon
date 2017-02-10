part of providers;


const apiKey = "AIzaSyA40Ox4yGic0PW4z9mJSwxp3U4Wi3vsTag";
const authDomain = "poseidon-ed88d.firebaseapp.com";
const databaseUrl = "https://poseidon-ed88d.firebaseio.com";
const storageBucket = "poseidon-ed88d.appspot.com";
const messagingSenderId = "74668054832";

@Injectable()
class FirebaseService {
  final Logger logger = new Logger('FirebaseService');

  Database _database;
  Auth _auth;
  DatabaseReference _ref;

  FirebaseService() {
    initializeApp(
        apiKey: apiKey,
        authDomain: authDomain,
        databaseURL: databaseUrl,
        storageBucket: storageBucket);

    _database = database();
    _auth = auth();

    _auth.onAuthStateChanged.listen((AuthEvent event) {
      User user = event.user;
      logger.info('authenticated ${user.displayName}.');
    });
  }

  authenticate(AuthProvider provider) async {
    try {
      await _auth.signInWithRedirect(provider);
    } catch (ex) {
    }
  }
}