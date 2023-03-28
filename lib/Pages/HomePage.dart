import 'package:flutter/material.dart';
import 'package:rizzify/Pages/SecretPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = myQuestions[currentIndex];
  String buttonText = "Answer";
  bool isChanged = true;

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

  // Incrementing counter after click
  void _incrementIndex() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentIndex = ((prefs.getInt('index') ?? 0) + 1) % 17;
      prefs.setInt('index', currentIndex);
    });
  }

  static List<String> myQuestions = [
    'Are you a pile of metal oxide and aluminium, also known as Thermite?',
    'Er du et proton',
    'Har du en enorm masse',
    'Er du en kugelblitz',
    'Er du oksygen',
    "Are you made of quarks?",
    "Are you a neutrino?",
    "Are you a virus?",
    "You must be a petri dish.",
    "Er du en celle?",
    "Du må være et elektron",
    "Are you a black hole",
    "Are you a bacteria",
    "¿Eres un átomo?",
    "¿Eres una célula madre?",
    "Er du en mikroorganisme?",
    "Du må være et foton.",
    "Are you an infectious microorganism?",
  ];
  List<String> myAnswers = [
    'Because you are one of the hottest things i know.',
    'Fordi du fyller meg med positiv energi',
    'Fordi som newton forutså, er jeg tiltrukket av deg',
    'Hvordan ellers kan du fylle verden med lys og være så heit at du bryter fysiske lover',
    'For jeg kan ikke forestille meg en verden uten deg, jeg tror jeg er avhengig',
    "Because you have both charm and beauty, even though you might be a little strange",
    "Because i feel like we have a strong connection",
    "Because you´ve infected my heart.",
    "Because i want to take a closer look at what´s growing between us.",
    "Fordi du er grunnleggende for min eksistens",
    "Fordi jeg føler en sterk tiltrekning mellom oss",
    "Because i cant escape your gravitational pull",
    "Because you might have colonized my heart",
    "Porque me haces sentir completo.",
    "Porque tienes el potencial de crear hermoso entre nosotros",
    "Fordi jeg vil undersøke deg næremere",
    "Tatt i betraktning hvor fort du kom deg inn i hjertet mitt",
    "Because i can´t resist your infectious charm",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rizzify"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              // navigate to SecretPage on tap
              onDoubleTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SecretPage(),
                    ));
              },
              child: Text(
                text,
                style: const TextStyle(fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 200),
              child: TextButton(
                child: Text(
                  buttonText,
                  style: const TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  isChanged = !isChanged;
                  setState(() {
                    isChanged == false
                        ? buttonText = "Answer"
                        : buttonText = "Back";
                    isChanged == false
                        ? text = myQuestions[currentIndex]
                        : text = myAnswers[currentIndex];
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
