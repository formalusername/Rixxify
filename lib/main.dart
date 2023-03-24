import 'package:flutter/material.dart';
import 'Pages/Startpage.dart';

DateTime? lastGenerated;
int currentIndex = 0;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Startpage(
      context: context,
    );
  }
}
