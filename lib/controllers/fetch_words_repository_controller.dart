import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dictionary/models/previous_words_model.dart';
import 'package:flutter_dictionary/models/word_model.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/services/fetch_words_respository_service.dart';
import 'package:flutter_dictionary/services/words_repository_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchWordsRepositoryController =
    StateNotifierProvider<FetchWordsRepositoryController, WordModel>(
        (ref) => FetchWordsRepositoryController());

class FetchWordsRepositoryController extends StateNotifier<WordModel> {
  FetchWordsRepositoryController()
      : super(WordModel(
            word: "",
            phonetics: [],
            meanings: [],
            license: License(name: "", url: ""),
            sourceUrls: []));

  final word = TextEditingController();
  final language = TextEditingController();

  Future<List<WordModel>> fetchMeaning(WidgetRef ref) async {
    try {
      await WordsRepositoryService.saveWord(PreviousWordsModel(
        word: word.text,
        lang: language.text,
      )).whenComplete(() => ref.refresh(saveWordFutureProvider));
      return await ref
          .watch(fetchWordsRepositoryProvider)
          .fetchMeaning(word.text, language.text);
    } on SocketException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
