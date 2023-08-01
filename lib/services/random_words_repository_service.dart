import 'package:flutter_dictionary/models/random_words_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final randomWordsRepositoryProvider =
    Provider((ref) => RandomWordsRepositoryServiceImpl(Client()));

class RandomWordsRepositoryServiceImpl {
  final Client client;
  RandomWordsRepositoryServiceImpl(this.client);

  Future<List<RandomWordsModel>> fetchWord() async {
    final response =
        await client.get(Uri.https('random-words-api.vercel.app', 'word'));

    final data = randomWordsModelFromJson(response.body);

    return data;
  }
}
