import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';

class SecretPage extends StatefulWidget {
  const SecretPage({
    super.key,
  });

  @override
  State<SecretPage> createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("secret page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            currentIndex == 10
                //displays a gif from giphy.com
                ? Image.network(
                    'https://i.giphy.com/media/l0HlN5Y28D9MzzcRy/giphy.webp',
                    height: 200,
                    width: 200,
                  )
                : const Text(
                    "Ykt'vo rktjc u luao sbus row iuj qoo Nts ckj's uqqtho ykt'vo wkj sbo auho Sbo lpdzo ykt ipuvo wdgg kjgy no Kj cuy soj wboj sbo hkkjq upo suho",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 200),
              child: TextButton(
                child: const Text(
                  "Go back!",
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  //navigate pop, to previous page
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
