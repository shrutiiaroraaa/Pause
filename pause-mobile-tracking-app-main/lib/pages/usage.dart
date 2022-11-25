import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/methods/usagemethod.dart';

class Usage extends StatefulWidget {
  const Usage({Key? key}) : super(key: key);

  @override
  _UsageState createState() => _UsageState();
}

class _UsageState extends State<Usage> {
  List<AppUsageInfo> _infos = [];
  UsageMethods usageMethods = UsageMethods();
  @override
  void initState() {
    asyncInit();
    super.initState();
  }

  void asyncInit() async {
    _infos = await usageMethods.getDailyUsageStats();
    setState(() {
      _infos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kDarkBlue2,
        child: const Icon(Icons.replay_outlined),
        onPressed: () async {
          _infos = await usageMethods.getDailyUsageStats();
          setState(() {
            _infos;
          });
        },
      ),
      backgroundColor: kDarkBlue,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkBlue,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('USAGE',
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Container(
              width: 120,
              height: 35,
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
                        Image.asset("assets/images/clock.png",
                            width: 18, height: 18),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                            usageMethods.totalDailyHours.toStringAsFixed(1) +
                                " Hours",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ]),
                ),
              ),
            ),
          )
        ]),
      ),
      body: ListView.builder(
          itemCount: _infos.length,
          itemBuilder: (context, index) {
            return Visibility(
              visible: (_infos[index].usage.inMinutes.toInt()) > 0,
              child: Column(children: [
                const SizedBox(
                  child: Divider(
                    height: 10,
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  title: Text(
                      _infos[index].appName.toString().toUpperCase() + " :",
                      style:
                          GoogleFonts.inter(fontSize: 16, color: Colors.white)),
                  trailing: Text(
                      _infos[index].usage.inMinutes.toString() + " Min",
                      style: GoogleFonts.inter(color: Colors.white)),
                ),
              ]),
            );
          }),
    );
  }
}
