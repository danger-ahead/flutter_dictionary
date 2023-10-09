import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/models/word_model.dart';
import 'package:flutter_dictionary/themeprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<WordModel>;

    String _phoneticAudio = '', _phoneticText = '';

    if (args[0].phonetics != null) {
      for (final phonetic in args[0].phonetics ?? []) {
        if (phonetic.text != null) {
          _phoneticText = phonetic.text!;
        }
        if (phonetic.audio != null) {
          _phoneticAudio = phonetic.audio!;
        }
        if (_phoneticAudio != '' && _phoneticText != '') {
          break;
        }
      }
    }
    return Consumer(builder: (context, ref, _)
    {
      var theme = ref.watch(themeProvider.notifier).value;
      var pronunciationBgColor = theme == ThemeMode.dark
          ? Colors.grey.shade800
          : theme == ThemeMode.light
              ? Colors.white
              : MediaQuery.of(context).platformBrightness == Brightness.dark
                  ? Colors.grey.shade800
                  : Colors.white;
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
        body: Stack(
          fit: StackFit.expand,
          children: [
            ListView.builder(
                itemCount: args[0].meanings?.length,
                itemBuilder: ((context, index) {
                  final item = args[0].meanings?[index];

                  final String synonyms = item?.synonyms?.join(', ') ?? '';
                  final String antonyms = item?.antonyms?.join(', ') ?? '';

                  List<Row> definitions = [];
                  List<Widget> examples = [];

                  if (item?.definitions != null) {
                    final int length = item?.definitions?.length ?? 0;
                    for (int i = 0; i < length; i++) {
                      definitions.add(Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${i + 1}. ",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item?.definitions?[i].definition}",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                (item?.definitions?[i].example != null &&
                                    item?.definitions?[i].example != "")
                                    ? Padding(
                                  padding:
                                  const EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                      "Example: ${item?.definitions?[i]
                                          .example}"),
                                )
                                    : SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                          ),
                        ],
                      ));
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
                    child: Card(
                      child: Padding(
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
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  synonyms != ""
                                      ? Container(
                                    padding: EdgeInsets.all(5),
                                    child: synonyms != ""
                                        ? Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Synonyms:",
                                          style: GoogleFonts.poppins(
                                              fontWeight:
                                              FontWeight.w500,
                                              decoration:
                                              TextDecoration
                                                  .underline),
                                        ),
                                        Text(
                                          synonyms,
                                          style:
                                          GoogleFonts.poppins(),
                                        ),
                                      ],
                                    )
                                        : SizedBox.shrink(),
                                  )
                                      : SizedBox.shrink(),
                                  antonyms != ""
                                      ? Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Antonyms:",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                            TextDecoration.underline,
                                          ),
                                        ),
                                        Text(
                                          "$antonyms",
                                          style: GoogleFonts.poppins(),
                                        )
                                      ],
                                    ),
                                  )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0; i < definitions.length; i++)
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        definitions[i],
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
            Positioned(
              right: 20,
              bottom: 20,
              child: PhysicalModel(
                color: pronunciationBgColor,
                elevation: 5,
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(_phoneticText,
                          style: GoogleFonts.josefinSans(fontSize: 18)),
                      IconButton(
                          color: _phoneticAudio != '' ? Colors.blue : Colors
                              .grey,
                          onPressed: _phoneticAudio != ''
                              ? () async {
                            final player = AudioPlayer();
                            await player.play(UrlSource(_phoneticAudio));
                          }
                              : null,
                          icon: Icon(Icons.volume_up_rounded)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
