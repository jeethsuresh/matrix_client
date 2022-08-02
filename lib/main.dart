import 'package:flutter/material.dart';
import 'package:matrix_client/check_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('token');
  // TODO: remove this line once we're confident that everything works.
  // This clears the Hive box that we use to store token and homeserver info
  // We should only remove this once it's clear we dont' need to mess with
  // The login screen (or once we add a logout button)
  // For now, a hot reload will not clear the token, but a hot RESTART will (r vs R)
  // Hive.box('token').clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box('token').listenable(),
        builder: (context, box, widget) {
          return checkAuth();
        },
      ),
    );
  }
}
