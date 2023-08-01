import 'dart:convert';

List<RandomWordsModel> randomWordsModelFromJson(String str) =>
    List<RandomWordsModel>.from(
        json.decode(str).map((x) => RandomWordsModel.fromJson(x)));

String randomWordsModelToJson(List<RandomWordsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RandomWordsModel {
  final String word;
  final String definition;
  final String pronunciation;

  RandomWordsModel({
    required this.word,
    required this.definition,
    required this.pronunciation,
  });

  factory RandomWordsModel.fromJson(Map<String, dynamic> json) =>
      RandomWordsModel(
        word: json["word"],
        definition: json["definition"],
        pronunciation: json["pronunciation"],
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "definition": definition,
        "pronunciation": pronunciation,
      };
}
