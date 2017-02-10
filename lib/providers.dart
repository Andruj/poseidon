library providers;

import 'package:angular2/angular2.dart';
import 'package:firebase/firebase.dart';
import 'package:logging/logging.dart';

part 'package:poseidon/src/providers/firebase_service.dart';

/// A collection of common services.
const appProviders = const [];

/// The collection of singleton services. Only inject once.
const appSingletons = const [FirebaseService];