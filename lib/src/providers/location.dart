part of providers;

class Location {
  final LatLng position;

  Location(num lat, num lng) : this.position = new LatLng(lat, lng);

  Location.fromLatLng(this.position);

  get lat => position.lat;
  get lng => position.lng;

  static Location fromMap(Map json) {
    return new Location(json['lat'], json['lng']);
  }

  static Map toMap(Location location) {
    return {
      'lat': location.lat,
      'lng': location.lng,
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
