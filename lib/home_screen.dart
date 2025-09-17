import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Row(
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: 345,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 90, 188, 74),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
              Row(
                children: [
                  Text("Popular", style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold 
                  )),
                  Text("Hard workout", style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold 
                  )),
                  Text("Full body", style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold 
                  )),
                  Text("CrossFit", style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold 
                  )),
                ],
              )
            ],
          ),
        ),
      ) 
    );
  }
}