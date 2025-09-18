import 'package:flutter/material.dart';
import 'package:workout_app_androweb/welcome_screen.dart';
import 'package:workout_app_androweb/home_screen.dart';
import 'package:workout_app_androweb/workout_detail_screen.dart';
import 'package:workout_app_androweb/workout_timer_screen.dart';
import 'package:workout_app_androweb/progress_screen.dart';
import 'package:workout_app_androweb/modes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workout App',
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/timer': (context) => const WorkoutTimerScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/workout-detail') {
          final category = settings.arguments as Category;
          return MaterialPageRoute(
            builder: (context) => WorkoutDetailScreen(category: category),
          );
        }
        return null;
      },
    );
  }
}