import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_app_androweb/data_service.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final DataService _dataService = DataService();
  List<Map<String, dynamic>> _completedWorkouts = [];
  Map<String, dynamic> _stats = {};
  bool _isLoading = true;

  // Analytics data
  List<FlSpot> _durationSpots = [];
  Map<String, int> _muscleGroupData = {};
  List<double> _weeklyWorkouts = [0, 0, 0, 0, 0, 0, 0]; // Last 7 days

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final workouts = await _dataService.getCompletedWorkouts();
    final stats = await _dataService.getWorkoutStats();

    setState(() {
      _completedWorkouts = workouts;
      _stats = stats;
      _isLoading = false;
    });

    _processAnalyticsData();
  }

  void _processAnalyticsData() {
    if (_completedWorkouts.isEmpty) return;

    // Process duration trends (last 10 workouts)
    _durationSpots = _completedWorkouts.take(10).toList().asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), (entry.value['duration'] as int).toDouble());
    }).toList();

    // Process muscle group distribution
    _muscleGroupData = {};
    for (var workout in _completedWorkouts) {
      // For simplicity, we'll use workout names as categories
      // In a real app, you'd track individual exercises
      String category = workout['name'];
      _muscleGroupData[category] = (_muscleGroupData[category] ?? 0) + 1;
    }

    // Process weekly workout frequency
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayWorkouts = _completedWorkouts.where((workout) {
        final workoutDate = DateTime.parse(workout['date']);
        return workoutDate.year == date.year &&
               workoutDate.month == date.month &&
               workoutDate.day == date.day;
      }).length;
      _weeklyWorkouts[6 - i] = dayWorkouts.toDouble();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
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
          child: Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 90, 188, 74),
            ),
          ),
        ),
      );
    }

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
                    child: _buildStatCard("Workouts", _stats['totalWorkouts'].toString(), "Completed"),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard("Minutes", _stats['totalMinutes'].toString(), "Exercised"),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard("Exercises", _stats['totalExercises'].toString(), "Done"),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildStatCard("Streak", _stats['currentStreak'].toString(), "Days"),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                "Analytics",
                style: GoogleFonts.lato(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),

              // Weekly Workout Frequency Chart
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 38, 27, 87),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Weekly Workout Frequency",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: _weeklyWorkouts.isNotEmpty ? _weeklyWorkouts.reduce((a, b) => a > b ? a : b) + 1 : 5,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                                    return Text(
                                      days[value.toInt()],
                                      style: GoogleFonts.lato(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    );
                                  }
                                  return Text('');
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: GoogleFonts.lato(
                                      color: Colors.white70,
                                      fontSize: 12,
                                    ),
                                  );
                                },
                              ),
                            ),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          barGroups: List.generate(7, (index) {
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: _weeklyWorkouts[index],
                                  color: Color.fromARGB(255, 90, 188, 74),
                                  width: 20,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Duration Trends Chart
              if (_durationSpots.isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 38, 27, 87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Duration Trends (Last 10 Workouts)",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: LineChart(
                          LineChartData(
                            gridData: FlGridData(show: false),
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      '${value.toInt() + 1}',
                                      style: GoogleFonts.lato(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text(
                                      '${value.toInt()}m',
                                      style: GoogleFonts.lato(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            ),
                            borderData: FlBorderData(show: false),
                            lineBarsData: [
                              LineChartBarData(
                                spots: _durationSpots,
                                isCurved: true,
                                color: Color.fromARGB(255, 90, 188, 74),
                                barWidth: 3,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Color.fromARGB(255, 90, 188, 74).withOpacity(0.1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],

              // Muscle Group Distribution (Pie Chart)
              if (_muscleGroupData.isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 38, 27, 87),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Workout Distribution",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: _muscleGroupData.entries.map((entry) {
                              final colors = [
                                Color.fromARGB(255, 90, 188, 74),
                                Colors.blue,
                                Colors.orange,
                                Colors.purple,
                                Colors.red,
                                Colors.teal,
                                Colors.pink,
                              ];
                              final colorIndex = _muscleGroupData.keys.toList().indexOf(entry.key) % colors.length;

                              return PieChartSectionData(
                                value: entry.value.toDouble(),
                                title: '${entry.key}\n${entry.value}',
                                color: colors[colorIndex],
                                radius: 60,
                                titleStyle: GoogleFonts.lato(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList(),
                            sectionsSpace: 2,
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],

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
                child: _completedWorkouts.isEmpty
                    ? Center(
                        child: Text(
                          "No workouts completed yet.\nStart your fitness journey!",
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
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
                                        _formatDate(workout['date']),
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

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date).inDays;

      if (difference == 0) {
        return "Today";
      } else if (difference == 1) {
        return "Yesterday";
      } else if (difference < 7) {
        return "$difference days ago";
      } else {
        return "${date.month}/${date.day}/${date.year}";
      }
    } catch (e) {
      return dateString;
    }
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