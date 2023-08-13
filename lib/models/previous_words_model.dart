// ignore_for_file: non_constant_identifier_names

class PreviousWordsModel {
  final String word;
  final String lang;
  final String? searched_at;

  PreviousWordsModel({
    required this.word,
    required this.lang,
    this.searched_at,
  });

  factory PreviousWordsModel.fromJson(Map<String, dynamic> json) {
    return PreviousWordsModel(
      word: json['word'],
      lang: json['lang'],
      searched_at: json['searched_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'word': word,
        'lang': lang,
        'searched_at': searched_at,
      };
}
