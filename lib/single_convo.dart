import 'package:hive_flutter/hive_flutter.dart';

class Convo {
  Convo(this.id, {this.name = ""}) {
    //todo: open up the hive box here
    messages = <Convo_Event>[];
    participants = <Convo_Participant>[];
  }

  final String id;
  String name;
  List<Convo_Event>? messages;
  List<Convo_Participant>? participants;

  factory Convo.fromJSON(String id, Map<String, dynamic> data) {
    Convo toreturn = Convo(id);

    var stateArr = data["state"]["events"] as List<dynamic>;

    var messageParticipants = <String>[];

    stateArr.forEach((element) {
      var mapElement = element as Map<String, dynamic>;

      if (mapElement["type"] == "m.room.name") {
        var content = mapElement["content"] as Map<String, dynamic>;
        toreturn.name = content["name"];
      } else if (mapElement["type"] == "m.room.canonical_alias") {
        var content = mapElement["content"] as Map<String, dynamic>;
        toreturn.name = content["alias"];
      } else if (mapElement["type"] == "m.room.member") {
        var content = mapElement["content"] as Map<String, dynamic>;
        if (content["displayname"] != null ||
            content["sender"] != Hive.box('token').get('user_id')) {
          messageParticipants.add(content["displayname"] ?? "test");
        } else {
          print(content);
        }
      }
    });

    if (toreturn.name == "") {
      //TODO: fill in heroes
      if (messageParticipants.length > 0) {
        toreturn.name = messageParticipants.join(",");
      } else {
        toreturn.name = "Empty room";
      }
    }

    return toreturn;
  }
}

class Convo_Event {
  Convo_Event(this.type, this.text);

  final String type;
  final String text;
}

class Convo_Participant {
  Convo_Participant(this.name, {this.avatar});

  final String name;
  final String? avatar;
}
