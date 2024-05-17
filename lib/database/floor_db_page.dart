import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ryc_flutter/database/dao.dart';
import 'package:ryc_flutter/database/database.dart';
import 'package:ryc_flutter/database/entities.dart';

var logger = Logger();

class FloorDbPage extends StatefulWidget {
  const FloorDbPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<FloorDbPage> createState() => _FloorDbPageState();
}

class _FloorDbPageState extends State<FloorDbPage> {
  var database;
  var personDao;
  String name = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    database = $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  Future<void> savePerson(PersonDao personDao) async {
    var person = Person(0, name);
    await personDao.insertPerson(person);
  }

  Future<void> getList(PersonDao personDao) async {
    var listado = await personDao.findAllPerson();

    if (!listado.isEmpty) {
      logger.d("Insert ${listado[0].name}");
    } else {
      logger.d("Listado personas, vacío");
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(
                  "Crear persona",
                  style: TextStyle(fontSize: 30),
                )),
            FutureBuilder<AppDatabase>(
                future: database,
                builder: (BuildContext context,
                    AsyncSnapshot<AppDatabase> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var personDao = snapshot.data!.personDao;

                    getList(personDao);

                    return Column(children: [
                      TextField(
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Nombre",
                            constraints: BoxConstraints.tightFor(width: 250)),
                      ),
                      MaterialButton(
                        onPressed: () async {
                          logger.d("Boton presionado");
                          savePerson(personDao);
                        },
                        color: Theme.of(context).colorScheme.inversePrimary,
                        child: const Text("Guardar persona"),
                      )
                    ]);
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return const Text("Ocurrió un error al construir la bd");
                  }
                }),
          ],
        ),
      ),
    );
  }
}
