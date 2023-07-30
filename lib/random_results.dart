import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'parsers/random.dart';

class RandomResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Icon(Icons.arrow_back_ios),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Error :(",
              style: GoogleFonts.concertOne(),
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
                    return GestureDetector(
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
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  "You didn't enter any word!\nTAP TO SHARE!\n\n",
                                  textScaleFactor: 1.7,
                                  style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(color: Colors.blue),
                                  ),
                                ),
                                Text(
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
                                )
                              ],
                            )),
                      ),
                    );
                  }
                }),
          ),
        ));
  }
}
