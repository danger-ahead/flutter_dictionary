import 'package:flutter/material.dart';
import 'data.dart';

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
            if (snapshot.data == null) {
              return Center(
                child: Text("Loading..."),
              );  //Center
            }else{
              var data = (snapshot.data as List<Data>).toList();
              return Center(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(data[i].definition),
                        subtitle: Text(data[i].partOfSpeech),
                      );  //ListTile
                    }), //ListView.builder
              );  //Center
            }
          },
        ),  //FutureBuilder
      ),  //Container
    );  //Scaffold
  }
}
