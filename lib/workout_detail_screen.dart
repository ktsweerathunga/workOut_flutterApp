import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_app_androweb/modes.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final Category category;

  const WorkoutDetailScreen({super.key, required this.category});

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  late List<Exercise> exercises;

  @override
  void initState() {
    super.initState();
    // Initialize exercises based on category
    exercises = _getExercisesForCategory(widget.category.name);
  }

  List<Exercise> _getExercisesForCategory(String categoryName) {
    switch (categoryName) {
      case "CrossFit":
        return [
          Exercise(
            name: "Burpees",
            description: "A full-body exercise combining a squat, plank, and jump",
            sets: 3,
            reps: 10,
            duration: 45,
            muscleGroups: ["Full Body", "Cardio"],
            imageUrl: "assets/images/emily.png",
          ),
          Exercise(
            name: "Kettlebell Swings",
            description: "Swing a kettlebell from between your legs to chest height",
            sets: 4,
            reps: 15,
            duration: 60,
            muscleGroups: ["Glutes", "Hamstrings", "Core"],
            imageUrl: "assets/images/sule.png",
          ),
          Exercise(
            name: "Box Jumps",
            description: "Jump onto a sturdy box or platform",
            sets: 3,
            reps: 8,
            duration: 30,
            muscleGroups: ["Legs", "Cardio"],
            imageUrl: "assets/images/alexsandra.png",
          ),
        ];
      case "Full Body":
        return [
          Exercise(
            name: "Push-ups",
            description: "Lower your body to the ground and push back up",
            sets: 3,
            reps: 12,
            duration: 45,
            muscleGroups: ["Chest", "Shoulders", "Triceps"],
            imageUrl: "assets/images/emily.png",
          ),
          Exercise(
            name: "Squats",
            description: "Lower your body as if sitting back into a chair",
            sets: 4,
            reps: 15,
            duration: 60,
            muscleGroups: ["Quads", "Glutes", "Hamstrings"],
            imageUrl: "assets/images/sule.png",
          ),
          Exercise(
            name: "Plank",
            description: "Hold your body in a straight line from head to heels",
            sets: 3,
            reps: 1,
            duration: 30,
            muscleGroups: ["Core", "Shoulders"],
            imageUrl: "assets/images/alexsandra.png",
          ),
        ];
      case "Hard Workout":
        return [
          Exercise(
            name: "Deadlifts",
            description: "Lift a barbell from the ground to hip level",
            sets: 4,
            reps: 8,
            duration: 75,
            muscleGroups: ["Back", "Glutes", "Hamstrings"],
            imageUrl: "assets/images/emily.png",
          ),
          Exercise(
            name: "Bench Press",
            description: "Press a barbell away from your chest while lying on a bench",
            sets: 4,
            reps: 10,
            duration: 60,
            muscleGroups: ["Chest", "Shoulders", "Triceps"],
            imageUrl: "assets/images/sule.png",
          ),
          Exercise(
            name: "Pull-ups",
            description: "Pull your body up until your chin is over the bar",
            sets: 3,
            reps: 6,
            duration: 45,
            muscleGroups: ["Back", "Biceps"],
            imageUrl: "assets/images/alexsandra.png",
          ),
        ];
      default:
        return [];
    }
  }

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
                    widget.category.name,
                    style: GoogleFonts.bebasNeue(
                      fontSize: 32,
                      color: Colors.white,
                      letterSpacing: 1.8,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "${exercises.length} Exercises • ${exercises.fold<int>(0, (sum, exercise) => sum + exercise.duration * exercise.sets)} min",
                style: GoogleFonts.lato(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 38, 27, 87),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(exercise.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      exercise.name,
                                      style: GoogleFonts.lato(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      "${exercise.sets} sets • ${exercise.reps} reps • ${exercise.duration}s",
                                      style: GoogleFonts.lato(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      exercise.muscleGroups.join(", "),
                                      style: GoogleFonts.lato(
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 90, 188, 74),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.play_circle_fill,
                                color: Color.fromARGB(255, 90, 188, 74),
                                size: 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/timer');
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 90, 188, 74),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "Start Workout",
                      style: GoogleFonts.lato(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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