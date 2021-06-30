import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'data.dart';

class Results extends StatelessWidget {
  static String word = '';

  Results(String pass) {
    word = pass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: FutureBuilder(
        future: getData(word.toString()),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: Text("Loading..."),
            ); //Center
          } else {
            var data = (snapshot.data as List<Data>).toList();
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(
                      "Part of Speech: " +
                          data[i].partOfSpeech +
                          ";\nMeaning: " +
                          data[i].definition,
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Example: " + data[i].example,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ); //ListTile
                }); //ListViw.builder
          }
        },
      ), //FutureBuilder
    ); //Scaffold
  }
}
