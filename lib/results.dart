import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_dictionary/words.dart';
import 'package:google_fonts/google_fonts.dart';
import 'WordsDatabase.dart';
import 'data.dart';
import 'widgets/custom.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Results extends StatelessWidget {
  static String word = '';

  Results(String pass) {
    word = pass;
  }

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
            "Results",
            style: GoogleFonts.michroma(),
          )),
      body: FutureBuilder(
        future: getData(word.toString()),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return loading;
          } else {
            addWord(word);
            var data = (snapshot.data as List<Data>).toList();
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, i) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    shadowColor: Colors.black,
                    elevation: 8,
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () {
                          final assetsAudioPlayer = AssetsAudioPlayer();
                          assetsAudioPlayer.open(
                            Audio.network(data[i].audioURL),
                          );
                          assetsAudioPlayer.play();
                        },
                        icon: Icon(Icons.volume_up),
                      ),
                      title: Text(
                          data[i].partOfSpeech + "\n\n" + data[i].definition,
                          style: GoogleFonts.josefinSans(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            fontSize: 30,
                          )),
                      subtitle: Text("Examples:\n\n" + data[i].example,
                          style: GoogleFonts.bigShouldersText(
                            textStyle: TextStyle(fontWeight: FontWeight.bold),
                            fontSize: 25,
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

Future addWord(String word) async {
  final newWord = Word(word: word);

  await WordsDatabase.instance.create(newWord);
}
