import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_app_androweb/data_service.dart';
import 'package:workout_app_androweb/modes.dart';

class WorkoutTimerScreen extends StatefulWidget {
  const WorkoutTimerScreen({super.key});

  @override
  State<WorkoutTimerScreen> createState() => _WorkoutTimerScreenState();
}

class _WorkoutTimerScreenState extends State<WorkoutTimerScreen> {
  final DataService _dataService = DataService();

  // Workout session data
  String _currentWorkoutName = "Custom Workout";
  List<Exercise> _exercises = [];
  int _currentExerciseIndex = 0;
  int _currentSet = 1;

  // Timer states
  int _seconds = 30;
  Timer? _timer;
  bool _isRunning = false;
  bool _isRestPeriod = false;
  int _restSeconds = 60; // Default 60 seconds rest

  // Session tracking
  int _sessionDuration = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get arguments passed from previous screen
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && _exercises.isEmpty) {
      setState(() {
        _currentWorkoutName = args['workoutName'] ?? "Custom Workout";
        _exercises = args['exercises'] ?? [];
        _seconds = _exercises.isNotEmpty ? _exercises[0].duration : 30;
      });
    }
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_isRestPeriod) {
          // Rest period countdown
          if (_restSeconds > 0) {
            _restSeconds--;
            _sessionDuration++;
          } else {
            // Rest period complete, start next exercise
            _startNextExercise();
          }
        } else {
          // Exercise countdown
          if (_seconds > 0) {
            _seconds--;
            _sessionDuration++;
          } else {
            // Exercise complete, check if more sets or exercises
            _handleExerciseComplete();
          }
        }
      });
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = _exercises.isNotEmpty ? _exercises[_currentExerciseIndex].duration : 30;
      _isRunning = false;
      _isRestPeriod = false;
      _restSeconds = 60;
      _currentSet = 1;
      _sessionDuration = 0;
    });
  }

  void _handleExerciseComplete() {
    final currentExercise = _exercises[_currentExerciseIndex];

    if (_currentSet < currentExercise.sets) {
      // More sets to do for current exercise
      setState(() {
        _currentSet++;
        _isRestPeriod = true;
        _restSeconds = 60; // 60 seconds rest between sets
        _seconds = currentExercise.duration; // Reset for next set
      });
    } else if (_currentExerciseIndex < _exercises.length - 1) {
      // Move to next exercise
      setState(() {
        _currentExerciseIndex++;
        _currentSet = 1;
        _isRestPeriod = true;
        _restSeconds = 90; // 90 seconds rest between exercises
        _seconds = _exercises[_currentExerciseIndex].duration;
      });
    } else {
      // Workout complete!
      _timer?.cancel();
      _isRunning = false;
      _completeWorkout();
    }
  }

  void _startNextExercise() {
    setState(() {
      _isRestPeriod = false;
      _isRunning = true; // Auto-start next exercise
    });
  }

  void _skipRest() {
    if (_isRestPeriod) {
      _startNextExercise();
    }
  }

  void _addTime(int seconds) {
    setState(() {
      _seconds += seconds;
    });
  }

  Future<void> _completeWorkout() async {
    // Save the completed workout
    await _dataService.saveCompletedWorkout(
      _currentWorkoutName,
      _sessionDuration ~/ 60, // Convert seconds to minutes
      _exercises.length,
    );

    // Show completion dialog
    _showCompletionDialog();
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 38, 27, 87),
          title: Text(
            "Workout Complete! 🎉",
            style: GoogleFonts.bebasNeue(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          content: Text(
            "Great job! Your workout has been saved to your progress.",
            style: GoogleFonts.lato(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/progress');
              },
              child: Text(
                "View Progress",
                style: GoogleFonts.lato(
                  color: Color.fromARGB(255, 90, 188, 74),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: Text(
                "Home",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentExercise = _exercises.isNotEmpty ? _exercises[_currentExerciseIndex] : null;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/image3.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _currentWorkoutName,
                      style: GoogleFonts.bebasNeue(
                        fontSize: 24,
                        color: Colors.white,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ),
                ],
              ),

              // Progress indicator
              if (_exercises.isNotEmpty) ...[
                SizedBox(height: 20),
                LinearProgressIndicator(
                  value: (_currentExerciseIndex * currentExercise!.sets + _currentSet - 1) /
                         (_exercises.length * currentExercise.sets),
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _isRestPeriod ? Colors.orange : Color.fromARGB(255, 90, 188, 74),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Exercise ${_currentExerciseIndex + 1} of ${_exercises.length} • Set $_currentSet of ${currentExercise.sets}",
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],

              SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isRestPeriod) ...[
                        // Rest Period UI
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _formatTime(_restSeconds),
                              style: GoogleFonts.bebasNeue(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Rest Time",
                          style: GoogleFonts.lato(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Next: ${currentExercise?.name ?? 'Next Exercise'}",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _skipRest,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                "Skip Rest",
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ] else ...[
                        // Exercise UI
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 38, 27, 87),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              _formatTime(_seconds),
                              style: GoogleFonts.bebasNeue(
                                fontSize: 60,
                                color: _seconds <= 10 ? Colors.red : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        if (currentExercise != null) ...[
                          Text(
                            currentExercise.name,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${currentExercise.sets} sets • ${currentExercise.reps} reps",
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            currentExercise.muscleGroups.join(", "),
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              color: Color.fromARGB(255, 90, 188, 74),
                            ),
                          ),
                        ],
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: _isRunning ? _pauseTimer : _startTimer,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 90, 188, 74),
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                _isRunning ? "Pause" : "Start",
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            ElevatedButton(
                              onPressed: _resetTimer,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: Text(
                                "Reset",
                                style: GoogleFonts.lato(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}