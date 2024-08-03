import 'package:flutter/material.dart';
import 'package:userdetailsapp/_MyHomePageState.dart';
import 'package:userdetailsapp/dependancyInjection.dart';

void main() {
  runApp(const MyApp());
  Dependancyinjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
