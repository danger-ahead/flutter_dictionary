import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'parsers/random.dart';

class RandomResults extends StatelessWidget {
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
              "Error :(",
              style: GoogleFonts.michroma(),
            )),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: FutureBuilder(
                future: getRandomWord(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return CircularProgressIndicator();
                  } else {
                    var data = (snapshot.data as Random);
                    return Card(
                      color: Colors.yellow[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      shadowColor: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 8.0),
                        child: ListTile(
                            onTap: () {
                              Share.share("Here's a word for you, \"" +
                                  data.word +
                                  "\".\n\nIt means \"" +
                                  data.definition +
                                  "\".\n\n" +
                                  "Wondering about the pronunciation? It's \"" +
                                  data.pronunciation +
                                  "\".");
                            },
                            title: Text(
                              "You didn't enter any word!\nTAP TO SHARE!\n\n",
                              textScaleFactor: 1.7,
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(color: Colors.blue),
                              ),
                            ),
                            subtitle: Text(
                              "But here's a word for you, \"" +
                                  data.word +
                                  "\".\n\nIt means \"" +
                                  data.definition +
                                  "\".\n\n" +
                                  "Wondering about the pronunciation? It's \"" +
                                  data.pronunciation +
                                  "\".",
                              textScaleFactor: 1.6,
                              style: GoogleFonts.bigShouldersText(
                                textStyle: TextStyle(color: Colors.black),
                              ),
                            )),
                      ),
                    );
                  }
                }),
          ),
        ));
  }
}
