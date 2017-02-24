part of providers;

@Injectable()
class Geo {
  Future<LatLng> get currentLocation async {
    if (window.navigator.geolocation != null) {
      final Geoposition userLoc =
          await window.navigator.geolocation.getCurrentPosition();
      return new LatLng(userLoc.coords.latitude, userLoc.coords.longitude);
    } else {
      return new LatLng(-120, 30);
    }
  }
}
