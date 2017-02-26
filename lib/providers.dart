library providers;

import 'dart:html';
import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';
import 'package:firebase/firebase.dart';
import 'package:logging/logging.dart';
import 'package:google_maps/google_maps.dart';

part 'package:poseidon/src/providers/firebase.dart';
part 'package:poseidon/src/providers/geo.dart';
part 'package:poseidon/src/providers/noaa.dart';

/// A collection of common services.
const appProviders = const [];

/// The collection of singleton services. Only inject once.
const appSingletons = const [Firebase, Geo, Noaa];