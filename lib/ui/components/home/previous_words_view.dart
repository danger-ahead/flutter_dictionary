import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/controllers/words_repository_controller.dart';
import 'package:flutter_dictionary/models/previous_words_model.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviousWordsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, _) => Column(
              children: [
                Expanded(
                  child: ref.watch(saveWordFutureProvider).when(
                      data: (data) => data.isEmpty
                          ? Center(
                              child: Text("No Words"),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  PreviousWordsModel item = data[index];
                                  return Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            StringConstants.resultRoute);
                                      },
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "\t\t" + item.word,
                                                  style:
                                                      GoogleFonts.overpassMono(
                                                          fontSize: 18),
                                                ),
                                                Text(
                                                  "\t\tlanguage:\t" + item.lang,
                                                  style: GoogleFonts
                                                      .overpassMono(),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            color: Colors.red,
                                            icon: Icon(Icons.close),
                                            onPressed: () async {
                                              ref
                                                  .read(
                                                      wordsRepositoryController
                                                          .notifier)
                                                  .deleteSavedWord(ref, item);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                      error: (e, t) => Center(child: Text(e.toString())),
                      loading: () =>
                          Center(child: CircularProgressIndicator())),
                ),
                TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete_forever, color: Colors.red),
                      SizedBox(width: 10.0),
                      Text(
                        "Clear History",
                        style: GoogleFonts.poiretOne(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    ref
                        .read(wordsRepositoryController.notifier)
                        .deleteAllSavedWords(ref);
                  },
                )
              ],
            ));
  }
}
