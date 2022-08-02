import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'single_convo.dart';

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
  Hive.box('token').put('homeserver', decodedBody["home_server"]);
  Hive.box('token').put('user_id', decodedBody["user_id"]);
  Hive.box('token').put('device_id', decodedBody["device_id"]);

  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String prettyprint = encoder.convert(resp.body);
  return prettyprint;
}

Future<List<Convo>> getConvosRequest() async {
  var homeserver = (Hive.box('token').get('homeserver') is String)
      ? Hive.box('token').get('homeserver')
      : "";
  var token = Hive.box('token').get('token') as String;

  Map<String, String> headers = {"Authorization": "Bearer " + token};

  final urlToPost = Uri.https(homeserver, '_matrix/client/v3/sync');
  final client = http.Client();
  final resp = await client.get(urlToPost, headers: headers);

  var decodedBody = jsonDecode(resp.body);

  //TODO: we need to turn this into a factory at some point, this is gross
  final rooms = decodedBody["rooms"] as Map;
  final join = rooms["join"] as Map<String, dynamic>;

  var convoList = List<Convo>.empty(growable: true);

  join.forEach((key, value) {
    convoList.add(Convo.fromJSON(key, join[key] as Map<String, dynamic>));
  });

  return convoList;
}
