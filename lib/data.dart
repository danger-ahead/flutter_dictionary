import 'dart:convert';
import 'package:http/http.dart' as http;

class Data {
  final String partOfSpeech;
  final String definition;
  final String example;

  Data(this.partOfSpeech, this.definition, this.example);
}

Future<List> getData(String s) async {
  var response = await http
      .get(Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en_US/' + s));
  var jsonData = jsonDecode(response.body)[0];

  List<Data> data = [];

  for (var x in jsonData["meanings"]) {
    String definition = x["definitions"][0]["definition"];
    String example = x["definitions"][0]["example"];
    Data d = Data(x["partOfSpeech"], definition, example);
    data.add(d);
  }

  return data;
}
