library components;

import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase/firebase.dart';
import 'package:logging/logging.dart';

import 'package:poseidon/providers.dart';

part 'src/components/app_component.dart';
part 'src/components/login_component.dart';
part 'src/components/dashboard_component.dart';
part 'src/components/region_component.dart';
part 'src/components/regions_component.dart';
part 'src/components/watchlist_component.dart';
part 'src/components/profile_component.dart';

const rootComponent = AppComponent;
const appDirectives = const [
  AppComponent,
  LoginComponent,
  DashboardComponent,
  RegionComponent,
  WatchListComponent,
  RegionsComponent,
  ProfileComponent,
];
