import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/api/airtable_api.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/methods/usagemethod.dart';
import 'package:tracker/pages/claimsuccess.dart';

class Claim extends StatefulWidget {
  const Claim({Key? key}) : super(key: key);

  @override
  _ClaimState createState() => _ClaimState();
}

class _ClaimState extends State<Claim> {
  AirtableApiServices airtableApiServices = AirtableApiServices();
  UsageMethods usageMethods = UsageMethods();
  num _points = 0;
  var _response;
  num _dailyHours = 0;
  num _weeklyHours = 0;
  int _claimed = 0;
  DateTime _today = DateTime.now();
  String _todayDate = "";
  String _airtableDate = "";
  bool _loader = false;
  @override
  void initState() {
    asyncInit();
    super.initState();
  }

  void asyncInit() async {
    _todayDate = _today.day.toString() +
        "-" +
        _today.month.toString() +
        "-" +
        _today.year.toString();
    _response = await airtableApiServices.fetchAirtableData();
    _points = _response['records'][2]['fields']['rewardcoins'];
    _claimed = _response['records'][2]['fields']['claimed'];
    _airtableDate = _response['records'][2]['fields']['date'];
    await usageMethods.getDailyUsageStats();
    _dailyHours = usageMethods.totalDailyHours;
    await usageMethods.getWeeklyUsageStats();
    _weeklyHours = usageMethods.totalWeeklyHours;
    setState(() {
      _points;
      _dailyHours;
      _weeklyHours;
      _claimed;
    });
  }

  @override
  Widget build(BuildContext context) {
    //double _height = (MediaQuery.of(context).size.height) / 2.4;
    return Scaffold(
      backgroundColor: kDarkBlue2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkBlue,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('CLAIM',
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Container(
              width: _points > 0 ? null : 140,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
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
        ]),
      ),
      body: _loader
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.elliptical(300, 220),
                              bottomLeft: Radius.elliptical(160, 70)),
                          child: Container(
                            height: (MediaQuery.of(context).size.height) / 2.1,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: kDarkBlue,
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                      Colors.white12,
                                      BlendMode.modulate,
                                    ),
                                    image: AssetImage(
                                        "assets/images/sparkles.png"))),
                            child: Padding(
                              padding: const EdgeInsets.all(45.0),
                              child: Image.asset("assets/images/rewards.png"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: Container(
                                height: MediaQuery.of(context).size.height / 8,
                                width: MediaQuery.of(context).size.width,
                                decoration:
                                    const BoxDecoration(color: kDarkBlue),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Row(
                                    children: [
                                      Image.asset("assets/images/usage.png",
                                          height: 70, width: 70),
                                      const SizedBox(width: 25),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "DAILY : " +
                                                  _dailyHours
                                                      .toStringAsFixed(2) +
                                                  " hr",
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                          const SizedBox(height: 10),
                                          Text(
                                              "WEEKLY : " +
                                                  _weeklyHours
                                                      .toStringAsFixed(2) +
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
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              (_todayDate == _airtableDate) && (_claimed == 1)
                                  ? "You have already claimed today's bonus"
                                  : _dailyHours > usageLimit
                                      ? "Sorry! you are not eligible to claim daily bonus as you have exceeded your daily limit i.e $usageLimit hr use less phone and claim tomorrow"
                                      : "Awesome! you can now claim daily bonus as you are using your phone under your limits \nKEEP IT UP.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  height: 1.4,
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            child: Container(
                              height: 45,
                              decoration: BoxDecoration(
                                color: (_todayDate == _airtableDate) &&
                                        (_claimed == 1)
                                    ? Colors.redAccent.shade100
                                    : _dailyHours > usageLimit
                                        ? Colors.redAccent.shade100
                                        : null,
                                gradient: (_todayDate == _airtableDate) &&
                                        (_claimed == 1)
                                    ? null
                                    : _dailyHours > usageLimit
                                        ? null
                                        : const LinearGradient(
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
                                  onTap: (_todayDate == _airtableDate) &&
                                          (_claimed == 1)
                                      ? null
                                      : _dailyHours > usageLimit
                                          ? null
                                          : () async {
                                              setState(() {
                                                _loader = true;
                                              });
                                              await airtableApiServices
                                                  .updateToClaimed(_today.day
                                                          .toString() +
                                                      "-" +
                                                      _today.month.toString() +
                                                      "-" +
                                                      _today.year.toString());
                                              await airtableApiServices
                                                  .updatePoints(
                                                      _points.toInt() + 400);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ClaimSuccess()));
                                            },
                                  child: Center(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/points.png",
                                            width: 25,
                                            height: 25,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                              (_todayDate == _airtableDate) &&
                                                      (_claimed == 1)
                                                  ? "ALREADY CLAIMED"
                                                  : _dailyHours > usageLimit
                                                      ? "NOT ELIGIBLE"
                                                      : "CLAIM YOUR BONUS",
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600)),
                                        ]),
                                  ),
                                ),
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
    );
  }
}
