part of providers;

@Injectable()
class Weather {
  final Logger log = new Logger('Weather');

  final key = 'f0350386bab3aa17c3e5f09356d17a2d';
  final url = 'http://api.openweathermap.org/data/2.5/forecast';

  Future<Forecast> getForecast(Location location) async {
    final data = await HttpRequest
        .getString('$url?lat=${location.lat}&lon=${location.lng}&APPID=$key');

    return new Forecast.fromMap(JSON.decode(data));
  }
}

class Forecast {
  final Logger log = new Logger('Forecast');

  final String name;
  final num id;
  final LatLng position;
  final List<Snapshot> data;

  Forecast.fromMap(Map json)
      : name = json['city']['name'],
        id = json['city']['id'],
        position = new LatLng(
            json['city']['coord']['lat'], json['city']['coord']['lon']),
        data = json['list'].map((snap) => new Snapshot.fromMap(snap)).toList();

  @override
  String toString() {
    return '''

[Forecast
    (name: $name)
    (id: $id)
    (position: $position)
    (data: ${data.length})]''';
  }
}

class Snapshot {
  final Logger log = new Logger('Snapshot');
  final DateTime time;
  final num temp;
  final int humidity;
  final int clouds;
  final num wind;
  final num direction;
  bool _isCombined = false;

  Snapshot.fromMap(Map json)
      : time = new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temp = json['main']['temp'],
        humidity = json['main']['humidity'],
        clouds = json['clouds']['all'],
        wind = json['wind']['speed'],
        direction = json['wind']['deg'];

  Snapshot.fromSnapshots(List<Snapshot> snapshots)
      : _isCombined = true,
        time = snapshots.first.time,
        temp =
            snapshots.map((snap) => snap.temp).reduce(_sum) / snapshots.length,
        humidity = snapshots.map((snap) => snap.humidity).reduce(_sum) /
            snapshots.length,
        clouds = snapshots.map((snap) => snap.clouds).reduce(_sum) /
            snapshots.length,
        wind =
            snapshots.map((snap) => snap.wind).reduce(_sum) / snapshots.length,
        direction = snapshots.map((snap) => snap.direction).reduce(_sum) /
            snapshots.length;


  static _sum(a, b) => a + b;

  get isCombined => _isCombined;

  @override
  String toString() {
    return '''

[Snapshot
    (isCombined: $isCombined)
    (time: $time)
    (temp: $temp celsius)
    (humidity: $humidity%)
    (clouds: $clouds%)
    (wind: $wind m/s)
    (direction: $direction deg)]''';
  }
}
