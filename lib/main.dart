import 'package:flutter/material.dart';
import 'package:workout_app_androweb/WelcomeScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Welcomescreen(),
    );
  }
}