import 'package:flutter/material.dart';

import 'package:matrix_client/single_convo.dart';
import 'requests.dart';

final convo_list = <Convo>[];

class ConvoList extends StatelessWidget {
  ConvoList(
    this.requestSelectedCallback, {Key? key}
  ) : super(key: key) {
    updateConvoList();
  }

  void updateConvoList() async {
    var convos = await getConvosRequest();
    convo_list.addAll(convos);
  }

  final ValueChanged<Convo> requestSelectedCallback;

  @override
  Widget build(BuildContext context) {
    Convo selectedRequest =
        (convo_list.isNotEmpty) ? convo_list[0] : Convo("Loading...");
    return Column(children: <Widget>[
      Expanded(
          child: ListView.builder(
              itemCount: convo_list.length,
              itemBuilder: (BuildContext context, int index) {
                //TODO: have this change when the box for rooms changes
                return ListTile(
                    title: Text(convo_list[index].name),
                    onTap: () => requestSelectedCallback(convo_list[index]),
                    selected: selectedRequest == convo_list[index]);
              }))
    ]);
  }
}
