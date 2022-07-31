class Convo {
  Convo(this.name) {
    //todo: open up the hive box here
    messages = <Convo_Event>[];
  }

  final String name;
  List<Convo_Event>? messages;

  factory Convo.fromJSON(String name, Map<String, dynamic> data) {
    return Convo(name);
  }
}

class Convo_Event {
  Convo_Event(this.type, this.text);

  final String type;
  final String text;
}
