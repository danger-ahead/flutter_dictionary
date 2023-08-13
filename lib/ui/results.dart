import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/models/word_model.dart';
import 'package:google_fonts/google_fonts.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<WordModel>;

    String _phoneticAudio = '', _phoneticText = '';

    if (args[0].phonetics != null) {
      for (int i = 0; i < args[0].phonetics!.length; i++) {
        if (args[0].phonetics![i].text != null) {
          _phoneticText = args[0].phonetics![i].text!;
        }
        if (args[0].phonetics![i].audio != null) {
          _phoneticAudio = args[0].phonetics![i].audio!;
        }
        if (_phoneticAudio != '' && _phoneticText != '') {
          break;
        }
      }
    }

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
            args[0].word,
            style: GoogleFonts.concertOne(),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(_phoneticText, style: GoogleFonts.josefinSans(fontSize: 18)),
              IconButton(
                  color: _phoneticAudio != '' ? Colors.blue : Colors.grey,
                  onPressed: _phoneticAudio != ''
                      ? () async {
                          final player = AudioPlayer();
                          await player.play(UrlSource(_phoneticAudio));
                        }
                      : null,
                  icon: Icon(Icons.volume_up_rounded)),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: args[0].meanings?.length,
                itemBuilder: ((context, index) {
                  final item = args[0].meanings?[index];

                  final String synonyms = item?.synonyms?.join(', ') ?? '';
                  final String antonyms = item?.antonyms?.join(', ') ?? '';

                  List<Text> definitions = [];
                  List<Widget> examples = [];

                  if (item?.definitions != null) {
                    final int length = item?.definitions?.length ?? 0;
                    for (int i = 0; i < length; i++) {
                      definitions.add(Text(
                          "${i + 1}. ${item?.definitions?[i].definition}",
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w500)));
                      if (item?.definitions?[i].example != null &&
                          item?.definitions?[i].example != "") {
                        examples.add(Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child:
                              Text("Example: ${item?.definitions?[i].example}"),
                        ));
                      } else {
                        examples.add(SizedBox(
                          height: 10,
                        ));
                      }
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.partOfSpeech ?? "",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        synonyms != ""
                            ? Text("Synonyms: $synonyms",
                                style: GoogleFonts.poppins())
                            : SizedBox.shrink(),
                        antonyms != ""
                            ? Text("Antonyms: $antonyms",
                                style: GoogleFonts.poppins())
                            : SizedBox.shrink(),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0; i < definitions.length; i++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    definitions[i],
                                    examples[i],
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}
