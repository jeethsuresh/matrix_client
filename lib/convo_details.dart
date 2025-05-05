import 'single_convo.dart';
import 'package:flutter/material.dart';
import 'requests.dart';
import 'message.dart';

List<Message> messages = <Message>[];
String end = "";

class ConvoDetails extends StatefulWidget {
  final Convo convo;

  const ConvoDetails(this.convo, {Key? key}) : super(key: key);
  @override
  _ConvoDetailsState createState() => _ConvoDetailsState();
}


class _ConvoDetailsState extends State<ConvoDetails> {
  void updateMessages() async {
    var m = await getMessagesRequest(widget.convo.id, end);

    end = m["end"] as String;
    final chunks = m["chunk"] as List<dynamic>;

    for (var value in chunks) {
      var message = value['content']['body'];
      var sender = value['sender'];
      messages.add(Message(message, sender));
    }
    setState(() {
              _messages = messages;
       });
  }


  late List<Message> _messages;

  @override
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
                    title: Text(_messages[index].sender + ": " + _messages[index].content)
                    );
              })))
    ]);
  }
}

