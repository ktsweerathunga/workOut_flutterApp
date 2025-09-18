import 'package:flutter/material.dart';
import 'package:workout_app_androweb/data_service.dart';

class DataTestScreen extends StatefulWidget {
  const DataTestScreen({super.key});

  @override
  State<DataTestScreen> createState() => _DataTestScreenState();
}

class _DataTestScreenState extends State<DataTestScreen> {
  final DataService _dataService = DataService();
  String _testResult = "Testing data persistence...";

  @override
  void initState() {
    super.initState();
    _runDataTest();
  }

  Future<void> _runDataTest() async {
    try {
      // Test saving a workout
      await _dataService.saveCompletedWorkout("Test Workout", 30, 5);

      // Test loading workouts
      final workouts = await _dataService.getCompletedWorkouts();

      // Test loading stats
      final stats = await _dataService.getWorkoutStats();

      setState(() {
        _testResult = """
✅ Data Persistence Test Passed!

Saved Workouts: ${workouts.length}
Total Workouts: ${stats['totalWorkouts']}
Total Minutes: ${stats['totalMinutes']}
Total Exercises: ${stats['totalExercises']}
Current Streak: ${stats['currentStreak']}
        """;
      });
    } catch (e) {
      setState(() {
        _testResult = "❌ Test Failed: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Test")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            _testResult,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}