import 'dart:convert';
import 'package:http/http.dart' as http;

class Random {
  final String word;
  final String definition;
  final String pronunciation;

  Random(this.word, this.definition, this.pronunciation);
}

Future<Random> getRandomWord() async {
  var response =
      await http.get(Uri.https('random-words-api.vercel.app', 'word'));
  var jsonData = jsonDecode(response.body)[0];

  Random r = Random('Error', 'Error', 'Error');

  String word = jsonData["word"];
  String definition = jsonData["definition"];
  definition = definition.substring(0, definition.length - 2);
  String pronunciation = jsonData["pronunciation"];
  r = Random(word, definition, pronunciation);

  return r;
}
