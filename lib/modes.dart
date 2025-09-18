class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}

class Exercise {
  final String name;
  final String description;
  final int sets;
  final int reps;
  final int duration; // in seconds
  final List<String> muscleGroups;
  final String imageUrl;

  Exercise({
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    required this.duration,
    required this.muscleGroups,
    required this.imageUrl,
  });
}