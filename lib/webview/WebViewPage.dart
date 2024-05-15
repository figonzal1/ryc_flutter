import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

var logger = Logger();

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..clearCache()
    ..loadRequest(
        Uri.parse("http://192.168.10.30:7206/?token=606231a5d68dbf001743e998"))
    ..setNavigationDelegate(NavigationDelegate(
      onProgress: (progress) {
        logger.d("Progress webview $progress");
      },
      onPageStarted: (url) {
        logger.d("Page Started");
      },
      onPageFinished: (url) {
        logger.d("Page finished");
      },
    ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
