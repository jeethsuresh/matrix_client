import 'single_convo.dart';
import 'package:flutter/material.dart';
import 'requests.dart';

final messages = <String>[];

class ConvoDetails extends StatefulWidget {
  final Convo convo;

  ConvoDetails(this.convo);
  @override
  _ConvoDetailsState createState() => _ConvoDetailsState();
}


class _ConvoDetailsState extends State<ConvoDetails> {
  void updateMessages() async {
    var m = await getMessagesRequest(widget.convo.id);
    print(m);
    messages.addAll(m);
    setState(() {
              _messages = messages;
       });
  }


  late List<String> _messages;

  Widget build(BuildContext context) {
    updateMessages();
    _messages = messages;
    return Row(children: <Widget>[
      Flexible(
        child: Material(
          child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                //TODO: have this change when the box for rooms changes

                return ListTile(
                    title: Text(_messages[index])
                    );
              })))
    ]);
  }
}

