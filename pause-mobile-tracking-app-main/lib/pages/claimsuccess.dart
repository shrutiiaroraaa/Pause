import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/pages/homepage.dart';

class ClaimSuccess extends StatefulWidget {
  const ClaimSuccess({Key? key}) : super(key: key);

  @override
  _ClaimSuccessState createState() => _ClaimSuccessState();
}

class _ClaimSuccessState extends State<ClaimSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kDarkBlue,
        body: Stack(children: [
          Image.asset("assets/images/poppers.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              color: kDarkBlue2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/avatar.png",
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 15),
                Text("Congrats! Harshit",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 25),
                Text(
                  "You have claimed your daily bonus successfully",
                  style: GoogleFonts.inter(
                      height: 1.6,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: 50,
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
                    child: Material(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/walletimage.png",
                                    width: 20, height: 20),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                Text("Thank You",
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ]),
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
