import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'data.dart';
import 'results.dart';

dynamic homeLayout(int selected, BuildContext context) {
  TextEditingController _word = TextEditingController();

  List<Widget> widgetArray = [
    SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(children: [
          ClipOval(
            child: Image.asset(
              'images/icon.png',
              scale: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              controller: _word,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search for a word',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: CupertinoButton(
                child: Text(
                  "Search!",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Results();
                  }));
                  _word.text = '';
                }),
          ),
        ]),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
      child: Column(
        children: [
          Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        'images/self.png',
                        scale: 4,
                      ),
                    ),
                  ),
                  Text(
                      "Hi I'm Shourya\n\nAnd DICTIONARY\nis my first flutter project."),
                ]),
          )
        ],
      ),
    )
  ];
  return widgetArray[selected];
}
