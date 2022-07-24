import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> loginRequest(String username, String password, String homeserver) async {
  Map<String, dynamic> body = {"user":username, "password": password, "type": "m.login.password"};
  
  final urlToPost = Uri.https(homeserver, '_matrix/client/r0/login');
  final client = http.Client();
  final resp = await client.post(
    urlToPost,
    body: jsonEncode(body),
  );

  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(resp.body);
  return prettyprint;
}