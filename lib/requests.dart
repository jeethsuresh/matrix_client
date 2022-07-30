import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';

Future<String> loginRequest(
    String username, String password, String homeserver) async {
  Map<String, dynamic> body = {
    "user": username,
    "password": password,
    "type": "m.login.password"
  };

  final urlToPost = Uri.https(homeserver, '_matrix/client/r0/login');
  final client = http.Client();
  final resp = await client.post(
    urlToPost,
    body: jsonEncode(body),
  );

  var decodedBody = jsonDecode(resp.body);

  Hive.box('token').put('token', decodedBody["access_token"]);

  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(resp.body);
  return prettyprint;
}
