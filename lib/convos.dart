import 'package:flutter/material.dart';
import 'package:matrix_client/convo_list.dart';
import 'package:matrix_client/single_convo.dart';
import 'package:matrix_client/convo_details.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConvoScreen extends StatefulWidget {
  @override
  _RequestConvoScreenState createState() => _RequestConvoScreenState();
}

class _RequestConvoScreenState extends State<ConvoScreen> {
  //I think we can make this higher actually, now that screens are so hiDPI
  static const int kTabletBreakpoint = 600;

  late Convo _selectedConvo;

  Widget _buildMobileLayout() {
    return ConvoList((convo) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ConvoDetails(convo, false)));
    });
  }

  Widget _buildTabletLayout() {
    _selectedConvo =
        (convo_list.length > 0) ? convo_list[0] : Convo("Loading...");
    return Row(children: <Widget>[
      Flexible(
          flex: 1,
          child: Material(
            elevation: 4.0,
            child: ConvoList((convo) {
              setState(() {
                _selectedConvo = convo;
              });
            }),
          )),
      Flexible(flex: 3, child: ConvoDetails(_selectedConvo, true))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;

    Widget content = (shortestSide < kTabletBreakpoint)
        ? _buildMobileLayout()
        : _buildTabletLayout();
    return Scaffold(
      appBar: AppBar(title: Text("Test Main Screen")),
      body: ValueListenableBuilder<Box>(
        valueListenable: Hive.box('token').listenable(),
        builder: (context, box, widget) {
          return content;
        },
      ),
    );
  }
}
