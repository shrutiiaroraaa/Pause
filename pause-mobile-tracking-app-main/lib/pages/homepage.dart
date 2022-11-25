import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/api/airtable_api.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/methods/usagemethod.dart';
import 'package:tracker/pages/addfunds.dart';
import 'package:tracker/pages/claim.dart';
import 'package:tracker/pages/help.dart';
import 'package:tracker/pages/profile.dart';
import 'package:tracker/pages/redeem.dart';
import 'package:tracker/pages/usage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AirtableApiServices airtableApiServices = AirtableApiServices();
  UsageMethods usageMethods = UsageMethods();
  num _points = 0;
  var _response;
  num _usage = 0;
  @override
  void initState() {
    asyncInit();
    super.initState();
  }

  void asyncInit() async {
    _response = await airtableApiServices.fetchAirtableData();
    _points = _response['records'][2]['fields']['rewardcoins'];
    await usageMethods.getDailyUsageStats();
    _usage = usageMethods.totalDailyHours;
    setState(() {
      _points;
      _usage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kDarkBlue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 22, left: 4, bottom: 10, right: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()));
                    },
                    child: Column(
                      children: [
                        Image.asset("assets/images/avatar.png",
                            width: 38, height: 38),
                        Text("PROFILE",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    child: Container(
                      width: _points > 0 ? null : 80,
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 12.0),
                        child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/images/points.png",
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(
                                  width: 6.0,
                                ),
                                Text(_points.toString(),
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
            ),
            const SizedBox(
              child: Divider(
                height: 10,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Usage()));
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width,
                  color: kDarkBlue2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_usage.toStringAsFixed(2) + "\nHours",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(
                              height: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                initState();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text("Click to refresh",
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Image.asset(
                          "assets/images/headphone.png",
                          width: 130,
                          height: 130,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Cardtile(
                  title: "Claim",
                  imageLocation: "assets/images/claim.png",
                  pageName: const Claim(),
                ),
                Cardtile(
                    title: "Redeem",
                    imageLocation: "assets/images/points.png",
                    pageName: const Redeem()),
                Cardtile(
                  title: "Add Funds",
                  imageLocation: "assets/images/walletimage.png",
                  pageName: const AddFunds(),
                )
              ],
            ),
            const SizedBox(height: 25),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("How it works?",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Help()));
                  },
                  child: Text("HELP?",
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            const SizedBox(height: 25),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Container(
                  height: MediaQuery.of(context).size.height / 6.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/tilebackground.png"),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Image.asset("assets/images/usage.png",
                            height: 80, width: 80),
                        const SizedBox(width: 15),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("GET REWARDS!",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Get real cash rewards for\nnot using phone",
                                      style: GoogleFonts.inter(
                                          height: 1.35,
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(width: 25),
                                  const Icon(CupertinoIcons.arrow_right,
                                      color: Colors.white, size: 18)
                                ]),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    ));
  }
}

class Cardtile extends StatelessWidget {
  final String title;
  final String imageLocation;
  Widget pageName;
  Cardtile(
      {Key? key,
      required this.title,
      required this.imageLocation,
      required this.pageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => pageName));
        },
        child: Container(
          color: kDarkBlue2,
          height: ((MediaQuery.of(context).size.height) / 5.2),
          width: ((MediaQuery.of(context).size.width) / 3) - 22,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imageLocation, width: 60, height: 60),
              const SizedBox(height: 20),
              Text(title,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ),
    );
  }
}
