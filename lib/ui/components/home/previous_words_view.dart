import 'package:flutter/material.dart';
import 'package:flutter_dictionary/constants/strings.dart';
import 'package:flutter_dictionary/controllers/fetch_words_repository_controller.dart';
import 'package:flutter_dictionary/controllers/words_repository_controller.dart';
import 'package:flutter_dictionary/models/previous_words_model.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/utils/get_language_code.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class PreviousWordsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final fetchWordsRepositoryCtrl =
          ref.watch(fetchWordsRepositoryController.notifier);
      return Column(
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
                            return GestureDetector(
                              onTap: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text("Loading..."),
                                        ),
                                      ],
                                    ),
                                  ),
                                );

                                fetchWordsRepositoryCtrl.word.text = item.word;
                                fetchWordsRepositoryCtrl.language.text =
                                    item.lang;
                                try {
                                  final data = await fetchWordsRepositoryCtrl
                                      .fetchMeaning(ref);

                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();

                                  Navigator.pushNamed(
                                      context, StringConstants.resultRoute,
                                      arguments: data);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Something went wrong! Try again'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                } finally {
                                  fetchWordsRepositoryCtrl.word.clear();
                                  fetchWordsRepositoryCtrl.language.clear();
                                }
                              },
                              child: Card(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.word,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20),
                                            ),
                                            Text(
                                              "Language: ${languageCodeToLanguage[item.lang] ?? item.lang}",
                                              style: GoogleFonts.poppins(),
                                            ),
                                            Text(
                                                "Searched on: ${item.searched_at?.substring(0, 19)}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      color: Colors.red,
                                      icon: Icon(Icons.close),
                                      onPressed: () async {
                                        ref
                                            .read(wordsRepositoryController
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
                loading: () => Center(child: CircularProgressIndicator())),
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
      );
    });
  }
}
