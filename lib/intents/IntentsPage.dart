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

  void sendToEmail() {
    const AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.SENDTO',
        data:
            'mailto:correo_destino@example.com?subject=Asunto del email&body=Probando el envío de datos desde flutter');
    intent.launch();
  }

  void sendToEmailWithAttach() {
    const AndroidIntent intent = AndroidIntent(
        action: 'android.intent.action.SEND',
        data:
            'mailto:correo_destino@example.com?subject=Asunto del email con adjuntos&body=Probando el envío de datos desde flutter',
        type: "images/*");
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
            intentEmails(context, btnText),
          ],
        ),
      ),
    );
  }

  Column intentEmails(BuildContext context, String btnText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Intents de email",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent implícito email"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                sendToEmail();
              },
              child: Text(btnText)),
        ),
        ListTile(
          dense: true,
          title: const Text("Intent implícito email"),
          trailing: MaterialButton(
              color: Theme.of(context).colorScheme.inversePrimary,
              onPressed: () {
                sendToEmail();
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
