import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages/HomePage.dart';
import '../main.dart';

class welcomeText extends StatefulWidget {
  const welcomeText({super.key});

  @override
  State<welcomeText> createState() => _welcomeTextState();
}

class _welcomeTextState extends State<welcomeText> {
  final now = DateTime.now();
  var timeDiff;
  var timeUntil;
  var timeUntilFormatted;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _upadateTimeLeft() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(
          () {
            if (timeUntil > const Duration(seconds: 1)) {
              if (lastGenerated != null) {
                timeDiff = DateTime.now().difference(lastGenerated!);
                timeUntil = const Duration(hours: 24) - timeDiff;
                timeUntilFormatted = timeUntil.toString().split('.')[0];
              }
            } else {
              timer.cancel();
            }
          },
        );
      },
    );
  }

  // Loading counter value on start
  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(
      () {
        lastGenerated =
            DateTime.fromMillisecondsSinceEpoch((prefs.getInt('counter') ?? 0));
      },
    );
  }

  // Incrementing counter after click
  void _incrementCounter(time) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt('counter', time);
    });
  }

  // Incrementing counter after click
  void _incrementIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentIndex = ((prefs.getInt('index') ?? 0) + 1) % 17;
      prefs.setInt('index', currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (lastGenerated != null) {
      timeDiff = DateTime.now().difference(lastGenerated!);
      timeUntil = const Duration(hours: 24) - timeDiff;
      if (timeUntil > const Duration(seconds: 1)) {
        if (lastGenerated != null) {
          _upadateTimeLeft();
        }
      }
    }

    if (lastGenerated == null || timeDiff > const Duration(hours: 24)) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your daily rizz is ready",
              style: TextStyle(fontSize: 45),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 200),
              child: ElevatedButton(
                child: const Text("Reveal rizz"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyHomePage(),
                    ),
                  );
                  setState(
                    () {
                      lastGenerated = DateTime.now();
                      _incrementIndex();
                    },
                  );
                  _incrementCounter(now.millisecondsSinceEpoch);
                  _upadateTimeLeft();
                },
              ),
            )
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your daily rizz is not ready",
              style: TextStyle(fontSize: 40),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Your new rizz will be ready in: $timeUntilFormatted",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            // Circle showing how much time is left, being timeUntil divided by 24 hours
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: timeUntil.inSeconds / 86400,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                ),
              ),
            ),
            // Button to see previous rizz
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 200),
              child: ElevatedButton(
                child: const Text("See previous rizz"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyHomePage(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      );
    }
  }
}
