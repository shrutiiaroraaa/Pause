import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tracker/pages/homepage.dart';

List<Color> bgColorsList = [
  const Color(0xAA00CCFF),
  const Color(0xAA1FB090),
  const Color(0xAAA398D6)
];
List<PageViewModel> introScreenPages() {
  return [
    PageViewModel(
      decoration: PageDecoration(
          titleTextStyle: GoogleFonts.inter(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
          bodyTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 24),
          imagePadding: const EdgeInsets.only(top: 40),
          imageFlex: 2),
      title: 'DAILY BONUS',
      body: 'Do not exceed your phone usage limit and claim daily bonus',
      image: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Image.asset('assets/images/claim.png', height: 280, width: 280),
      ),
    ),
    PageViewModel(
      decoration: PageDecoration(
          titleTextStyle: GoogleFonts.inter(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
          bodyTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 24),
          imagePadding: const EdgeInsets.only(top: 40),
          imageFlex: 2),

      title: 'REAL CASH',
      body:
          'Redeem your points directly into your bank account using UPI transfer',
      image: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Image.asset('assets/images/walletimage.png',
            height: 280, width: 280),
      ),
      //footer: const Text('Footer Text')
    ),
    PageViewModel(
      decoration: PageDecoration(
          titleTextStyle: GoogleFonts.inter(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.w600),
          bodyTextStyle: GoogleFonts.inter(color: Colors.white, fontSize: 24),
          imagePadding: const EdgeInsets.only(top: 40),
          imageFlex: 2),
      title: 'TRACK USAGE',
      body: 'Track youor phone usage and get individual app usage analytics',
      image: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child:
            Image.asset('assets/images/headphone.png', height: 290, width: 290),
      ),
      //footer: const Text('Footer Text')
    ),
  ];
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Color bgColor = bgColorsList[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IntroductionScreen(
      globalBackgroundColor: bgColor,
      onChange: (page) {
        setState(() {
          bgColor = bgColorsList[page];
        });
      },
      pages: introScreenPages(),
      showNextButton: true,
      next: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
          Text(
            'Next',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.arrow_forward_ios,
            size: 12,
          )
        ]),
      ),
      nextColor: Colors.white,
      done: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
          Text(
            'Done',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.arrow_forward_ios,
            size: 12,
          )
        ]),
      ),
      doneColor: Colors.white,
      onDone: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        // When done button is press
      },
      dotsFlex: 1,
      controlsPadding: EdgeInsets.zero,
      dotsDecorator: const DotsDecorator(
        color: Colors.white,
        activeColor: Colors.white,
        size: Size.square(7),
        activeSize: Size(25.0, 7.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    ));
  }
}
