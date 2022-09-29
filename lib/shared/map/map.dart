import 'package:geolocator/geolocator.dart';

initMapSettings() async {
  bool serviceEnabled;
  LocationPermission? permission;

// Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
}

class LocationData {
  double? latitude; // Latitude, in degrees
  double? longitude; // Longitude, in degrees
  double?
      accuracy; // Estimated horizontal accuracy of this location, radial, in meters
  double? altitude; // In meters above the WGS 84 reference ellipsoid
  double? speed; // In meters/second
  double? speedAccuracy; // In meters/second, always 0 on iOS
  double?
      heading; // Heading is the horizontal direction of travel of this device, in degrees
  double? time; // timestamp of the LocationData
  bool? isMock; // Is the location currently mocked
}
