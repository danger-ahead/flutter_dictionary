import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_dictionary/words.dart';
import 'WordsDatabase.dart';
import 'data.dart';
import 'widgets/loading.dart';

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
            return loading; //Center
          } else {
            addWord(word);
            var data = (snapshot.data as List<Data>).toList();
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [Colors.blueAccent, Colors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )),
                      child: ListTile(
                        title: Text(
                          data[i].partOfSpeech + "\n\n" + data[i].definition,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Examples:\n\n" + data[i].example,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ); //ListTile
                }); //ListViw.builder
          }
        },
      ), //FutureBuilder
    ); //Scaffold
  }
}

Future addWord(String word) async{
  final newWord = Word(word: word);

  await WordsDatabase.instance.create(newWord);
}
