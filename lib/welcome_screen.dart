import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatefulWidget {
	const WelcomeScreen({super.key});

	@override
	State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

	final List levels = [
		"Inactive",
		"Beginner"
	];

	@override
	Widget build(BuildContext context) {
		return Container(
      padding: EdgeInsets.symmetric(vertical: 50),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
				children: [
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							Padding(
								padding: const EdgeInsets.only(top: 100.0),
								child: Text(
									"HARD", 
									style: GoogleFonts.bebasNeue(
										fontSize: 40,
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
										fontSize: 40,
										color: const Color.fromARGB(255, 90, 188, 74),
										letterSpacing: 1.8),
								),
							),
						],
					),
					// SizedBox(height: 40,),
					Padding(
						padding: const EdgeInsets.only(left: 40),
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
								Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
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
                            child: Padding(
                                padding: const EdgeInsets.all(20.0),
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
                                    SizedBox(height: 20,),
                                    Text("I have never trained", style: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold 
                                    )),
                                  ],
                                ),
                          ),
                          ),
                        );
                    }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:40.0, top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Skip Intro', style: GoogleFonts.lato(
                        fontSize: 12,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500 
                      ) ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: Container(
                          width: 139,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 90, 188, 74),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text('Next', style: GoogleFonts.lato(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold 
                            ) ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
							],
						),
					),
				],
			),
		);
	}
}
