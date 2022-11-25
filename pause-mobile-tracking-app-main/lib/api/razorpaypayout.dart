import 'dart:convert';
import 'package:http/http.dart';
import 'package:tracker/constants.dart';

class RazorpayPayout {
  Future createPayout(
      {required String name,
      required String upiId,
      required int amount,
      required String email}) async {
    String username = 'rzp_test_CjcgQktXxDPWIV';
    String password = '8Mx8mM1h3ZogDc5pWCs7isIV';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    String razorpayUrl = "https://api.razorpay.com/v1/payouts";
    Response response = await post(Uri.parse(razorpayUrl),
        body: jsonEncode({
          "account_number": razorpayAccountNum,
          "amount": amount * 100,
          "currency": "INR",
          "mode": "UPI",
          "purpose": "payout",
          "fund_account": {
            "account_type": "vpa",
            "vpa": {"address": upiId},
            "contact": {
              "name": name,
              "email": email,
              "contact": "8506834755",
              "type": "self",
              "reference_id": "Acme Contact ID 12345",
              "notes": {
                "notes_key_1": "notes key 1",
                "notes_key_2": "notes key 2"
              }
            }
          },
          "queue_if_low_balance": true,
          "reference_id": "reference id 8121",
          "narration": "naration",
          "notes": {"notes_key_1": "note 1", "notes_key_2": "note 2"}
        }),
        headers: {
          "Content-Type": "application/json",
          'authorization': basicAuth,
        });
    if (response.statusCode == 200) {
      String apiData = response.body;
      return jsonDecode(apiData);
    } else {
      print(response.statusCode);
    }
  }
}
