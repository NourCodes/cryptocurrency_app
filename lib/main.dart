import 'package:flutter/material.dart';
import 'price_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.blue.shade900,
          scaffoldBackgroundColor: const Color.fromRGBO(21, 18, 41, 1.0)),
      home: const PriceScreen(),
    );
  }
}
