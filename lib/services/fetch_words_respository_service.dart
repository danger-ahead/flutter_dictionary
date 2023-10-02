import 'package:flutter_dictionary/exceptions/word_not_found_exception.dart';
import 'package:flutter_dictionary/models/word_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final fetchWordsRepositoryProvider =
    Provider((ref) => FetchWordsRepositoryServiceImpl(Client()));

abstract class FetchWordsRepositoryService {
  Future fetchMeaning(String word, String language);
}

class FetchWordsRepositoryServiceImpl implements FetchWordsRepositoryService {
  final Client client;
  FetchWordsRepositoryServiceImpl(this.client);

  @override
  Future<List<WordModel>> fetchMeaning(String word, String language) async {
    final response = await client.get(Uri.https(
        'api.dictionaryapi.dev', 'api/v2/entries/' + language + '/' + word));

    if (response.statusCode == 404) {
      throw WordNotFoundException();
    } else {
      final data = fromJson(response.body);
      return data;
    }
  }
}
