import 'package:flutter/material.dart';
import 'package:ryc_flutter/battery/BatteryPage.dart';
import 'package:ryc_flutter/database/floor_db_page.dart';
import 'package:ryc_flutter/gmaps/MapsPage.dart';
import 'package:ryc_flutter/gps/GpsPage.dart';
import 'package:ryc_flutter/intents/IntentsPage.dart';
import 'package:ryc_flutter/local_notifications/NotificationsPage.dart';
import 'package:ryc_flutter/sensor/SensorPage.dart';
import 'package:ryc_flutter/shared_pref/SharedPrefPage.dart';
import 'package:ryc_flutter/theme_toggle/ThemeTogglePage.dart';
import 'package:ryc_flutter/videoplayer/VideoPlayerPage.dart';
import 'package:ryc_flutter/webview/WebViewPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<ThemeMode> _themeModeNotifier =
      ValueNotifier(ThemeMode.system);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _themeModeNotifier,
      builder: (context, ThemeMode themeMode, _) {
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
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              useMaterial3: true),
          themeMode: themeMode,
          home: ListPage(themeModeNotifier: _themeModeNotifier),
        );
      },
    );
  }
}

class ListPage extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;

  const ListPage({
    super.key,
    required this.themeModeNotifier,
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
            dense: true,
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
            dense: true,
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
            dense: true,
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
            dense: true,
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
          ),
          ListTile(
            dense: true,
            title: const Text("Light/Dark theme"),
            subtitle: const Text("Ejemplo de uso de theme toggle"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ThemeTogglePage(
                        title: "Theme Toggle Page",
                        themeModeNotifier: themeModeNotifier)),
              );
            },
          ),
          ListTile(
            dense: true,
            title: const Text("WebView"),
            subtitle: const Text("Ejemplo de uso de webView"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const WebViewPage(title: "WebView Toggle Page")),
              );
            },
          ),
          ListTile(
            dense: true,
            title: const Text("Intents"),
            subtitle:
                const Text("Ejemplo de uso de intents explicitos e implicitos"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const IntentsPage(title: "Intent Page")),
              );
            },
          ),
          ListTile(
            dense: true,
            title: const Text("Shared Preferences"),
            subtitle: const Text("Ejemplo de uso de preferencias locales"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SharedPrefPage(title: "SharedPref Page")),
              );
            },
          ),
          ListTile(
            dense: true,
            title: const Text("Información de batería"),
            subtitle:
                const Text("Ejemplo de consumo de información de batería"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const BatteryPage(title: "Battery Page")),
              );
            },
          ),
          ListTile(
            dense: true,
            title: const Text("Floor Database (Local DB)"),
            subtitle: const Text("Ejemplo de interacción con Floor DB"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const FloorDbPage(title: "Floor DB Page")),
              );
            },
          ),
          ListTile(
            dense: true,
            title: const Text("Sensores"),
            subtitle: const Text("Ejemplo de interacción con sensores"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SensorPage(title: "Sensores Page")),
              );
            },
          )
        ],
      ),
    );
  }
}
