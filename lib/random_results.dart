import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/custom.dart';

import 'random.dart';

class RandomResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
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
                    return noWordError;
                  } else {
                    var data = (snapshot.data as Random);
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      shadowColor: Colors.blueGrey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24.0, horizontal: 8.0),
                        child: Text.rich(TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: "You didn't enter any word!\n\n",
                            style: GoogleFonts.josefinSans(
                              textStyle:
                                  TextStyle(color: Colors.blue, fontSize: 30),
                            ),
                          ),
                          TextSpan(
                            text: "But here's a word for you, \"" +
                                data.word +
                                "\".\n\n",
                            style: GoogleFonts.bigShouldersText(
                              textStyle:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ),
                          TextSpan(
                            text: "It means \"" + data.definition + "\".\n\n",
                            style: GoogleFonts.bigShouldersText(
                              textStyle:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ),
                          TextSpan(
                            text: "Wondering about the pronunciation? It's \"" +
                                data.pronunciation +
                                "\".\n",
                            style: GoogleFonts.bigShouldersText(
                              textStyle:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          )
                        ])),
                      ),
                    );
                  }
                }),
          ),
        ));
  }
}
