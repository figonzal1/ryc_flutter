import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

var logger = Logger();

class SharedPrefPage extends StatefulWidget {
  const SharedPrefPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SharedPrefPage> createState() => _SharedPrefPageState();
}

class _SharedPrefPageState extends State<SharedPrefPage> {
  String valueKey = "shared_key";
  String value = "undefined";

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> saveValue() async {
    final SharedPreferences prefs = await _prefs;

    setState(() {
      prefs.setString(valueKey, value).then((bool success) {
        if (success) {
          logger.d("Valor guardado");
        } else {
          logger.d("Error al guardar");
        }
      });
    });
  }

  Future<void> getValue() async {
    final SharedPreferences prefs = await _prefs;

    logger.d("Get value");
    setState(() {
      value = prefs.getString(valueKey) ?? "undefined";
    });
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
            Text("Cargando datos: $value"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getValue();
              },
              child: const Text('Cargar valor'),
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: (newValue) {
                value = newValue;
              },
              decoration: const InputDecoration(
                  constraints: BoxConstraints.tightFor(width: 250),
                  hintText: "Ingresa un string",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                saveValue();
              },
              child: const Text('Guardar valor'),
            ),
          ],
        ),
      ),
    );
  }
}
