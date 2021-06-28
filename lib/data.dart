import 'dart:convert';
import 'package:http/http.dart' as http;

class Data {
  final String partOfSpeech;
  final String definition;

  Data(this.partOfSpeech, this.definition);
}

Future getData(String s) async {
  var response = await http
      .get(Uri.https('api.dictionaryapi.dev', 'api/v2/entries/en_US/' + s));
  var jsonData = jsonDecode(response.body)[0];

  List<Data> data = [];

  for (var x in jsonData["meanings"]) {
    String definition = x["definitions"][0]["definition"];
    Data d = Data(x["partOfSpeech"], definition);
    data.add(d);
  }
  print(data.length);
  print(data[0].partOfSpeech);
  print(data[0].definition);

  return data;
}
