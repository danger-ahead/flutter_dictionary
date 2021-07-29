import 'package:flutter/material.dart';
import 'package:flutter_dictionary/WordsDatabase.dart';
import 'package:flutter_dictionary/results.dart';
import 'package:flutter_dictionary/words.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviousWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
          ),
          title: Text(
            "History",
            style: GoogleFonts.kosugi(),
          )),
      body: FutureBuilder<List<Word>>(
        future: WordsDatabase.instance.readAllWords(),
        builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                Word item = snapshot.data![index];
                return Card(
                  color: Colors.yellow[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  shadowColor: Colors.black,
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      "\t\t" + item.word,
                      textScaleFactor: 1.2,
                      style: GoogleFonts.overpassMono(),
                    ),
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
                          color: Colors.red,
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
        color: Colors.yellow[50],
        child: TextButton(
          child: Text(
            "DELETE SEARCH HISTORY",
            style: GoogleFonts.michroma(
              color: Colors.red,
            ),
          ),
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
