import 'package:flutter/material.dart';
import 'package:rizzify/Components/WelcomeText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class Startpage extends StatefulWidget {
  const Startpage({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  @override
  void initState() {
    super.initState();
    _loadIndex();
  }

  // Loading counter value on start
  void _loadIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentIndex = (prefs.getInt('index') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Rizzify"),
        ),
        body: const welcomeText(),
      ),
    );
  }
}
