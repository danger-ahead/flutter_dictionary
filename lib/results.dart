// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'parsers/data.dart';
import 'package:share_plus/share_plus.dart';

class Results extends StatelessWidget {
  static String word = '';
  static String language = '';

  Results(String pass, String choice) {
    switch (choice) {
      case 'English (US)':
        language = 'en_US';
        break;
      case 'English (UK)':
        language = 'en_GB';
        break;
      case 'French':
        language = 'fr';
        break;
      case 'German':
        language = 'de';
        break;
      case 'Italian':
        language = 'it';
        break;
      case 'Hindi':
        language = 'hi';
        break;
      case 'Russian':
        language = 'ru';
        break;
      case 'Spanish':
        language = 'es';
        break;
      case 'Korean':
        language = 'ko';
        break;
      case 'Arabic':
        language = 'ar';
        break;
      case 'Japanese':
        language = 'ja';
        break;
      default:
        language = choice;
    }
    word = pass;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(8),
            ),
          ),
          title: Text(
            "Results",
            style: GoogleFonts.michroma(),
          )),
      body: FutureBuilder(
        future: getData(word, language),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            var data = (snapshot.data as List<Data>).toList();
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(data[i].partOfSpeech,
                                      textScaleFactor: 1.8,
                                      style: GoogleFonts.josefinSans(
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      color: data[i].audioURL != ''
                                          ? Colors.blue
                                          : Colors.grey,
                                      onPressed: () async {
                                        print(data[i].audioURL);
                                        final player = AudioPlayer();
                                        await player
                                            .play(UrlSource(data[i].audioURL));
                                      },
                                      icon: data[i].audioURL != ''
                                          ? Icon(Icons.volume_up_rounded)
                                          : Icon(Icons.volume_off_rounded),
                                    ),
                                    IconButton(
                                      color: Colors.blue,
                                      onPressed: () {
                                        Share.share(data[i].listTile);
                                      },
                                      icon: Icon(Icons.share),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              data[i].definition,
                              textScaleFactor: 1.7,
                              style: GoogleFonts.bigShouldersText(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Examples:",
                              style: GoogleFonts.bigShouldersText(fontSize: 20),
                            ),
                            Text(data[i].example,
                                style: GoogleFonts.bigShouldersText(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ); //ListTile
                });
          }
        },
      ),
    );
  }
}
