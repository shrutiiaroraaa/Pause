import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/api/airtable_api.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/methods/usagemethod.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AirtableApiServices airtableApiServices = AirtableApiServices();
  UsageMethods usageMethods = UsageMethods();
  num _points = 0;
  var _response;
  num _dailyHours = 0;
  num _weeklyHours = 0;
  num _funds = 0;
  int _claimed = 0;
  @override
  void initState() {
    asyncInit();

    super.initState();
  }

  void asyncInit() async {
    _response = await airtableApiServices.fetchAirtableData();
    _points = _response['records'][2]['fields']['rewardcoins'];
    _funds = _response['records'][2]['fields']['funds'];
    _claimed = _response['records'][2]['fields']['claimed'];
    await usageMethods.getDailyUsageStats();
    _dailyHours = usageMethods.totalDailyHours;
    await usageMethods.getWeeklyUsageStats();
    _weeklyHours = usageMethods.totalWeeklyHours;
    setState(() {
      _points;
      _dailyHours;
      _weeklyHours;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = (MediaQuery.of(context).size.height) / 2.4;
    return Scaffold(
      backgroundColor: kDarkBlue2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkBlue,
        title: Text('PROFILE',
            style:
                GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.elliptical(300, 220),
                    bottomLeft: Radius.elliptical(160, 70)),
                child: Container(
                  height: (MediaQuery.of(context).size.height) / 2.4,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: kDarkBlue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/avatar.png",
                        height: 130,
                        width: 130,
                      ),
                      const SizedBox(height: 8),
                      Text("HARSHIT ARORA",
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 8),
                      Text("harshit@harshit.com",
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 15),
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        child: Container(
                          width: _points > 0 ? 200 : 120,
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
                                    Text(_points.toString() + " Points",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 22.0,
              right: 22.0,
              top: _height + 60,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Container(
                  height: MediaQuery.of(context).size.height / 7.5,
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
                            height: 70, width: 70),
                        const SizedBox(width: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "DAILY : " +
                                    _dailyHours.toStringAsFixed(2) +
                                    " hr",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Text(
                                "WEEKLY : " +
                                    _weeklyHours.toStringAsFixed(2) +
                                    " hr",
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 22.0,
              right: 22.0,
              top: _height + 190,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Container(
                  height: MediaQuery.of(context).size.height / 7.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/tilebackground.png"),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Image.asset("assets/images/walletimage.png",
                            height: 70, width: 70),
                        const SizedBox(width: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("FUNDS : ₹" + _funds.toString(),
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Text("DAILY BONUS : ",
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600)),
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: (_claimed == 0)
                                            ? Colors.redAccent
                                            : Colors.greenAccent),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 3),
                                    child: Text(
                                        (_claimed == 0)
                                            ? "Not Claimed"
                                            : "Claimed",
                                        style: GoogleFonts.inter(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
