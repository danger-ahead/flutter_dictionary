import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'data.dart';

dynamic homeLayout(int selected) {
  TextEditingController _word = TextEditingController();

  List<Widget> widgetArray = [
    Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 265),
      child: Column(children: [
        TextField(
          controller: _word,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter word',
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CupertinoButton(
              child: Text(
                "Search",
                style: TextStyle(color: Colors.blue),
              ),
              color: Colors.black,
              onPressed: () {
                _word.text = '';
              }),
        )
      ]),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        child: Card(
            child: FutureBuilder(
                future: getData('hello'),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text('Loading')));
                  } else
                    return Text(
                      snapshot.data[0].partOfSpeech,
                    );
                })),
      ),
    )
  ];
  return widgetArray[selected];
}
