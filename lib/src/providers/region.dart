part of providers;

class Region {
  static const locationsKey = "locations";

  String name;
  Map<String, Location> locations = {};
  Map<String, DateTime> watchlist = {};

  Region.fromMap(Map json) : this.name = json['name'] {
    Map<String, Map> _locations = json[locationsKey] ?? {};
    Map<String, String> _watchlist = json['watchlist'] ?? {};

    this.locations = new Map.fromIterables(
        _locations.keys, _locations.values.map((json) => new Location.fromMap(json)));

    this.watchlist = new Map.fromIterables(_watchlist.keys, _watchlist.values.map(DateTime.parse));
  }

  Map toMap() {
    return {
      'name': name,
      locationsKey: new Map.fromIterables(
          locations.keys, locations.values.map((Location l) => l.toMap())),
      'watchlist': new Map.fromIterables(watchlist.keys, watchlist.values.map((date) => date.toIso8601String()))
    };
  }

  Region(this.name);

  String getLocationId(Location location) =>
      locations.keys.firstWhere((key) => locations[key] == location);

  @override
  String toString() {
    return '''

[Region
    (name: $name)
    (locations: ${locations.length})
    (watchlist: ${watchlist.length})]''';
  }
}
