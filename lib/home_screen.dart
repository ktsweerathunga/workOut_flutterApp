import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_app_androweb/modes.dart';
import 'package:workout_app_androweb/data_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DataService _dataService = DataService();
  Map<String, dynamic>? _userProfile;
  bool _isLoadingProfile = true;

  final List<Category> catego = [
    Category(name: "CrossFit", imageUrl: "assets/images/emily.png"),
    Category(name: "Full Body", imageUrl: "assets/images/sule.png"),
    Category(name: "Hard Workout", imageUrl: "assets/images/alexsandra.png"),
    Category(name: "Yoga", imageUrl: "assets/images/emely.jpg"),
    Category(name: "Cardio", imageUrl: "assets/images/image1.png"),
    Category(name: "HIIT", imageUrl: "assets/images/image2.png"),
    Category(name: "Strength", imageUrl: "assets/images/image3.png"),
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Category> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCategories = catego;
    _searchController.addListener(_filterCategories);
    _loadUserProfile();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserProfile() async {
    final profile = await _dataService.getUserProfile();
    setState(() {
      _userProfile = profile;
      _isLoadingProfile = false;
    });
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = catego.where((category) {
        return category.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  String _getAvatarImage(int index) {
    final avatarImages = [
      'assets/images/emily.png',
      'assets/images/sule.png',
      'assets/images/alexsandra.png',
      'assets/images/emely.jpg',
    ];
    return avatarImages[index % avatarImages.length];
  }

  Widget _buildCategoryTag(String categoryName) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 38, 27, 87),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        categoryName,
        style: GoogleFonts.lato(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getCategoryInfo(String categoryName) {
    // This is a simplified version - in a real app you'd calculate this from the exercise data
    final categoryInfo = {
      "CrossFit": "15 mins | 3 Exercises",
      "Full Body": "15 mins | 3 Exercises",
      "Hard Workout": "15 mins | 3 Exercises",
      "Yoga": "20 mins | 4 Exercises",
      "Cardio": "15 mins | 4 Exercises",
      "HIIT": "10 mins | 4 Exercises",
      "Strength": "20 mins | 4 Exercises",
    };
    return categoryInfo[categoryName] ?? "15 mins | 3 Exercises";
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/welcome');
                        },
                        icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      ),
                      SizedBox(width: 10),
                      Text("Hey,", style: GoogleFonts.bebasNeue(
                        fontSize: 40,
                        color: Colors.white,
                        letterSpacing: 1.8
                      ),),
                      Text(
                        _isLoadingProfile
                            ? "there"
                            : (_userProfile?['name']?.split(' ').first ?? "Big guy"),
                        style: GoogleFonts.bebasNeue(
                          fontSize: 40,
                          color: const Color.fromARGB(255, 90, 188, 74),
                          letterSpacing: 1.8
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: Container(
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Color.fromARGB(255, 90, 188, 74), width: 3),
                        image: DecorationImage(
                          image: _isLoadingProfile || _userProfile == null
                              ? AssetImage("assets/images/emely.jpg")
                              : AssetImage(_getAvatarImage(_userProfile!['avatar'] ?? 0)),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 200,
                child: Icon(Icons.play_circle_sharp , size: 80, color: Color.fromARGB(255, 90, 188, 74),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Find", style: GoogleFonts.lato(
                          fontSize: 25,
                          color: Colors.white,
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text("Your Workout", style: GoogleFonts.lato(
                          fontSize: 25,
                          color: const Color.fromARGB(255, 90, 188, 74),
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                    Icon(
                      Icons.filter_alt_outlined,
                      color: const Color.fromARGB(255, 90, 188, 74),
                      size: 40,
                    ),
                    SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/progress');
                      },
                      child: Icon(
                        Icons.bar_chart,
                        color: const Color.fromARGB(255, 90, 188, 74),
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 345,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 90, 188, 74),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.white,),
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: TextStyle(color: Colors.white54, fontSize: 20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryTag("Popular"),
                      _buildCategoryTag("CrossFit"),
                      _buildCategoryTag("Full Body"),
                      _buildCategoryTag("Hard Workout"),
                      _buildCategoryTag("Yoga"),
                      _buildCategoryTag("Cardio"),
                      _buildCategoryTag("HIIT"),
                      _buildCategoryTag("Strength"),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Text("Popular workouts", style: GoogleFonts.lato(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold 
                    )),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filteredCategories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right:8.0, top: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/workout-detail',
                            arguments: _filteredCategories[index],
                          );
                        },
                        child: Container(
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 38, 27, 87),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(  
                                    image: DecorationImage(
                                      image: AssetImage(_filteredCategories[index].imageUrl),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(_filteredCategories[index].name, style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold 
                                )),
                                SizedBox(height: 5,),
                                Text(_getCategoryInfo(_filteredCategories[index].name), style: GoogleFonts.lato(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w400 
                                )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              )
            ],
          ),
        ),
      ) 
    );
  }
}