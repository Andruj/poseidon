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
  bool _combined = false;
  bool watching = false;

  Snapshot.fromMap(Map json)
      : time = new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
        temp = json['main']['temp'],
        humidity = json['main']['humidity'],
        clouds = json['clouds']['all'],
        wind = json['wind']['speed'],
        direction = json['wind']['deg'];

  Snapshot.fromSnapshots(List<Snapshot> snapshots)
      : _combined = true,
        time = snapshots.first.time,
        temp = utils.avg(snapshots, (Snapshot s) => s.temp),
        humidity = utils.avg(snapshots, (Snapshot s) => s.humidity).round(),
        clouds = utils.avg(snapshots, (Snapshot s) => s.clouds).round(),
        wind = utils.avg(snapshots, (Snapshot s) => s.wind),
        direction = utils.avg(snapshots, (Snapshot s) => s.direction);

  get combined => _combined;


  @override
  String toString() {
    return '''

[Snapshot
    (combined: $combined)
    (watching: $watching)
    (time: ${time.toLocal()})
    (temp: $temp kelvin)
    (humidity: $humidity%)
    (clouds: $clouds%)
    (wind: $wind m/s)
    (direction: $direction deg)]''';
  }
}
