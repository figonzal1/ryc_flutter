import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sensors_plus/sensors_plus.dart';

var logger = Logger();

class SensorPage extends StatefulWidget {
  const SensorPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  AccelerometerEvent? _accelerometerEvent;
  UserAccelerometerEvent? _userAccelerometerEvent;
  GyroscopeEvent? _gyroscopeEvent;
  MagnetometerEvent? _magnetometerEvent;

  StreamSubscription? accelerometerObserver;
  StreamSubscription? userAccelerometerObserver;
  StreamSubscription? gyroscopeObserver;
  StreamSubscription? magnetometerObserver;

  @override
  void initState() {
    super.initState();
    listenAccelerator();
  }

  @override
  void dispose() {
    super.dispose();
    accelerometerObserver?.cancel();
    userAccelerometerObserver?.cancel();
    gyroscopeObserver?.cancel();
    magnetometerObserver?.cancel();
  }

  void listenAccelerator() {
    accelerometerObserver = accelerometerEventStream().listen(
      (AccelerometerEvent event) {
        logger.d("EVENT: $event");
        setState(() {
          _accelerometerEvent = event;
        });
      },
      onError: (error) {
        // Logic to handle error
        // Needed for Android in case sensor is not available
      },
      cancelOnError: true,
    );

    userAccelerometerObserver = userAccelerometerEventStream().listen(
      (UserAccelerometerEvent event) {
        setState(() {
          _userAccelerometerEvent = event;
        });
      },
      onError: (error) {
        // Logic to handle error
        // Needed for Android in case sensor is not available
      },
      cancelOnError: true,
    );

    gyroscopeObserver = gyroscopeEventStream().listen(
      (GyroscopeEvent event) {
        setState(() {
          _gyroscopeEvent = event;
        });
      },
      onError: (error) {
        // Logic to handle error
        // Needed for Android in case sensor is not available
      },
      cancelOnError: true,
    );

    magnetometerObserver = magnetometerEventStream().listen(
      (MagnetometerEvent event) {
        setState(() {
          _magnetometerEvent = event;
        });
      },
      onError: (error) {
        // Logic to handle error
        // Needed for Android in case sensor is not available
      },
      cancelOnError: true,
    );
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
            Text("$_accelerometerEvent"),
            const SizedBox(
              height: 20,
            ),
            Text("$_userAccelerometerEvent"),
            const SizedBox(
              height: 20,
            ),
            Text("$_gyroscopeEvent"),
            const SizedBox(
              height: 20,
            ),
            Text("$_magnetometerEvent"),
          ],
        ),
      ),
    );
  }
}
