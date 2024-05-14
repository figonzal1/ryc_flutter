import 'package:flutter/material.dart';
import 'package:ryc_flutter/gmaps/MapsPage.dart';
import 'package:ryc_flutter/gps/GpsPage.dart';
import 'package:ryc_flutter/local_notifications/NotificationsPage.dart';
import 'package:ryc_flutter/videoplayer/VideoPlayerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter RyC',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Flutter RyC"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text("GPS"),
            subtitle: const Text("Ejemplo de trackeo con GPS"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const GpsPage(title: "Gps Page")),
              );
            },
          ),
          ListTile(
            title: const Text("Google Maps"),
            subtitle: const Text("Ejemplo de uso de mapa"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MapsPage(title: "Google Maps Page")),
              );
            },
          ),
          ListTile(
            title: const Text("Notificaciones Locales"),
            subtitle:
                const Text("Ejemplo de uso de notificaciones offline/locales"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const NotificationsPage(title: "Notif. Locales Page")),
              );
            },
          ),
          ListTile(
            title: const Text("Reproductor de video"),
            subtitle: const Text("Ejemplo de uso de media player"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const VideoPlayerPage(title: "VideoPlayer Page")),
              );
            },
          )
        ],
      ),
    );
  }
}
