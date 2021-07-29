import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'parsers/data.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:share_plus/share_plus.dart';

class Results extends StatelessWidget {
  static String word = '';

  Results(String pass) {
    word = pass;
  }

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
            "Results",
            style: GoogleFonts.michroma(),
          )),
      body: FutureBuilder(
        future: getData(word.toString()),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          } else {
            var data = (snapshot.data as List<Data>).toList();
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Card(
                    color: Colors.yellow[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    shadowColor: Colors.black,
                    elevation: 8,
                    child: ListTile(
                      leading: IconButton(
                        color: Colors.blue,
                        onPressed: () {
                          final assetsAudioPlayer = AssetsAudioPlayer();
                          assetsAudioPlayer.open(
                            Audio.network(data[i].audioURL),
                          );
                          assetsAudioPlayer.play();
                        },
                        icon: Icon(Icons.volume_up),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Share.share(data[i].listTile);
                        },
                        icon: Icon(Icons.share),
                      ),
                      title: Text(
                          data[i].partOfSpeech + "\n\n" + data[i].definition,
                          textScaleFactor: 1.8,
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      subtitle: Text("Examples:\n\n" + data[i].example,
                          textScaleFactor: 1.7,
                          style: GoogleFonts.bigShouldersText(
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ); //ListTile
                });
          }
        },
      ),
    );
  }
}
