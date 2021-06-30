import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'results.dart';

dynamic homeLayout(int selected, BuildContext context) {
  TextEditingController _word = TextEditingController();

  List<Widget> widgetArray = [
    SingleChildScrollView(
      reverse: true,
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
                  return Results(_word.text);
                }));  //MaterialPageRoute
              }), //CupertinoButton
        ),  //Padding
      ]),  //Column
    ),  //SingleChildScrollView
    ListView(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.lightBlueAccent],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft
            )
          ),
          child: ListTile(
            leading: ClipRect(
                child: Image.network('https://avatars.githubusercontent.com/u/55531939?v=4')
            ),  //ClipRect
            title: Text(
                "Hi I'm Shourya\nDICTIONARY is my first flutter project."),  //Text
          ),
        ),
      ],
    )
  ];
  return widgetArray[selected];
}
