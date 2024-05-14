import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:ryc_flutter/gps/GpsTrackerObserver.dart';

var logger = Logger();

class GpsPage extends StatefulWidget {
  const GpsPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<GpsPage> createState() => _GpsPageState();
}

class _GpsPageState extends State<GpsPage> {
  bool permissionGranted = false;
  bool gpsEnabled = false;
  bool trackingEnabled = false;

  Location location = Location();
  List<LocationData> locations = [];

  GpsTrackerObserver gpsTracker = GpsTrackerObserver();

  //Stream para escuchar gps
  late StreamSubscription subscription;

  void checkStatus() async {
    bool isGpsEnabled = await gpsTracker.isGPSEnabled();
    bool isLocationPermissionGranted = await gpsTracker.isPermissionGranted();

    logger.d("Permission granted: $permissionGranted");
    logger.d("GPS enabled: $isGpsEnabled");

    setState(() {
      permissionGranted = isLocationPermissionGranted;
      gpsEnabled = isGpsEnabled;
    });
  }

  void startTracking() {
    gpsTracker.startTracking((List<LocationData> locs) {
      setState(() {
        locations = locs;
      });
    });
    setState(() {
      trackingEnabled = true;
    });
  }

  void stopTracking() {
    gpsTracker.stopTracking();
    setState(() {
      trackingEnabled = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          ListTile(
            dense: true,
            title: gpsEnabled
                ? const Text("Estado GPS: activado")
                : const Text("Estado GPS: desactivado"),
            trailing: Switch(
              value: gpsEnabled,
              onChanged: (value) async {
                var result =
                    await gpsTracker.requestEnableGPS(gpsEnabled, location);
                setState(() {
                  gpsEnabled = result;
                });
              },
            ),
          ),
          ListTile(
            dense: true,
            title: permissionGranted
                ? const Text("Permiso GPS: otorgado")
                : const Text("Permiso GPS: no otorgado"),
            trailing: Switch(
              value: permissionGranted,
              onChanged: gpsEnabled
                  ? (value) async {
                      var result = await gpsTracker.requestLocationPermission();
                      setState(() {
                        permissionGranted = result;
                      });
                    }
                  : null,
            ),
          ),
          ListTile(
            dense: true,
            title: const Text("Location"),
            trailing: Switch(
              value: trackingEnabled,
              onChanged: permissionGranted && gpsEnabled
                  ? (value) {
                      if (value) {
                        startTracking();
                      } else {
                        stopTracking();
                      }
                    }
                  : null,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              var lat = locations[index].latitude;
              var long = locations[index].longitude;

              return ListTile(
                title: Text("$lat $long"),
              );
            },
          ))
        ],
      )),
    );
  }
}
