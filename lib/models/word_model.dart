import 'dart:convert';

List<WordModel> fromJson(String str) =>
    List<WordModel>.from(json.decode(str).map((x) => WordModel.fromJson(x)));

String toJson(List<WordModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WordModel {
  String word;
  List<Phonetic>? phonetics;
  List<Meaning>? meanings;
  License? license;
  List<String>? sourceUrls;

  WordModel({
    required this.word,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) => WordModel(
        word: json["word"],
        phonetics: List<Phonetic>.from(
            json["phonetics"].map((x) => Phonetic.fromJson(x))),
        meanings: List<Meaning>.from(
            json["meanings"].map((x) => Meaning.fromJson(x))),
        license: License.fromJson(json["license"]),
        sourceUrls: List<String>.from(json["sourceUrls"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "phonetics": phonetics == null
            ? null
            : List<dynamic>.from(phonetics!.map((x) => x.toJson())),
        "meanings": meanings == null
            ? null
            : List<dynamic>.from(meanings!.map((x) => x.toJson())),
        "license": license?.toJson(),
        "sourceUrls": sourceUrls == null
            ? null
            : List<dynamic>.from(sourceUrls!.map((x) => x)),
      };
}

class License {
  String? name;
  String? url;

  License({
    this.name,
    this.url,
  });

  factory License.fromJson(Map<String, dynamic> json) => License(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class Meaning {
  String? partOfSpeech;
  List<Definition>? definitions;
  List<String>? synonyms;
  List<String>? antonyms;

  Meaning({
    this.partOfSpeech,
    this.definitions,
    this.synonyms,
    this.antonyms,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) => Meaning(
        partOfSpeech: json["partOfSpeech"],
        definitions: List<Definition>.from(
            json["definitions"].map((x) => Definition.fromJson(x))),
        synonyms: List<String>.from(json["synonyms"].map((x) => x)),
        antonyms: List<String>.from(json["antonyms"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "partOfSpeech": partOfSpeech,
        "definitions": definitions == null
            ? null
            : List<dynamic>.from(definitions!.map((x) => x.toJson())),
        "synonyms": synonyms == null
            ? null
            : List<dynamic>.from(synonyms!.map((x) => x)),
        "antonyms": antonyms == null
            ? null
            : List<dynamic>.from(antonyms!.map((x) => x)),
      };
}

class Definition {
  String? definition;
  List<dynamic>? synonyms;
  List<dynamic>? antonyms;
  String? example;

  Definition({
    this.definition,
    this.synonyms,
    this.antonyms,
    this.example,
  });

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
        definition: json["definition"],
        synonyms: List<dynamic>.from(json["synonyms"].map((x) => x)),
        antonyms: List<dynamic>.from(json["antonyms"].map((x) => x)),
        example: json["example"],
      );

  Map<String, dynamic> toJson() => {
        "definition": definition,
        "synonyms": synonyms == null
            ? null
            : List<dynamic>.from(synonyms!.map((x) => x)),
        "antonyms": antonyms == null
            ? null
            : List<dynamic>.from(antonyms!.map((x) => x)),
        "example": example,
      };
}

class Phonetic {
  String? audio;
  String? sourceUrl;
  License? license;
  String? text;

  Phonetic({
    this.audio,
    this.sourceUrl,
    this.license,
    this.text,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) => Phonetic(
        audio: json["audio"],
        sourceUrl: json["sourceUrl"],
        license:
            json["license"] == null ? null : License.fromJson(json["license"]),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "audio": audio,
        "sourceUrl": sourceUrl,
        "license": license?.toJson(),
        "text": text,
      };
}
