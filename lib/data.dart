import 'dart:convert';
import 'package:http/http.dart' as http;

class Data {
  final String partOfSpeech;
  final String definition;
  final String example;
  final String audioURL;

  Data(this.partOfSpeech, this.definition, this.example, this.audioURL);
}

Future<List> getData(String s) async {
  var response = await http
      .get(Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en_US/' + s));
  var jsonData = jsonDecode(response.body)[0];

  var phonetics = jsonData["phonetics"][0];
  String url = phonetics["audio"];

  List<Data> data = [];

  for (var x in jsonData["meanings"]) {
    String definition = '';
    String example = '';

    var definitions = x["definitions"];
    for (var y in definitions) {
      definition += y["definition"] + "\n\n";
      if (y["example"] != null) {
        example += y["example"] + "\n\n";
      } else {
        example += "*example not available* ";
      }
    }

    definition = definition.substring(0, definition.length - 1);
    example = example.substring(0, example.length - 1);
    Data d = Data(x["partOfSpeech"], definition, example, url);
    data.add(d);
  }
  return data;
}
