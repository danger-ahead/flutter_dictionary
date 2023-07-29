import 'package:flutter/material.dart';
import 'package:flutter_dictionary/WordsDatabase.dart';
import 'package:flutter_dictionary/results.dart';
import 'package:flutter_dictionary/words.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviousWords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Word>>(
      future: WordsDatabase.instance.readAllWords(),
      builder: (BuildContext context, AsyncSnapshot<List<Word>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Word item = snapshot.data![index];
                    return Card(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Results(item.word, item.lang);
                          }));
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\t\t" + item.word,
                                    style:
                                        GoogleFonts.overpassMono(fontSize: 18),
                                  ),
                                  Text(
                                    "\t\tlanguage:\t" + item.lang,
                                    style: GoogleFonts.overpassMono(),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              color: Colors.red,
                              icon: Icon(Icons.close),
                              onPressed: () async {
                                await WordsDatabase.instance.delete(item.id);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              TextButton(
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
              )
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
