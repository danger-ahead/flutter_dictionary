import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_dictionary/PreviousWords.dart';
import 'package:flutter_dictionary/random_results.dart';
import 'results.dart';

dynamic layoutHomeAbout(int selected, BuildContext context) {
  TextEditingController _word = TextEditingController();

  List<Widget> widgetArray = [
    ListView(children: [
      ClipRect(
        child: Image.asset(
          'images/icon.png',
          scale: 2,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: TextField(
          controller: _word,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Search for a word',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 8),
        child: CupertinoButton(
            child: Text(
              "Search!",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: () async {
              String word = _word.text;
              _word.text = '';
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return word == '' ? RandomResults() : Results(word);
              })); //MaterialPageRoute
            }), //CupertinoButton
      ), //Padding
    ]), //SingleChildScrollView
    ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: CupertinoButton(
              child: Text(
                "Previously searched words",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PreviousWords();
                }));
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft)),
            child: ListTile(
              leading: ClipRect(
                  child: Image.network(
                      'https://avatars.githubusercontent.com/u/55531939?v=4')),
              //ClipRect
              title: Text(
                  "Hi I'm Shourya\nDICTIONARY is my first flutter project."), //Text
            ),
          ),
        ),
      ],
    )
  ];
  return widgetArray[selected];
}
