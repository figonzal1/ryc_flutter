
import 'dart:async';

import 'package:location/location.dart' as loc;
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

var logger = Logger();

class GpsTrackerObserver {

  loc.Location location = loc.Location();

  //Listado historico de posiciones
  final List<loc.LocationData> _locations = [];

  //Observador de cambios de posicion
  late StreamSubscription subscription;


  void startTracking(Function callback) async {
    if (!(await isGPSEnabled())) {
      return;
    }
    if (!(await isPermissionGranted())) {
      return;
    }

    _observeLocation(callback);
  }

  void stopTracking() {
    subscription.cancel();
    _clearLocations();
  }

  void _observeLocation(Function callback) {
    subscription = location.onLocationChanged.listen((event) {
      logger.d("Location change: $event");
      _addLocation(event);
      callback(_locations);
    });
  }

  void _addLocation(loc.LocationData data) {
    _locations.add(data);
  }

  void _clearLocations() {
    _locations.clear();
  }

  Future<bool> isPermissionGranted() async =>
    await Permission.locationWhenInUse.isGranted;

Future<bool> isGPSEnabled() async =>
    await Permission.location.serviceStatus.isEnabled;

Future<bool> requestEnableGPS(bool gpsEnabled, loc.Location location) async {
  if (gpsEnabled) {
    logger.d("GPS already enabled");
    return true;
  } else {
    bool isGpsActive = await location.requestService();

    if (isGpsActive) {
      logger.d("GPS active");
      return true;
    } else {
      logger.d("GPS not active");
      return false;
    }
  }
}

Future<bool> requestLocationPermission() async {
  var permissionStatus = await Permission.locationWhenInUse.request();
  if (permissionStatus == PermissionStatus.granted) {
    logger.d("Loc. Permission granted");
    return true;
  } else {
    logger.d("Loc. permission denied");
    return false;
  }
}
}
