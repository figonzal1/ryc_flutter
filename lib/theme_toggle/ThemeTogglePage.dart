import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class ThemeTogglePage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeModeNotifier;
  final String title;

  const ThemeTogglePage(
      {super.key, required this.title, required this.themeModeNotifier});

  @override
  State<ThemeTogglePage> createState() => _ThemeTogglePageState();
}

class _ThemeTogglePageState extends State<ThemeTogglePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(
              Icons.sunny,
              size: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    logger.d("Button pressed");
                    widget.themeModeNotifier.value = ThemeMode.light;
                  },
                  child: const Text("Light"),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    logger.d("Button pressed");
                    widget.themeModeNotifier.value = ThemeMode.system;
                  },
                  child: const Text("System"),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    logger.d("Button pressed");
                    widget.themeModeNotifier.value = ThemeMode.dark;
                  },
                  child: const Text("Dark"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
