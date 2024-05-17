import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ryc_flutter/battery/BatteryPage.dart';
import 'package:ryc_flutter/database/dao.dart';
import 'package:ryc_flutter/database/entities.dart';
import 'package:ryc_flutter/database/widgets/db_init.dart';

class PersonList extends StatefulWidget {
  PersonList({super.key, required this.title});

  String title;
  @override
  State<StatefulWidget> createState() => _PersonListState();
}

class _PersonListState extends State<PersonList> {
  late Future<List<Person>> _personList;
  late String name = "";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final database = InheritedDatabase.of(context)!.database;
    final personDao = database.personDao;

    _loadPerson(personDao);
  }

  void _loadPerson(PersonDao personDao) {
    setState(() {
      _personList = personDao.findAllPerson();
    });
  }

  void _addPerson(String name) {
    final database = InheritedDatabase.of(context)!.database;
    final personDao = database.personDao;

    var person = Person(name);
    personDao.insertPerson(person);

    Navigator.pop(context);
    _loadPerson(personDao);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: _personList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data.isEmpty) {
              return const Center(child: Text('Listado vacío'));
            } else {
              final persons = snapshot.data;

              return ListView.builder(
                  itemBuilder: (context, index) {
                    final person = persons[index];
                    return ListTile(title: Text(person.name));
                  },
                  itemCount: persons.length);
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              useRootNavigator: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Agregar persona",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                name = value;
                              }
                            },
                            decoration: const InputDecoration(
                                hintText: "Nombre persona",
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          MaterialButton(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              child: const Text("Guardar"),
                              onPressed: () {
                                if (name.isNotEmpty) {
                                  logger.d("Button pressed");
                                  _addPerson(name);
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
