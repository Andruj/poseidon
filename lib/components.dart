library components;

import 'dart:html';

import 'package:angular2/core.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase/firebase.dart';
import 'package:logging/logging.dart';

import 'package:poseidon/providers.dart';

part 'src/components/app_component.dart';

const rootComponent = AppComponent;
const appDirectives = const [AppComponent];