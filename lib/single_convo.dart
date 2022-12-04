//import 'dart:ffi';
import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

class Convo {
  Convo(this.id, {this.name = "", this.topic = ""}) {
    //todo: open up the hive box here
    messages = <Convo_Event>[];
    participants = <Convo_Participant>[];
  }

  final String id;
  String name;
  List<Convo_Event>? messages;
  List<Convo_Participant>? participants;
  int? created_time;
  String? guest_access;
  String? history_visibility;
  String? join_rule;
  String topic;

  factory Convo.fromJSON(String id, Map<String, dynamic> data) {
    Convo toreturn = Convo(id);

    var stateArr = data["state"]["events"] as List<dynamic>;
    var messageArr = data["timeline"]["events"] as List<dynamic>;

    var messageParticipants = <String>[];

    stateArr.forEach((element) {
      var mapElement = element as Map<String, dynamic>;

      var content = mapElement["content"] as Map<String, dynamic>;
      switch (mapElement["type"]) {
        case "m.room.name":
          {
            toreturn.name = content["name"];
          }
          break;
        case "m.room.canonical_alias":
          {
            toreturn.name = content["alias"];
          }
          break;
        case "m.room.member":
          {
            messageParticipants.add(content["displayname"] ?? "test");
          }
          break;
        case "m.room.create":
          {
            toreturn.created_time = (content["origin_server_ts"] ?? 0) as int;
          }
          break;
        case "m.room.encryption":
          {
            //Let's handle this later lmao
          }
          break;
        case "m.room.guest_access":
          {
            toreturn.guest_access = content["guest_access"];
          }
          break;
        case "m.room.power_levels":
          {
            //let's do this later too haha
          }
          break;
        case "m.room.join_rules":
          {
            toreturn.join_rule = content["join_rule"];
          }
          break;
        case "m.room.history_visibility":
          {
            toreturn.history_visibility = content["history_visibility"];
          }
          break;
        case "m.room.avatar":
          {
            //let's do this later too haha
          }
          break;
        case "m.room.topic":
          {
            toreturn.topic = content["topic"];
          }
          break;
        case "m.room.third_party_invite":
          {
            //this one looks useless?
          }
          break;
        default:
          {
            print(mapElement["type"]);
          }
          break;
      }
    });

    if (toreturn.name == "") {
      var participantsName = <String>[];
      for (var participant in messageParticipants) {
        var name = Hive.box('token').get('displayname') as String;
        if (name.toLowerCase() != participant.toLowerCase() &&
            Hive.box('token').get('user_id') != participant) {
          participantsName.add(participant);
        }
      }
      //TODO: heroes
      if (participantsName.length > 0) {
        toreturn.name = participantsName.join(",");
      } else {
        toreturn.name = "Empty room";
      }
    }

    ///// Process messages

    var counter = 0;
    messageArr.forEach((element) {
      var mapElement = element as Map<String, dynamic>;
      if (mapElement["state_key"] != null &&
          mapElement["state_key"] as String != "") {
        return;
      }
      var content = mapElement["content"] as Map<String, dynamic>;
      var printts = mapElement["origin_server_ts"] as int;
      if (counter > 100) {
        return;
      } else {
        counter = counter + 1;
      }
      if (content["ciphertext"] != null) {
        return;
      }
      print(json.encode(content) + " " + printts.toString());
    });

    return toreturn;
  }
}

class Convo_Event {
  Convo_Event(this.type, this.text);

  final String type;
  final String text;
}

class Convo_Message extends Convo_Event {
  Convo_Message(type, text, this.timestamp, this.author) : super(type, text);

  final String timestamp;
  final String author;
}

class Convo_Participant {
  Convo_Participant(this.name, {this.avatar});

  final String name;
  final String? avatar;
}
