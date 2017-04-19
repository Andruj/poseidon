part of providers;

class Location {
  final LatLng position;
  Forecast forecast;

  Location(num lat, num lng) : this.position = new LatLng(lat, lng);

  Location.fromLatLng(this.position);

  get lat => position.lat;
  get lng => position.lng;

  Location.fromMap(Map json)
      : position = new LatLng(json['lat'], json['lng']),
        forecast = json['forecast'] != null
            ? new Forecast.fromMap(json['forecast'])
            : null;

  Map toMap() {
    return {
      'lat': lat,
      'lng': lng,
      'forecast': {},
    };
  }

  @override
  String toString() {
    return '''

[Location
    (lat: $lat)
    (lng: $lng)
    (forecast: $forecast)]''';
  }
}
