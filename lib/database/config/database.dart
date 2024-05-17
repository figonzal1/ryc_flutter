import 'dart:async';
import 'package:floor/floor.dart';
import 'package:ryc_flutter/database/config/dao.dart';
import 'package:ryc_flutter/database/config/entities.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there


@Database(version: 1, entities: [Person, Pet])
abstract class AppDatabase extends FloorDatabase {
  PersonDao get personDao;
}
