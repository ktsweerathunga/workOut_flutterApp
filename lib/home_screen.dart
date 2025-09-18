import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_app_androweb/modes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Category> catego = [
    Category(name: "CrossFit", imageUrl: "assets/images/emily.png"),
    Category(name: "Full Body", imageUrl: "assets/images/sule.png"),
    Category(name: "Hard Workout", imageUrl: "assets/images/alexsandra.png"),
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Category> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _filteredCategories = catego;
    _searchController.addListener(_filterCategories);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCategories = catego.where((category) {
        return category.name.toLowerCase().contains(query);
      }).toList();
    });
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
                      Text("Big guy", style: GoogleFonts.bebasNeue(
                        fontSize: 40,
                        color: const Color.fromARGB(255, 90, 188, 74),
                        letterSpacing: 1.8
                      ),),
                    ],
                  ),
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Color.fromARGB(255, 90, 188, 74), width: 3),
                      image: DecorationImage(image: AssetImage("assets/images/emely.jpg"), fit: BoxFit.cover)
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Popular", style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold 
                    )),
                    Text("Hard workout", style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold 
                    )),
                    Text("Full body", style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold 
                    )),
                    Text("CrossFit", style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold 
                    )),
                  ],
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
                  itemCount: catego.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right:8.0, top: 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/workout-detail',
                            arguments: catego[index],
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
                                      image: AssetImage(catego[index].imageUrl),
                                      fit: BoxFit.cover
                                    )
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(catego[index].name, style: GoogleFonts.lato(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold 
                                )),
                                SizedBox(height: 5,),
                                Text("15 mins | 5 Exercises", style: GoogleFonts.lato(
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