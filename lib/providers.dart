library providers;

import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'dart:js' as js;

import 'package:js/js.dart';

import 'package:angular2/angular2.dart';
import 'package:firebase/firebase.dart';
import 'package:logging/logging.dart';
import 'package:google_maps/google_maps.dart';

import 'package:poseidon/utils.dart' as utils;

part 'package:poseidon/src/providers/firebase.dart';
part 'package:poseidon/src/providers/geo.dart';
part 'package:poseidon/src/providers/weather.dart';
part 'package:poseidon/src/providers/region.dart';
part 'package:poseidon/src/providers/location.dart';

/// A collection of common services.
const providers = const [];

/// The collection of singleton services. Only inject once.
const singletons = const [Firebase, Geo, Weather];
