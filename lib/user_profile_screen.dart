import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_app_androweb/data_service.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final DataService _dataService = DataService();
  final TextEditingController _nameController = TextEditingController();
  String _selectedLevel = 'Beginner';
  String _selectedGoal = 'Build Muscle';
  int _selectedAvatar = 0;
  bool _isLoading = true;
  bool _isSaving = false;

  final List<String> _fitnessLevels = ['Beginner', 'Intermediate', 'Advanced'];
  final List<String> _fitnessGoals = [
    'Build Muscle',
    'Lose Weight',
    'Increase Endurance',
    'Improve Flexibility',
    'General Fitness'
  ];

  final List<String> _avatarImages = [
    'assets/images/emily.png',
    'assets/images/sule.png',
    'assets/images/alexsandra.png',
    'assets/images/emely.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final profile = await _dataService.getUserProfile();
    if (profile != null) {
      setState(() {
        _nameController.text = profile['name'] ?? '';
        _selectedLevel = profile['level'] ?? 'Beginner';
        _selectedGoal = profile['goal'] ?? 'Build Muscle';
        _selectedAvatar = profile['avatar'] ?? 0;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final profile = {
      'name': _nameController.text.trim(),
      'level': _selectedLevel,
      'goal': _selectedGoal,
      'avatar': _selectedAvatar,
      'createdAt': DateTime.now().toIso8601String(),
    };

    await _dataService.saveUserProfile(profile);

    setState(() {
      _isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully!')),
    );

    // Navigate back after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      "My Profile",
                      style: GoogleFonts.bebasNeue(
                        fontSize: 32,
                        color: Colors.white,
                        letterSpacing: 1.8,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Avatar Selection
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color.fromARGB(255, 90, 188, 74),
                            width: 3,
                          ),
                          image: DecorationImage(
                            image: AssetImage(_avatarImages[_selectedAvatar]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Choose Avatar",
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _avatarImages.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedAvatar = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedAvatar == index
                                      ? Color.fromARGB(255, 90, 188, 74)
                                      : Colors.white30,
                                  width: 2,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(_avatarImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40),

                // Name Input
                Text(
                  "Name",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    hintStyle: GoogleFonts.lato(
                      color: Colors.white60,
                      fontSize: 16,
                    ),
                    filled: true,
                    fillColor: Color.fromARGB(255, 38, 27, 87),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),

                SizedBox(height: 30),

                // Fitness Level
                Text(
                  "Fitness Level",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 38, 27, 87),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedLevel,
                      isExpanded: true,
                      dropdownColor: Color.fromARGB(255, 38, 27, 87),
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      items: _fitnessLevels.map((level) {
                        return DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLevel = value!;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Fitness Goal
                Text(
                  "Fitness Goal",
                  style: GoogleFonts.lato(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 38, 27, 87),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedGoal,
                      isExpanded: true,
                      dropdownColor: Color.fromARGB(255, 38, 27, 87),
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      items: _fitnessGoals.map((goal) {
                        return DropdownMenuItem(
                          value: goal,
                          child: Text(goal),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedGoal = value!;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 50),

                // Save Button
                GestureDetector(
                  onTap: _isSaving ? null : _saveProfile,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _isSaving
                          ? Colors.grey
                          : Color.fromARGB(255, 90, 188, 74),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: _isSaving
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Save Profile",
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
      ),
    );
  }
}