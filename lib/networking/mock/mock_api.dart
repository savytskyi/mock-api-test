import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

class MockApi {
  // create a mocked REST API;
  // POST /forgot-password {email: "email"}
  static MockClient mockClient = MockClient((request) async {
    switch (request.url.toString()) {

      // We are required to have just one endpoint for now,
      // which will always return a 200 status code.
      case 'https://example.com/forgot-password':
        dynamic json = jsonDecode(request.body);
        if (json != null && json["email"] != null) {

          // List of emails in the database
          List<String> emails = ["mail@mail.com", "test@test.com"];
          if (emails.contains(json["email"])) {
            // User has passed the correct email that is present in the database
            return http.Response(jsonEncode({"status": 1}), 200);
          } else {
            // User has passed incorrect email
            return http.Response(jsonEncode({"error": "User not found"}), 200);
          }
        } else {
          return http.Response('{"error": "Incorrect payload"}', 404);
        }
      default:
        return http.Response('{"error": "not found"}', 404);
    }
  });
}