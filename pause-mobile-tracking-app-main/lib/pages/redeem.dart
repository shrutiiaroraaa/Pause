import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tracker/api/airtable_api.dart';
import 'package:tracker/api/razorpaypayout.dart';
import 'package:tracker/constants.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:tracker/pages/redeemsuccess.dart';

class Redeem extends StatefulWidget {
  const Redeem({Key? key}) : super(key: key);

  @override
  _RedeemState createState() => _RedeemState();
}

class _RedeemState extends State<Redeem> {
  AirtableApiServices airtableApiServices = AirtableApiServices();

  late TextEditingController pointsTextEditingController;
  late TextEditingController nameTextEditingController;
  late TextEditingController upiTextEditingController;
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;

  var _response;
  int _points = 0;
  late String _email;
  late String _password;
  late int _funds;
  late int _pointsToRupee;
  bool _loader = false;
  late bool _checkBox;
  late bool _fieldsNotEmpty;
  late bool _pointsChanged;
  late bool _pointsTapDone;
  late bool _pointsValidated;
  late bool _nameTapDone;
  late bool _nameEditingCompleted;
  late bool _nameValidated;
  late bool _upiTapDone;
  late bool _upiEditingCompleted;
  late bool _upiValidated;
  late bool _emailTapDone;
  late bool _emailEditingCompleted;
  late bool _emailValidated;
  late bool _passwordTapDone;
  late bool _passwordEditingCompleted;
  late bool _passwordValidated;
  @override
  void initState() {
    pointsTextEditingController = TextEditingController();
    nameTextEditingController = TextEditingController();
    upiTextEditingController = TextEditingController();
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    _points = 0;
    _email = '';
    _password = '';
    _funds = 0;
    _pointsToRupee = 0;
    _checkBox = false;
    _fieldsNotEmpty = false;
    _pointsChanged = false;
    _pointsTapDone = false;
    _pointsValidated = false;
    _nameTapDone = false;
    _nameEditingCompleted = false;
    _nameValidated = false;
    _upiTapDone = false;
    _upiEditingCompleted = false;
    _upiValidated = false;
    _emailTapDone = false;
    _emailEditingCompleted = false;
    _emailValidated = false;
    _passwordTapDone = false;
    _passwordEditingCompleted = false;
    _passwordValidated = false;
    pointsTextEditingController.addListener(() {
      _fieldsNotEmpty = (pointsTextEditingController.text.isNotEmpty) &&
          (upiTextEditingController.text.isNotEmpty) &&
          (emailTextEditingController.text.isNotEmpty) &&
          (passwordTextEditingController.text.isNotEmpty) &&
          (nameTextEditingController.text.isNotEmpty);
      if (pointsTextEditingController.text.isNotEmpty) {
        _pointsToRupee =
            (int.parse((pointsTextEditingController.text)) ~/ 100).toInt();
      }
      setState(() {
        _pointsToRupee;
        _fieldsNotEmpty;
      });
    });
    nameTextEditingController.addListener(() {
      _fieldsNotEmpty = (pointsTextEditingController.text.isNotEmpty) &&
          (upiTextEditingController.text.isNotEmpty) &&
          (emailTextEditingController.text.isNotEmpty) &&
          (passwordTextEditingController.text.isNotEmpty) &&
          (nameTextEditingController.text.isNotEmpty);
      setState(() {
        _fieldsNotEmpty;
      });
    });
    upiTextEditingController.addListener(() {
      _fieldsNotEmpty = (pointsTextEditingController.text.isNotEmpty) &&
          (upiTextEditingController.text.isNotEmpty) &&
          (emailTextEditingController.text.isNotEmpty) &&
          (passwordTextEditingController.text.isNotEmpty) &&
          (nameTextEditingController.text.isNotEmpty);
      setState(() {
        _fieldsNotEmpty;
      });
    });
    emailTextEditingController.addListener(() {
      _fieldsNotEmpty = (pointsTextEditingController.text.isNotEmpty) &&
          (upiTextEditingController.text.isNotEmpty) &&
          (emailTextEditingController.text.isNotEmpty) &&
          (passwordTextEditingController.text.isNotEmpty) &&
          (nameTextEditingController.text.isNotEmpty);
      setState(() {
        _fieldsNotEmpty;
      });
    });
    passwordTextEditingController.addListener(() {
      _fieldsNotEmpty = (pointsTextEditingController.text.isNotEmpty) &&
          (upiTextEditingController.text.isNotEmpty) &&
          (emailTextEditingController.text.isNotEmpty) &&
          (passwordTextEditingController.text.isNotEmpty) &&
          (nameTextEditingController.text.isNotEmpty);
      setState(() {
        _fieldsNotEmpty;
      });
    });
    asyncInit();
    super.initState();
  }

  void asyncInit() async {
    _response = await airtableApiServices.fetchAirtableData();
    _points = _response['records'][2]['fields']['rewardcoins'];
    _funds = _response['records'][2]['fields']['funds'];
    _email = _response['records'][2]['fields']['username'];
    _password = _response['records'][2]['fields']['password'];
    setState(() {
      _points;
    });
  }

  @override
  void dispose() {
    pointsTextEditingController.dispose();
    upiTextEditingController.dispose();
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    nameTextEditingController.dispose();
    super.dispose();
  }

//TODO: Improve form field submission checks.

  bool _validatePoints() {
    if (int.parse(pointsTextEditingController.text) <= _points) {
      return true;
    } else {
      return false;
    }
  }

  bool _validateUpi(String id) {
    final regEx = RegExp(r'^[a-z A-Z 0-9_\.\-]{2,256}[@][a-z A-Z]{2,256}');
    final match = regEx.hasMatch(id);
    return match;
  }

  bool _validateName(String name) {
    final regEx = RegExp(r'^[A-Za-z\s]+$');
    final match = regEx.hasMatch(name);
    return match;
  }

  dynamic _validatePointsField() {
    if (_pointsTapDone == true &&
        _pointsChanged == false &&
        (pointsTextEditingController.text.isEmpty)) {
      return null;
    } else if (_pointsTapDone == true &&
        _pointsChanged == true &&
        (pointsTextEditingController.text.isEmpty)) {
      return null;
    } else if (_pointsTapDone == true &&
        _pointsChanged == true &&
        int.parse((pointsTextEditingController.text)) < 1000) {
      return "Minimum 1000 points";
    } else if (_pointsTapDone == true &&
        _pointsChanged == true &&
        int.parse((pointsTextEditingController.text)) >= 1000 &&
        !_validatePoints()) {
      return "Exceeding wallet balance";
    } else if (_pointsTapDone == true &&
        _pointsChanged == true &&
        int.parse((pointsTextEditingController.text)) > 1000 &&
        _validatePoints()) {
      setState(() {
        _pointsValidated = true;
      });
      return null;
    } else {
      return null;
    }
  }

  dynamic _validateNameField() {
    if (_nameTapDone == true &&
        _nameEditingCompleted == false &&
        (upiTextEditingController.text.isEmpty)) {
      return null;
    } else if (_nameTapDone == true &&
        _nameEditingCompleted == true &&
        (nameTextEditingController.text.isEmpty)) {
      return null;
    } else if (_nameTapDone == true &&
        _nameEditingCompleted == true &&
        _validateName(nameTextEditingController.text) == false) {
      return "Not a valid name";
    } else if (_nameTapDone == true &&
        _nameEditingCompleted == true &&
        _validateName(nameTextEditingController.text) == true) {
      setState(() {
        _nameValidated = true;
      });
      return null;
    } else {
      return null;
    }
  }

  dynamic _validateUpiField() {
    if (_upiTapDone == true &&
        _upiEditingCompleted == false &&
        (upiTextEditingController.text.isEmpty)) {
      return null;
    } else if (_upiTapDone == true &&
        _upiEditingCompleted == true &&
        (upiTextEditingController.text.isEmpty)) {
      return null;
    } else if (_upiTapDone == true &&
        _upiEditingCompleted == true &&
        _validateUpi(upiTextEditingController.text) == false) {
      return "Not a valid UPI";
    } else if (_upiTapDone == true &&
        _upiEditingCompleted == true &&
        _validateUpi(upiTextEditingController.text) == true) {
      setState(() {
        _upiValidated = true;
      });
      return null;
    } else {
      return null;
    }
  }

  dynamic _validateEmailField() {
    if (_emailTapDone == true &&
        _emailEditingCompleted == false &&
        (emailTextEditingController.text.isEmpty)) {
      return null;
    } else if (_emailTapDone == true &&
        _emailEditingCompleted == true &&
        (emailTextEditingController.text.isEmpty)) {
      return null;
    } else if (_emailTapDone == true &&
        _emailEditingCompleted == true &&
        emailTextEditingController.text.isEmail() != true) {
      return "Not valid Email";
    } else if (_emailTapDone == true &&
        _emailEditingCompleted == true &&
        emailTextEditingController.text.toString() != _email &&
        emailTextEditingController.text.isEmail()) {
      return "Email not correct";
    } else if (_emailTapDone == true &&
        _emailEditingCompleted == true &&
        emailTextEditingController.text.toString() == _email) {
      setState(() {
        _emailValidated = true;
      });
      return null;
    } else {
      return null;
    }
  }

  dynamic _validatePassword() {
    if (_passwordTapDone == true &&
        _passwordEditingCompleted == false &&
        (passwordTextEditingController.text.isEmpty)) {
      return null;
    } else if (_passwordTapDone == true &&
        _passwordEditingCompleted == true &&
        (passwordTextEditingController.text.isEmpty)) {
      return null;
    } else if (_passwordTapDone == true &&
        _passwordEditingCompleted == true &&
        passwordTextEditingController.text.toString() != _password) {
      return "Password not correct";
    } else if (_passwordTapDone == true &&
        _passwordEditingCompleted == true &&
        passwordTextEditingController.text.toString() == _password) {
      setState(() {
        _passwordValidated = true;
      });
      return null;
    } else {
      return null;
    }
  }

  bool _validateAllFields() {
    if (_pointsValidated == true &&
        _upiValidated == true &&
        _emailValidated == true &&
        _passwordValidated == true &&
        _nameValidated == true &&
        _checkBox == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlue2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkBlue,
        title: Text('REDEEM', style: appBarHeadingStyle),
      ),
      body: _loader
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.elliptical(160, 70),
                            bottomLeft: Radius.elliptical(160, 70)),
                        child: Container(
                          height: (MediaQuery.of(context).size.height) / 2,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(color: kDarkBlue),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(30)),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  height: 60,
                                  width: 240,
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                "assets/images/points.png",
                                                width: 30,
                                                height: 30,
                                                fit: BoxFit.contain),
                                            const SizedBox(width: 5.0),
                                            Text(_points.toString() + " Points",
                                                style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600))
                                          ]),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text("Currently in your wallet",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 22.0, right: 22.0, top: 150, bottom: 80),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 180,
                                    child: TextField(
                                      onTap: () {
                                        setState(() {
                                          _pointsTapDone = true;
                                        });
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _pointsChanged = true;
                                        });
                                      },
                                      cursorColor: kDarkBlue,
                                      style: const TextStyle(color: kDarkBlue),
                                      keyboardType: TextInputType.number,
                                      controller: pointsTextEditingController,
                                      decoration: InputDecoration(
                                          errorText: _validatePointsField(),
                                          errorStyle: errorFieldStyle,
                                          focusedBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: kDarkBlue,
                                                      width: 2.0)),
                                          labelStyle:
                                              const TextStyle(color: kDarkBlue),
                                          labelText: "Points to redeem",
                                          hintText: "Minimum 1000",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          )),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Text("₹ " + _pointsToRupee.toStringAsFixed(0),
                                      style: GoogleFonts.inter(
                                          color: kDarkBlue,
                                          fontSize: _pointsToRupee
                                                      .toInt()
                                                      .toString()
                                                      .length <=
                                                  5
                                              ? 24
                                              : _pointsToRupee
                                                          .toInt()
                                                          .toString()
                                                          .length <=
                                                      9
                                                  ? 16
                                                  : _pointsToRupee
                                                              .toInt()
                                                              .toString()
                                                              .length <=
                                                          12
                                                      ? 12
                                                      : 8,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      _nameTapDone = true;
                                    });
                                  },
                                  onEditingComplete: () {
                                    setState(() {
                                      _nameEditingCompleted = true;
                                    });
                                  },
                                  cursorColor: kDarkBlue,
                                  style: const TextStyle(color: kDarkBlue),
                                  controller: nameTextEditingController,
                                  decoration: InputDecoration(
                                      errorText: _validateNameField(),
                                      errorStyle: errorFieldStyle,
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kDarkBlue, width: 2.0)),
                                      labelStyle:
                                          const TextStyle(color: kDarkBlue),
                                      labelText: "Name",
                                      hintText: "Harshit Arora",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      _upiTapDone = true;
                                      _nameEditingCompleted = true;
                                    });
                                  },
                                  onEditingComplete: () {
                                    setState(() {
                                      _upiEditingCompleted = true;
                                    });
                                  },
                                  cursorColor: kDarkBlue,
                                  style: const TextStyle(color: kDarkBlue),
                                  controller: upiTextEditingController,
                                  decoration: InputDecoration(
                                      errorText: _validateUpiField(),
                                      errorStyle: errorFieldStyle,
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kDarkBlue, width: 2.0)),
                                      labelStyle:
                                          const TextStyle(color: kDarkBlue),
                                      labelText: "UPI id",
                                      hintText: "harshit@oksbi",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                child: TextField(
                                  onTap: () {
                                    setState(() {
                                      _emailTapDone = true;
                                      _upiEditingCompleted = true;
                                    });
                                  },
                                  onEditingComplete: () {
                                    setState(() {
                                      _emailEditingCompleted = true;
                                    });
                                  },
                                  cursorColor: kDarkBlue,
                                  style: const TextStyle(color: kDarkBlue),
                                  controller: emailTextEditingController,
                                  decoration: InputDecoration(
                                      errorText: _validateEmailField(),
                                      errorStyle: errorFieldStyle,
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kDarkBlue, width: 2.0)),
                                      labelStyle:
                                          const TextStyle(color: kDarkBlue),
                                      labelText: "Email id",
                                      hintText: "harshit@gmail.com",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                child: TextField(
                                  obscureText: true,
                                  onTap: () {
                                    setState(() {
                                      _emailEditingCompleted = true;
                                      _passwordTapDone = true;
                                    });
                                  },
                                  onEditingComplete: () {
                                    setState(() {
                                      _passwordEditingCompleted = true;
                                    });
                                  },
                                  cursorColor: kDarkBlue,
                                  style: const TextStyle(color: kDarkBlue),
                                  controller: passwordTextEditingController,
                                  decoration: InputDecoration(
                                      errorText: _validatePassword(),
                                      errorStyle: errorFieldStyle,
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: kDarkBlue, width: 2.0)),
                                      labelStyle:
                                          const TextStyle(color: kDarkBlue),
                                      labelText: "Confirm Password",
                                      hintText: "*********",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                ),
                              ),
                              const SizedBox(height: 7.5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Checkbox(
                                    activeColor: kDarkBlue,
                                    value: _checkBox,
                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox = !_checkBox;
                                        _passwordEditingCompleted = true;
                                      });
                                    },
                                  ),
                                  Text('I accept terms and conditions',
                                      style: GoogleFonts.inter(
                                          color: kDarkBlue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500))
                                ],
                              ),
                              const SizedBox(height: 7.5),
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                child: Container(
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
                                    color: _validateAllFields()
                                        ? Colors.transparent
                                        : Colors.white54,
                                    child: InkWell(
                                      onTap: _validateAllFields()
                                          ? () async {
                                              //initiating loader
                                              setState(() {
                                                _loader = true;
                                              });
                                              RazorpayPayout razorpayPayout =
                                                  RazorpayPayout();
                                              await razorpayPayout.createPayout(
                                                  name:
                                                      nameTextEditingController
                                                          .text,
                                                  upiId:
                                                      upiTextEditingController
                                                          .text,
                                                  amount: _pointsToRupee,
                                                  email:
                                                      emailTextEditingController
                                                          .text);
                                              // updating points in airtable
                                              int pointsToUpdate = _points -
                                                  (int.parse(
                                                      pointsTextEditingController
                                                          .text
                                                          .toString()));
                                              await airtableApiServices
                                                  .updatePoints(pointsToUpdate);
                                              // updating funds in airtable
                                              await airtableApiServices
                                                  .updateFunds(
                                                      _funds - _pointsToRupee);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RedeemSuccess()));
                                            }
                                          : _fieldsNotEmpty
                                              ? () {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Wrong data in the fields",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT);
                                                }
                                              : () {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Fields cannot be empty",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT);
                                                },
                                      child: Center(
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/images/walletimage.png",
                                                width: 20,
                                                height: 20,
                                                fit: BoxFit.contain,
                                              ),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              Text("Redeem to Bank",
                                                  style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
