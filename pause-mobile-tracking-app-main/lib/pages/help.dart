import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/constants.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kDarkBlue,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kDarkBlue,
          title: Text('HELP',
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 80),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Minimum Payout :",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 35),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      width: 125,
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF00CCFF),
                              Color(0xFFC066D5),
                              Color(0xFFE4599A),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.3, 0.8, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/points.png",
                                    width: 18, height: 18),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text("1000 Points",
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                child: Divider(
                  height: 10,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Success Reward :",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 35),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      width: 125,
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF00CCFF),
                              Color(0xFFC066D5),
                              Color(0xFFE4599A),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.3, 0.8, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/points.png",
                                    width: 18, height: 18),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text("400 Points",
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                child: Divider(
                  height: 10,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("1 ₹ will be equal to :",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 35),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      width: 125,
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF00CCFF),
                              Color(0xFFC066D5),
                              Color(0xFFE4599A),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.3, 0.8, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/points.png",
                                    width: 18, height: 18),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text("100 Points",
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                child: Divider(
                  height: 10,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Minimum Fund to add :",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 35),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      width: 120,
                      height: 40,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF00CCFF),
                              Color(0xFFC066D5),
                              Color(0xFFE4599A),
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.3, 0.8, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/walletimage.png",
                                    width: 18, height: 18),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text("100 ₹",
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                              ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                child: Divider(
                  height: 10,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50),
              Text("For More help mail us on help@harshit.com",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              Text("All copyrights reserved",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400)),
            ],
          ),
        ));
  }
}
