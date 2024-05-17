import 'package:flutter/material.dart';
import 'package:ryc_flutter/battery/BatteryPage.dart';
import 'package:ryc_flutter/database/config/database.dart';

class DbInit extends StatefulWidget {
  final Widget child;

  const DbInit({super.key, required this.child});

  @override
  State<StatefulWidget> createState() => _DbInitState();
}

class _DbInitState extends State<DbInit> {
  late Future<AppDatabase> _dbFuture;

  @override
  void initState() {
    super.initState();

    _dbFuture = $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _dbFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            logger.e("Error init DB");
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final database = snapshot.data;
            return InheritedDatabase(database: database, child: widget.child);
          }
        });
  }
}

class InheritedDatabase extends InheritedWidget {
  final AppDatabase database;

  const InheritedDatabase(
      {super.key, required super.child, required this.database});

  static InheritedDatabase? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedDatabase>();
  }

  @override
  bool updateShouldNotify(InheritedDatabase oldWidget) {
    return oldWidget.database != database;
  }
}
