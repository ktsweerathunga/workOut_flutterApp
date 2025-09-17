import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {

  final List levels = [
    "Inactive",
    "Beginner"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/image2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  "HARD", 
                  style: GoogleFonts.bebasNeue(
                    fontSize: 32,
                    color: Colors.white,
                    letterSpacing: 1.8),
                ),
              ),
              SizedBox(width: 20),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  "ELEMENTS", 
                  style: GoogleFonts.bebasNeue(
                    fontSize: 32,
                    color: const Color.fromARGB(255, 90, 188, 74),
                    letterSpacing: 1.8),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    "About You", 
                    style: GoogleFonts.lato(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.8),
                  ),
                SizedBox(height: 20,),
                Text( 
                    "Your Journey Starts Here\nLet's Get Started\n", 
                    style: GoogleFonts.lato(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                      letterSpacing: 1.8),
                  ),
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: levels.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 38, 27, 87),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("I am", style: GoogleFonts.lato(
                                fontSize: 30,
                                color: const Color.fromARGB(255, 90, 188, 74),
                                fontWeight: FontWeight.bold 
                              )),
                              Text(levels[index], style: GoogleFonts.lato(
                                fontSize: 30,
                                color: const Color.fromARGB(255, 90, 188, 74),
                                fontWeight: FontWeight.bold 
                              )),
                            ],
                          ),
                        ),
                      );
                  }),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}