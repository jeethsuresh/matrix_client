import 'package:matrix_client/login.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:matrix_client/convos.dart';

StatefulWidget checkAuth() {
  var getToken = Hive.box('token').get('token');
  if (getToken != null && getToken is String) {
    if (getToken == "") {
      return const LoginScreen();
    } else {
      print("******" + getToken);
      return const ConvoScreen();
    }
  }
  return const LoginScreen();
}
