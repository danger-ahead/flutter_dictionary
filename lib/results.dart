import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'data.dart';
import 'random.dart';

class Results extends StatelessWidget {
  static String word = '';

  Results(String pass){
    word = pass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Container(
        child: FutureBuilder(
          future: getData(word.toString()),
          builder: (context, snapshot) {
            if (word == ''){
              return FutureBuilder(
                future: getRandomWord(),
                builder: (context, snapshot) {
                  if (snapshot.data == null){
                    return Center(
                      child: Text("Loading..."),
                    );  //Center
                  } else{
                    var data = (snapshot.data as Random);
                    return ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.lightBlueAccent],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft)),
                          child: Center(
                            child: Text("You didn't enter any word, UGHHH!\n\nBut Here's a random word for you, \""+data.word
                            +"\".\nIt means \""+data.definition+"\".\nWondering about the pronunciation? \""+data.pronunciation+"\".",
                            style: TextStyle(color: Colors.white, fontSize: 16),),
                          ),
                        )
                      ],
                    );
                  }
                }
              );
            }
            else if (snapshot.data == null) {
              return Center(
                child: Text("Loading..."),
              );  //Center
            }else{
              var data = (snapshot.data as List<Data>).toList();
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text("Part of Speech: "+data[i].partOfSpeech+";\nMeaning: "+data[i].definition, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),),
                      subtitle: Text("Example: "+data[i].example, style: TextStyle(fontWeight: FontWeight.bold),),
                    );  //ListTile
                  });  //ListViw.builder
            }
          },
        ),  //FutureBuilder
      ),  //Container
    );  //Scaffold
  }
}
