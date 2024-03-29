library components;

import 'dart:html' hide Event, MouseEvent;
import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular2_components/angular2_components.dart';
import 'package:firebase/firebase.dart';
import 'package:logging/logging.dart';
import 'package:quiver/iterables.dart' as quiver;

import 'package:google_maps/google_maps.dart';

import 'package:poseidon/providers.dart' as app;
import 'package:poseidon/src/components/map_config.dart' as map_config;
import 'package:poseidon/pipes.dart';
import 'package:poseidon/utils.dart' as utils;

part 'src/components/app_component.dart';
part 'src/components/login_component.dart';
part 'src/components/dashboard_component.dart';
part 'src/components/region_component.dart';
part 'src/components/regions_component.dart';
part 'src/components/profile_component.dart';
part 'src/components/map_component.dart';
part 'src/components/calendar_component.dart';
part 'src/components/details_component.dart';
part 'src/components/snapshot_component.dart';
part 'src/components/overview_component.dart';
part 'src/components/wind_range_component.dart';
part 'src/components/watch_card_component.dart';

const rootComponent = AppComponent;
const appDirectives = const [
  AppComponent,
  LoginComponent,
  DashboardComponent,
  RegionComponent,
  RegionsComponent,
  ProfileComponent,
  MapComponent,
  CalendarComponent,
  SnapshotComponent,
  DetailsComponent,
  OverviewComponent,
  WindRangeComponent,
  WatchCardComponent,
];
