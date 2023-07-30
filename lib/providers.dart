import 'package:flutter_dictionary/controllers/fetch_words_repository_controller.dart';
import 'package:flutter_dictionary/controllers/words_repository_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final saveWordFutureProvider = FutureProvider(
    (ref) => ref.watch(wordsRepositoryController.notifier).getSavedWords());

final fetchWordProvider = FutureProvider.family.autoDispose(
    (ref, WidgetRef n) =>
        ref.watch(fetchWordsRepositoryController.notifier).fetchMeaning(n));
