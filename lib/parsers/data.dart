import 'dart:convert';
import 'package:flutter_dictionary/words.dart';
import 'package:http/http.dart' as http;

import '../WordsDatabase.dart';

class Data {
  final String partOfSpeech;
  final String definition;
  final String example;
  final String audioURL;
  final String listTile;

  Data(this.partOfSpeech, this.definition, this.example, this.audioURL,
      this.listTile);
}

Future<List> getData(String word, String language) async {
  var response = await http.get(Uri.https(
      'api.dictionaryapi.dev', 'api/v2/entries/' + language + '/' + word));
  var information = jsonDecode(response.body);

  List<Data> data = [];

  if (information is List) {
    addWord(word, language);
    for (var jsonData in information) {
      var phonetics;
      if (jsonData["phonetics"].length > 0)
        phonetics = jsonData["phonetics"][0];
      else
        phonetics = {'audio': ''};

      for (var x in jsonData["meanings"]) {
        String definition = '';
        String example = '';

        var definitions = x["definitions"];
        for (var y in definitions) {
          definition += y["definition"] + "\n\n";
          y["example"] != null
              ? example += y["example"] + "\n\n"
              : example += "*example not available*  ";
        }

        definition = definition.substring(0, definition.length - 1);
        example = example.substring(0, example.length - 2);

        String listTile =
            x["partOfSpeech"] + "\n\n" + definition + "\n\n" + example;
        Data d = Data(x["partOfSpeech"], definition, example,
            phonetics["audio"] == null ? '' : phonetics["audio"], listTile);
        data.add(d);
      }
    }
  } else {
    Data d = Data('ERROR', 'Could not find a definition\n',
        '*example not available*', '', '*Could not find a definition*');
    data.add(d);
  }
  return data;
}

Future addWord(String word, String language) async {
  final newWord = Word(word: word, lang: language);

  await WordsDatabase.instance.create(newWord);
}
