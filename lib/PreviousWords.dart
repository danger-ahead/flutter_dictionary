import 'package:flutter/material.dart';
import 'package:flutter_dictionary/WordsDatabase.dart';
import 'package:flutter_dictionary/results.dart';
import 'package:flutter_dictionary/words.dart';

class PreviousWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Previously searched words")),
      body: FutureBuilder<List<Word>>(
        future: WordsDatabase.instance.readAllWords(),
        builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Word item = snapshot.data![index];
                return Card(
                  shadowColor: Colors.black,
                  elevation: 4,
                  child: ListTile(
                    title: Text("\t\t" + item.word),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          color: Colors.blue,
                          icon: Icon(Icons.keyboard_arrow_right),
                          onPressed: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Results(item.word);
                            }));
                          },
                        ),
                        IconButton(
                          color: Colors.blue,
                          icon: Icon(Icons.close),
                          onPressed: () async {
                            await WordsDatabase.instance.delete(item.id);

                            Navigator.of(context).pop();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PreviousWords();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: TextButton(
          child: Text("DELETE SEARCH HISTORY"),
          onPressed: () async {
            await WordsDatabase.instance.deleteAll();

            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PreviousWords();
            }));
          },
        ),
      ),
    );
  }
}
