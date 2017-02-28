import 'package:google_maps/google_maps.dart';

final MapOptions options = new MapOptions()
  ..zoom = 8
  ..center = new LatLng(35.2828, -120.6596)
  ..styles = [];

final MapOptions blankOptions = new MapOptions()
  ..styles = []
  ..disableDefaultUI = false;

final MapOptions editOptions = new MapOptions()
  ..styles = addModeStyles
  ..disableDefaultUI = true;

List<MapTypeStyle> addModeStyles = [
  new MapTypeStyle()
    ..elementType = MapTypeStyleElementType.GEOMETRY
    ..stylers = [new MapTypeStyler()..color = "#1d2c4d"],
  new MapTypeStyle()
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [new MapTypeStyler()..color = "#8ec3b9"],
  new MapTypeStyle()
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_STROKE
    ..stylers = [new MapTypeStyler()..color = "#1a3646"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ADMINISTRATIVE_COUNTRY
    ..elementType = MapTypeStyleElementType.GEOMETRY_STROKE
    ..stylers = [new MapTypeStyler()..color = "#4b6878"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ADMINISTRATIVE_COUNTRY
    ..elementType = MapTypeStyleElementType.GEOMETRY_STROKE
    ..stylers = [new MapTypeStyler()..color = "#4b6878"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ADMINISTRATIVE_LAND_PARCEL
    ..elementType = MapTypeStyleElementType.LABELS
    ..stylers = [new MapTypeStyler()..visibility = "off"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ADMINISTRATIVE_LAND_PARCEL
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [new MapTypeStyler()..color = "#64779e"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ADMINISTRATIVE_PROVINCE
    ..elementType = MapTypeStyleElementType.GEOMETRY_STROKE
    ..stylers = [new MapTypeStyler()..color = "#4b6878"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.LANDSCAPE_MAN_MADE
    ..elementType = MapTypeStyleElementType.GEOMETRY_STROKE
    ..stylers = [new MapTypeStyler()..color = "#334e87"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.LANDSCAPE_NATURAL
    ..elementType = MapTypeStyleElementType.GEOMETRY
    ..stylers = [new MapTypeStyler()..color = "#023e58"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI
    ..elementType = MapTypeStyleElementType.GEOMETRY
    ..stylers = [new MapTypeStyler()..color = "#283d6a"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI
    ..elementType = MapTypeStyleElementType.LABELS_TEXT
    ..stylers = [new MapTypeStyler()..visibility = "off"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [new MapTypeStyler()..color = "#6f9ba5"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_STROKE
    ..stylers = [new MapTypeStyler()..color = "#1d2c4d"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_BUSINESS
    ..stylers = [new MapTypeStyler()..visibility = "off"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_PARK
    ..elementType = MapTypeStyleElementType.GEOMETRY_FILL
    ..stylers = [new MapTypeStyler()..color = "#023e58"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.POI_PARK
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [new MapTypeStyler()..color = "#3C7680"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD
    ..elementType = MapTypeStyleElementType.GEOMETRY
    ..stylers = [new MapTypeStyler()..color = "#304a7d"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD
    ..elementType = MapTypeStyleElementType.LABELS_ICON
    ..stylers = [new MapTypeStyler()..visibility = "off"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [new MapTypeStyler()..color = "#98a5be"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_STROKE
    ..stylers = [new MapTypeStyler()..color = "#1d2c4d"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_ARTERIAL
    ..elementType = MapTypeStyleElementType.LABELS
    ..stylers = [new MapTypeStyler()..visibility = "off"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_HIGHWAY
    ..elementType = MapTypeStyleElementType.GEOMETRY
    ..stylers = [new MapTypeStyler()..color = "#2c6675"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_HIGHWAY
    ..elementType = MapTypeStyleElementType.GEOMETRY_STROKE
    ..stylers = [new MapTypeStyler()..color = "#255763"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_HIGHWAY
    ..elementType = MapTypeStyleElementType.LABELS
    ..stylers = [new MapTypeStyler()..visibility = "off"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_HIGHWAY
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_FILL
    ..stylers = [new MapTypeStyler()..color = "#b0d5ce"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_HIGHWAY
    ..elementType = MapTypeStyleElementType.LABELS_TEXT_STROKE
    ..stylers = [new MapTypeStyler()..color = "#023e58"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.ROAD_LOCAL
    ..stylers = [new MapTypeStyler()..visibility = "off"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.WATER
    ..elementType = MapTypeStyleElementType.GEOMETRY
    ..stylers = [new MapTypeStyler()..color = "#3a4762"],
  new MapTypeStyle()
    ..featureType = MapTypeStyleFeatureType.TRANSIT
    ..stylers = [new MapTypeStyler()..visibility = "off"],
];
