part of providers;

class Region {
  static const locationsKey = "locations";

  String name;
  Map<String, Location> locations;

  Region.fromMap(Map json) : this.name = json['name'] {
    Map<String, Map> data = json[locationsKey] ?? {};

    this.locations = new Map.fromIterables(
        data.keys, data.values.map((json) => new Location.fromMap(json)));
  }

  Map toMap() {
    return {
      'name': name,
      locationsKey: new Map.fromIterables(
          locations.keys, locations.values.map((Location l) => l.toMap()))
    };
  }

  Region(this.name, this.locations);

  String getLocationId(Location location) =>
      locations.keys.firstWhere((key) => locations[key] == location);

  @override
  String toString() {
    return '''

[Region
    (name: $name)
    (locations: ${locations.length})]''';
  }
}
