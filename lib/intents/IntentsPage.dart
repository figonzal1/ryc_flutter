import 'package:android_intent_plus/android_intent.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ryc_flutter/intents/PhonePermission.dart';

var logger = Logger();

class IntentsPage extends StatefulWidget {
  const IntentsPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _IntentsPageState();
}

class _IntentsPageState extends State<IntentsPage> {
  Future<void> explicitIntentInstagram() async {
    await LaunchApp.openApp(
        androidPackageName: 'com.instagram.android', openStore: true);
  }

  Future<void> explicitGmail() async {
    await LaunchApp.openApp(
      androidPackageName: 'com.google.android.gm',
      openStore: true,
    );
  }

  Future<void> explicitGMaps() async {
    await LaunchApp.openApp(
      androidPackageName: 'com.google.android.apps.maps',
      openStore: true,
    );
  }

  void sendToEmail() {
    const AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.SENDTO',
        data:
            'mailto:correo_destino@example.com?subject=Asunto del email&body=Probando el envío de datos desde flutter');
    intent.launch();
  }

  void playVideoMedia() {
    const AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    intent.launch();
  }

  void geoRefMaps() {
    const AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: 'geo:47.6,-122.3',
    );
    intent.launch();
  }

  void openUrl() {
    const AndroidIntent intent = AndroidIntent(
      action: 'android.intent.action.VIEW',
      data: 'https://www.rycconsultores.cl',
    );
    intent.launch();
  }

  void dialIntent() {
    const AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.DIAL', data: 'tel:+5699999999');
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    var btnText = "Lanzar intent";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            intentExternalAppLauncher(context, btnText),
            intentCalls(context, btnText),
            intentImplicitos(context, btnText),
          ],
        ),
      ),
    );
  }

  Column intentImplicitos(BuildContext context, String btnText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Intents implícitos",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent email"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                sendToEmail();
              },
              child: Text(btnText)),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent video media"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                playVideoMedia();
              },
              child: Text(btnText)),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent geo coords (maps)"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                geoRefMaps();
              },
              child: Text(btnText)),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent web"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                openUrl();
              },
              child: Text(btnText)),
        ),
      ],
    );
  }

  Column intentExternalAppLauncher(BuildContext context, String btnText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Intents abrir apps",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text(
          "(external app launcher)",
        ),
        ListTile(
          dense: true,
          title: const Text("Intent explícito IG"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                explicitIntentInstagram();
              },
              child: Text(btnText)),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent explícito Gmail"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                explicitGmail();
              },
              child: Text(btnText)),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent explícito GMaps"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                explicitGMaps();
              },
              child: Text(btnText)),
        ),
      ],
    );
  }

  Column intentCalls(BuildContext context, String btnText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Intents de llamadas",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent Dial (teclado telefónico)"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                dialIntent();
              },
              child: Text(btnText)),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent Call (llamada directa)"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                callIntent();
              },
              child: Text(btnText)),
        ),
      ],
    );
  }
}
