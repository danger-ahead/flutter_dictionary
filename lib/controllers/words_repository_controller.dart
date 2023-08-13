import 'package:flutter_dictionary/models/previous_words_model.dart';
import 'package:flutter_dictionary/providers.dart';
import 'package:flutter_dictionary/services/words_repository_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wordsRepositoryController =
    StateNotifierProvider<WordsRepositoryController, bool>(
        (ref) => WordsRepositoryController());

class WordsRepositoryController extends StateNotifier<bool> {
  WordsRepositoryController() : super(false);

  Future<void> saveWordToDevice(WidgetRef ref, PreviousWordsModel word) async {
    try {
      await WordsRepositoryService.saveWord(word).whenComplete(
        () => ref.refresh(saveWordFutureProvider),
      );
    } catch (e) {
      rethrow;
    }
  }

  void deleteSavedWord(WidgetRef ref, PreviousWordsModel word) async {
    try {
      await WordsRepositoryService.deleteSavedWord(word.word)
          .whenComplete(() => ref.refresh(saveWordFutureProvider));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PreviousWordsModel>> getSavedWords() async {
    return await WordsRepositoryService.getSavedWords();
  }

  Future<void> deleteAllSavedWords(WidgetRef ref) async {
    try {
      await WordsRepositoryService.deleteAllSavedWords()
          .whenComplete(() => ref.refresh(saveWordFutureProvider));
    } catch (e) {
      rethrow;
    }
  }
}
