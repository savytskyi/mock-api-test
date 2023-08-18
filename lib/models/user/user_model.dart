import 'dart:convert';
import 'package:test_task/networking/mock/mock_api.dart';

class User {
  static Future<bool> resetPassword(String email) async {

    // Send the request to our mocked API:
    final response = await MockApi.mockClient.post(
        Uri.parse("https://example.com/forgot-password"),
        body: jsonEncode({"email": email,})
    );

    // Make sure response code is OK; otherwise throw an error
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      // status == 1 means we found a user, and sent a recovery instructions
      // otherwise check for error messages if any
      // if no error messages, throw a generic error
      if (json["status"] == 1) {
        return true;
      } else if (json["error"] != null) {
        throw Exception(json["error"]);
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}