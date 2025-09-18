import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'modes.dart';

class DataService {
  static const String _completedWorkoutsKey = 'completed_workouts';
  static const String _userProfileKey = 'user_profile';
  static const String _workoutStreakKey = 'workout_streak';
  static const String _lastWorkoutDateKey = 'last_workout_date';

  // Singleton pattern
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Save completed workout
  Future<void> saveCompletedWorkout(String workoutName, int duration, int exercisesCount) async {
    final workout = {
      'name': workoutName,
      'date': DateTime.now().toIso8601String(),
      'duration': duration,
      'exercises': exercisesCount,
    };

    final completedWorkouts = await getCompletedWorkouts();
    completedWorkouts.insert(0, workout); // Add to beginning

    // Keep only last 50 workouts to avoid storage bloat
    if (completedWorkouts.length > 50) {
      completedWorkouts.removeRange(50, completedWorkouts.length);
    }

    await _prefs.setString(_completedWorkoutsKey, jsonEncode(completedWorkouts));

    // Update streak
    await _updateStreak();
  }

  // Get completed workouts
  Future<List<Map<String, dynamic>>> getCompletedWorkouts() async {
    final workoutsJson = _prefs.getString(_completedWorkoutsKey);
    if (workoutsJson == null) return [];

    try {
      final List<dynamic> workouts = jsonDecode(workoutsJson);
      return workouts.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  // Get workout statistics
  Future<Map<String, dynamic>> getWorkoutStats() async {
    final workouts = await getCompletedWorkouts();

    if (workouts.isEmpty) {
      return {
        'totalWorkouts': 0,
        'totalMinutes': 0,
        'totalExercises': 0,
        'currentStreak': 0,
        'longestStreak': 0,
      };
    }

    final totalWorkouts = workouts.length;
    final totalMinutes = workouts.fold<int>(0, (sum, workout) => sum + (workout['duration'] as int));
    final totalExercises = workouts.fold<int>(0, (sum, workout) => sum + (workout['exercises'] as int));
    final currentStreak = await getCurrentStreak();
    final longestStreak = await getLongestStreak();

    return {
      'totalWorkouts': totalWorkouts,
      'totalMinutes': totalMinutes,
      'totalExercises': totalExercises,
      'currentStreak': currentStreak,
      'longestStreak': longestStreak,
    };
  }

  // Streak management
  Future<void> _updateStreak() async {
    final lastWorkoutDateStr = _prefs.getString(_lastWorkoutDateKey);
    final today = DateTime.now();
    final todayStr = today.toIso8601String().split('T')[0]; // Just date part

    if (lastWorkoutDateStr == null) {
      // First workout
      await _prefs.setInt(_workoutStreakKey, 1);
      await _prefs.setString(_lastWorkoutDateKey, todayStr);
      return;
    }

    final lastWorkoutDate = DateTime.parse(lastWorkoutDateStr);
    final lastWorkoutDateOnly = DateTime(lastWorkoutDate.year, lastWorkoutDate.month, lastWorkoutDate.day);
    final todayOnly = DateTime(today.year, today.month, today.day);

    final difference = todayOnly.difference(lastWorkoutDateOnly).inDays;

    if (difference == 1) {
      // Consecutive day
      final currentStreak = _prefs.getInt(_workoutStreakKey) ?? 0;
      await _prefs.setInt(_workoutStreakKey, currentStreak + 1);
    } else if (difference > 1) {
      // Streak broken
      await _prefs.setInt(_workoutStreakKey, 1);
    }
    // If difference == 0, same day workout, don't change streak

    await _prefs.setString(_lastWorkoutDateKey, todayStr);
  }

  Future<int> getCurrentStreak() async {
    return _prefs.getInt(_workoutStreakKey) ?? 0;
  }

  Future<int> getLongestStreak() async {
    // For now, return current streak. Could be enhanced to track longest streak separately
    return await getCurrentStreak();
  }

  // User profile management
  Future<void> saveUserProfile(Map<String, dynamic> profile) async {
    await _prefs.setString(_userProfileKey, jsonEncode(profile));
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    final profileJson = _prefs.getString(_userProfileKey);
    if (profileJson == null) return null;

    try {
      return jsonDecode(profileJson);
    } catch (e) {
      return null;
    }
  }

  // Clear all data (for testing or reset)
  Future<void> clearAllData() async {
    await _prefs.clear();
  }
}