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
                height: 300,
                child: Icon(Icons.play_circle_sharp , size: 80, color: Colors.white54,),
              )
            ],
          ),
        ),
      ) 
    );
  }
}