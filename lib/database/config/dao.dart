import 'package:floor/floor.dart';
import 'package:ryc_flutter/database/config/entities.dart';

@dao
abstract class PersonDao {
  @Query("SELECT * FROM Person")
  Future<List<Person>> findAllPerson();

  @Insert(onConflict: OnConflictStrategy.fail)
  Future<void> insertPerson(Person person);

  @Query("SELECT * FROM Person WHERE id = :id")
  Future<Person?> findPersonById(int id);
}
