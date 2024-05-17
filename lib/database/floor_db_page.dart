import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ryc_flutter/database/widgets/db_init.dart';
import 'package:ryc_flutter/database/widgets/person_list.dart';

var logger = Logger();

class FloorDbPage extends StatefulWidget {
  const FloorDbPage({super.key, required this.title});

  final String title;

  @override
  State<FloorDbPage> createState() => _FloorDbPageState();
}

class _FloorDbPageState extends State<FloorDbPage> {
  @override
  Widget build(BuildContext context) {
    return DbInit(child: PersonList(title: widget.title));
  }
}
