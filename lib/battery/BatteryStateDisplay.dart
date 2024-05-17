import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class BatteryStateDisplay extends StatefulWidget {
  const BatteryStateDisplay({super.key});

  @override
  State<BatteryStateDisplay> createState() => _BatteryStateDisplayState();
}

class _BatteryStateDisplayState extends State<BatteryStateDisplay> {
  var battery = Battery();
  BatteryState _batteryState = BatteryState.unknown;
  late StreamSubscription<BatteryState> _batteryStateSubscription;

  String formatBatteryState(BatteryState batteryState) {
    if (batteryState == BatteryState.charging) {
      return "Cargando";
    } else if (batteryState == BatteryState.connectedNotCharging) {
      return "Conectado, no cargando";
    } else if (batteryState == BatteryState.discharging) {
      return "Descargando";
    } else if (batteryState == BatteryState.full) {
      return "Full carga";
    }

    return "Desconocido";
  }

  @override
  void initState() {
    super.initState();
    _batteryStateSubscription =
        battery.onBatteryStateChanged.listen((BatteryState state) {
      setState(() {
        _batteryState = state;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _batteryStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(formatBatteryState(_batteryState));
  }
}
