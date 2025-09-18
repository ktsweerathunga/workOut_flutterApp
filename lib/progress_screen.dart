import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  // Mock data for demonstration
  final List<Map<String, dynamic>> _completedWorkouts = [
    {
      'name': 'CrossFit',
      'date': '2024-01-15',
      'duration': 45,
      'exercises': 5,
    },
    {
      'name': 'Full Body',
      'date': '2024-01-14',
      'duration': 35,
      'exercises': 4,
    },
    {
      'name': 'Hard Workout',
      'date': '2024-01-13',
      'duration': 50,
      'exercises': 6,
    },
  ];

  int get _totalWorkouts => _completedWorkouts.length;
  int get _totalMinutes => _completedWorkouts.fold(0, (sum, workout) => sum + workout['duration'] as int);
  int get _totalExercises => _completedWorkouts.fold(0, (sum, workout) => sum + workout['exercises'] as int);

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    "Progress",
                    style: GoogleFonts.bebasNeue(
                      fontSize: 32,
                      color: Colors.white,
                      letterSpacing: 1.8,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard("Workouts", _totalWorkouts.toString(), "Completed"),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard("Minutes", _totalMinutes.toString(), "Exercised"),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard("Exercises", _totalExercises.toString(), "Done"),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard("Streak", "3", "Days"),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                "Recent Workouts",
                style: GoogleFonts.lato(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _completedWorkouts.length,
                  itemBuilder: (context, index) {
                    final workout = _completedWorkouts[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 38, 27, 87),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  workout['name'],
                                  style: GoogleFonts.lato(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${workout['exercises']} exercises • ${workout['duration']} min",
                                  style: GoogleFonts.lato(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Color.fromARGB(255, 90, 188, 74),
                                  size: 30,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  workout['date'],
                                  style: GoogleFonts.lato(
                                    fontSize: 12,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 38, 27, 87),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.bebasNeue(
              fontSize: 32,
              color: Color.fromARGB(255, 90, 188, 74),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.lato(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}