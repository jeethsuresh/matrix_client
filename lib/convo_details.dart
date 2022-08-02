import 'single_convo.dart';

import 'package:flutter/material.dart';

class ConvoDetails extends StatefulWidget {
  ConvoDetails(this.convo, this.isInTabletLayout);

  final Convo convo;

  final bool isInTabletLayout;

  @override
  _ConvoDetailsState createState() => _ConvoDetailsState();
}

class _ConvoDetailsState extends State<ConvoDetails> {
  @override
  Widget build(BuildContext context) {
    return Center(child: ListView(children: <Widget>[]));
  }
}
