import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

var logger = Logger();

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<Contact>? _contactList;

  Future<List<Contact>> _getContacts() async {
    return await FlutterContacts.getContacts();
  }

  Future<bool> _isContactPermissionGranted() async =>
      await Permission.contacts.isGranted;

  void checkState() async {
    bool result = await _isContactPermissionGranted();

    if (!result) {
      _requestContactPermission();
    } else {
      setState(() async {
        _contactList = await _getContacts();
      });
    }
  }

  Future<bool> _requestContactPermission() async {
    var permissionStatus = await Permission.contacts.request();
    if (permissionStatus == PermissionStatus.granted) {
      logger.d("Contact permission granted");
      return true;
    } else {
      logger.d("Contact permission denied");
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: _contactList!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_contactList![index].displayName),
              );
            }));
  }
}
