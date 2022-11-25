import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:tracker/api/airtable_api.dart';
import 'package:tracker/constants.dart';

class AddFunds extends StatefulWidget {
  const AddFunds({Key? key}) : super(key: key);

  @override
  _AddFundsState createState() => _AddFundsState();
}

class _AddFundsState extends State<AddFunds> {
  TextEditingController amountTextEditingController = TextEditingController();
  AirtableApiServices airtableApiServices = AirtableApiServices();
  late Razorpay _razorpay;
  bool _fund1Enabled = false;
  bool _fund2Enabled = false;
  bool _fund3Enabled = false;
  bool _fund4Enabled = false;
  int _funds = 0;
  var _response;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    asyncInit();
    super.initState();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  Future asyncInit() async {
    _response = await airtableApiServices.fetchAirtableData();
    _funds = await _response['records'][2]['fields']['funds'];
    _fund1Enabled = false;
    _fund2Enabled = false;
    _fund3Enabled = false;
    _fund4Enabled = false;
    setState(() {
      _fund1Enabled;
      _fund2Enabled;
      _fund3Enabled;
      _fund4Enabled;
      _funds;
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await airtableApiServices
        .updateFunds(_funds + int.parse(amountTextEditingController.text));
    await asyncInit();
    Fluttertoast.showToast(
        msg: "Payment Successfully done", toastLength: Toast.LENGTH_SHORT);
    amountTextEditingController.clear();
    print("Hello Payment success");
  }

  void _handlePaymentError(PaymentSuccessResponse response) {
    print("Payment error");
    Fluttertoast.showToast(
        msg: "Payment not completed try again",
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(PaymentSuccessResponse response) {
    print("External Wallet");
    Fluttertoast.showToast(
        msg: "Payment through external wallet2",
        toastLength: Toast.LENGTH_SHORT);
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_CjcgQktXxDPWIV",
      "amount": num.parse(amountTextEditingController.text) * 100,
      "name": "Tracker",
      "description": "Adding money in wallet",
      "prefill": {"contact": "+91 8506834755", "email": "harshit@harshit.com"},
      // "external": {
      //   "wallets": ["paytm"]
      // }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBlue2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkBlue,
        title: Text('ADD FUNDS',
            style:
                GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
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
                        const SizedBox(height: 60),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: 180,
                            height: 60,
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
                                      Image.asset(
                                        "assets/images/walletimage.png",
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      ),
                                      Text("₹ " + _funds.toString(),
                                          style: GoogleFonts.inter(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
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
              padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 230),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(18)),
                child: Container(
                  height: (MediaQuery.of(context).size.height) / 2.4,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 45),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("How much you would like to add?",
                            style: GoogleFonts.inter(
                                color: kDarkBlue,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 25),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("₹",
                                  style: GoogleFonts.inter(
                                      color: kDarkBlue,
                                      fontSize: 42,
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(width: 16),
                              SizedBox(
                                height: 50,
                                width: 120,
                                child: TextField(
                                  readOnly: true,
                                  style: GoogleFonts.inter(
                                      color: kDarkBlue,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                  keyboardType: TextInputType.number,
                                  controller: amountTextEditingController,
                                  decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: kDarkBlue, width: 2.0),
                                  )),
                                ),
                              ),
                            ]),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _fund1Enabled = true;
                                _fund2Enabled = false;
                                _fund3Enabled = false;
                                _fund4Enabled = false;

                                setState(() {
                                  _fund1Enabled;
                                  _fund2Enabled;
                                  amountTextEditingController.text = "100";
                                  _fund3Enabled;
                                  _fund4Enabled;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: _fund1Enabled
                                        ? kDarkBlue
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(
                                      width: 2,
                                      color: kDarkBlue,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text("+100",
                                      style: GoogleFonts.inter(
                                          color: _fund1Enabled
                                              ? Colors.white
                                              : kDarkBlue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _fund1Enabled = false;
                                _fund2Enabled = true;
                                _fund3Enabled = false;
                                _fund4Enabled = false;

                                setState(() {
                                  amountTextEditingController.text = "200";
                                  _fund1Enabled;
                                  _fund2Enabled;
                                  _fund3Enabled;
                                  _fund4Enabled;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: _fund2Enabled
                                        ? kDarkBlue
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(
                                      width: 2,
                                      color: kDarkBlue,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text("+200",
                                      style: GoogleFonts.inter(
                                          color: _fund2Enabled
                                              ? Colors.white
                                              : kDarkBlue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _fund1Enabled = false;
                                _fund2Enabled = false;
                                _fund3Enabled = true;
                                _fund4Enabled = false;
                                setState(() {
                                  amountTextEditingController.text = "500";
                                  _fund1Enabled;
                                  _fund2Enabled;
                                  _fund3Enabled;
                                  _fund4Enabled;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: _fund3Enabled
                                        ? kDarkBlue
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(
                                      width: 2,
                                      color: kDarkBlue,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text("+500",
                                      style: GoogleFonts.inter(
                                          color: _fund3Enabled
                                              ? Colors.white
                                              : kDarkBlue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _fund1Enabled = false;
                                _fund2Enabled = false;
                                _fund3Enabled = false;
                                _fund4Enabled = true;
                                setState(() {
                                  amountTextEditingController.text = "1000";
                                  _fund1Enabled;
                                  _fund2Enabled;
                                  _fund3Enabled;
                                  _fund4Enabled;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: _fund4Enabled
                                        ? kDarkBlue
                                        : Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(
                                      width: 2,
                                      color: kDarkBlue,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text("+1000",
                                      style: GoogleFonts.inter(
                                          color: _fund4Enabled
                                              ? Colors.white
                                              : kDarkBlue,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          child: Container(
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
                            child: Material(
                              child: InkWell(
                                onTap:
                                    amountTextEditingController.text.isNotEmpty
                                        ? () {
                                            openCheckout();
                                          }
                                        : null,
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
                                        Text("Add Funds to Wallet",
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
                        )
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
