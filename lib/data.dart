import 'dart:convert';
import 'package:flutter_dictionary/words.dart';
import 'package:http/http.dart' as http;

import 'WordsDatabase.dart';

class Data {
  final String partOfSpeech;
  final String definition;
  final String example;
  final String audioURL;
  final String listTile;

  Data(this.partOfSpeech, this.definition, this.example, this.audioURL,
      this.listTile);
}

Future<List> getData(String s) async {
  var response = await http
      .get(Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en_US/' + s));
  var jsonData = jsonDecode(response.body)[0];

  List<Data> data = [];

  if (jsonData != null) {
    addWord(s);
    var phonetics = jsonData["phonetics"][0];

    for (var x in jsonData["meanings"]) {
      String definition = '';
      String example = '';

      var definitions = x["definitions"];
      for (var y in definitions) {
        definition += y["definition"] + "\n\n";
        y["example"] != null
            ? example += y["example"] + "\n\n"
            : example += "*example not available*";
      }

      definition = definition.substring(0, definition.length - 1);
      example = example.substring(0, example.length - 1);

      String listTile =
          x["partOfSpeech"] + "\n\n" + definition + "\n\n" + example;
      Data d = Data(
          x["partOfSpeech"], definition, example, phonetics["audio"], listTile);
      data.add(d);
    }
  } else {
    Data d = Data('ERROR', 'Could not find a definition\n',
        '*example not available*', '', '*Could not find a definition*');
    data.add(d);
  }
  return data;
}

Future addWord(String word) async {
  final newWord = Word(word: word);

  await WordsDatabase.instance.create(newWord);
}
