import 'dart:convert';
import 'package:http/http.dart';

class AirtableApiServices {
  final String apiUrl =
      "https://api.airtable.com/v0/appJekLjTTEi54qov/Table%201?api_key=keyOqo6abUtCx4Dn9";

  AirtableApiServices();
  Future fetchAirtableData() async {
    Response response = await get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      String apiData = response.body;
      return jsonDecode(apiData);
    } else {
      print(response.statusCode);
    }
  }

  Future updateToClaimed(String dateTime) async {
    Response response = await patch(Uri.parse(apiUrl),
        body: jsonEncode({
          "records": [
            {
              "id": "recsTnbfWtl00EiFo",
              "fields": {"claimed": 1, "date": dateTime}
            }
          ]
        }),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      String apiData = response.body;
      return jsonDecode(apiData);
    } else {
      print(response.statusCode);
    }
  }

  Future updatePoints(int points) async {
    Response response = await patch(Uri.parse(apiUrl),
        body: jsonEncode({
          "records": [
            {
              "id": "recsTnbfWtl00EiFo",
              "fields": {
                "rewardcoins": points,
              }
            }
          ]
        }),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      String apiData = response.body;
      return jsonDecode(apiData);
    } else {
      print(response.statusCode);
    }
  }

  Future updateFunds(int funds) async {
    Response response = await patch(Uri.parse(apiUrl),
        body: jsonEncode({
          "records": [
            {
              "id": "recsTnbfWtl00EiFo",
              "fields": {
                "funds": funds,
              }
            }
          ]
        }),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      String apiData = response.body;
      return jsonDecode(apiData);
    } else {
      print(response.statusCode);
    }
  }
}
