import 'package:floor/floor.dart';

@Entity()
class Person {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String name;

  Person(this.name);
}

@Entity(foreignKeys: [
  ForeignKey(childColumns: ['person_id'], parentColumns: ['id'], entity: Person)
])
class Pet {
  @PrimaryKey()
  final int id;

  final String name;

  @ColumnInfo(name: 'person_id')
  final int personId;

  Pet(this.id, this.name, this.personId);
}
