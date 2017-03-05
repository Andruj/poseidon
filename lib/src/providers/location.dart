part of providers;

class Location {
  final LatLng position;

  Location(num lat, num lng) : this.position = new LatLng(lat, lng);

  Location.fromLatLng(this.position);

  get lat => position.lat;
  get lng => position.lng;

  Location.fromMap(Map json) : position = new LatLng(json['lat'], json['lng']);

  Map toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  @override
  String toString() {
    return '''

[Location
    (lat: $lat)
    (lng: $lng)]''';
  }
}
