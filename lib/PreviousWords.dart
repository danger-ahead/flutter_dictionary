import 'package:flutter/material.dart';
import 'package:flutter_dictionary/WordsDatabase.dart';
import 'package:flutter_dictionary/words.dart';

class PreviousWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Previous searched words")),
      body: FutureBuilder<List<Word>>(
        future: WordsDatabase.instance.readAllWords(),
        builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Word item = snapshot.data![index];
                return ListTile(
                  title: Text(item.id.toString()),
                  leading: Text(item.id.toString()),
                  trailing: Text(item.word),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}