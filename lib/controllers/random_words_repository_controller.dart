import 'package:flutter_dictionary/models/random_words_model.dart';
import 'package:flutter_dictionary/services/random_words_repository_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final randomWordsRepositoryController =
    StateNotifierProvider<RandomWordsRepositoryController, bool>(
        (ref) => RandomWordsRepositoryController());

class RandomWordsRepositoryController extends StateNotifier<bool> {
  RandomWordsRepositoryController() : super(false);

  Future<List<RandomWordsModel>> getWord(FutureProviderRef ref) async {
    final data = await ref.watch(randomWordsRepositoryProvider).fetchWord();
    return data;
  }
}
