import 'package:flutter/material.dart';
import 'package:matrix_client/requests.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class ConvoScreen extends StatefulWidget {
  @override
  _RequestConvoScreenState createState() => _RequestConvoScreenState();
}

class _RequestConvoScreenState extends State<ConvoScreen> {
  Widget _buildLayout() {
    return Column(children: <Widget>[]);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = _buildLayout();
    return Scaffold(
      appBar: AppBar(
        title: Text("Test Main Screen"),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: _logoutButton,
            child: Text("Logout"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box('token').listenable(),
        builder: (context, box, widget) {
          return Column(children: <Widget>[]);
        },
      ),
    );
  }

  void _logoutButton() {
    Hive.box('token').delete('token');
  }
}
