import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final inputController = TextEditingController();
  final outputController = TextEditingController();
  final translator = GoogleTranslator();

  String inputLanguage = "en";
  String outputLanguage = "tr";

  Future<void> translateText() async {
    final translated = await translator.translate(
      inputController.text,
      from: inputLanguage,
      to: outputLanguage,
    );
    setState(() {
      outputController.text = translated.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  "https://www.drawkit.com/illustrations/music-illustrations",
                  fit: BoxFit.contain,
                  height: 250,
                ),
                TextField(
                  controller: inputController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Çevirmek istediğiniz şarkı sözlerini girin",
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      value: inputLanguage,
                      onChanged: (newValue) {
                        setState(() {
                          inputLanguage = newValue!;
                        });
                      },
                      items: <String>[
                        'en',
                        'tr'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value == 'en' ? 'İngilizce' : 'Türkçe'),
                        );
                      }).toList(),
                    ),
                    Icon(Icons.arrow_forward_rounded),
                    DropdownButton<String>(
                      value: outputLanguage,
                      onChanged: (newValue) {
                        setState(() {
                          outputLanguage = newValue!;
                        });
                      },
                      items: <String>[
                        'en',
                        'tr'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value == 'en' ? 'İngilizce' : 'Türkçe'),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: translateText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                    minimumSize: Size.fromHeight(55),
                  ),
                  child: Text("Çevir"),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: outputController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
