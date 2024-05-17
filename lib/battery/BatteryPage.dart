import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ryc_flutter/battery/BatteryStateDisplay.dart';

var logger = Logger();

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  var battery = Battery();

  Future<int> getBatteryLevel() async {
    return await battery.batteryLevel;
  }

  Future<bool> isBatterySaver() async {
    return await battery.isInBatterySaveMode;
  }

  String formatBatterySave(bool batterySave) {
    if (batterySave) {
      return "Activado";
    } else {
      return "Desactivado";
    }
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Información Batería",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            FutureBuilder<List<dynamic>>(
              future: Future.wait([getBatteryLevel(), isBatterySaver()]),
              builder: (BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Atributo',
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Valor',
                          ),
                        ),
                      ],
                      rows: <DataRow>[
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text('Nivel de batería')),
                            DataCell(Text('${snapshot.data?[0]}%')),
                          ],
                        ),
                        const DataRow(
                          cells: <DataCell>[
                            DataCell(Text('Estado de batería')),
                            DataCell(BatteryStateDisplay()),
                          ],
                        ),
                        DataRow(
                          cells: <DataCell>[
                            const DataCell(Text('Modo ahorro')),
                            DataCell(
                                Text(formatBatterySave(snapshot.data?[1]))),
                          ],
                        ),
                        // Puedes agregar más filas aquí...
                      ],
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
