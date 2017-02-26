part of providers;

@Injectable()
class Noaa {
  final Logger log = new Logger('Noaa');
  static const stationsUrl = 'https://www.ncdc.noaa.gov/cdo-web/api/v2/stations';

  static const Map<String, String> headers = const {
    'token': 'GuDVnffJBlVYDqMmGVMYdypTZaXbCaZN'
  };

  /// Gets all NOAA stations within bounds (limited to 50).
  Future<Map> getStations(LatLngBounds bounds) {
    Completer<Map> completer = new Completer();

    HttpRequest
        .request(
            '$stationsUrl?extent=${bounds.toUrlValue(3)}',
            method: 'get',
            requestHeaders: headers)
        .then((HttpRequest request) {
      completer.complete(JSON.decode(request.response));
    });

    return completer.future;
  }
}
