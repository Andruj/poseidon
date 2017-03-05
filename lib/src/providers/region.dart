part of providers;

class Region {
  static const locationsKey = "locations";

  String name;
  Map<String, Location> locations;

  Region.fromMap(Map json) : this.name = json['name'] {
    Map<String, Map> data = json[locationsKey] ?? {};

    this.locations =
        new Map.fromIterables(data.keys, data.values.map(Location.fromMap));
  }

  Map toMap() {
    return {
      'name': name,
      locationsKey: new Map.fromIterables(
          locations.keys, locations.values.map(Location.toMap)),
    };
  }

  Region(this.name, this.locations);

  String getLocationKey(Location location) =>
      locations.keys.firstWhere((key) => locations[key] == location);

  @override
  String toString() {
    return '''

[Region
    (name: $name)
    (locations: ${locations.length})]''';
  }
}
