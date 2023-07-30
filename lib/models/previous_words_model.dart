// ignore_for_file: non_constant_identifier_names

class PreviousWordsModel {
  final String? id;
  final String word;
  final String lang;
  final String? created_at;

  PreviousWordsModel({
    this.id,
    required this.word,
    required this.lang,
    this.created_at,
  });

  factory PreviousWordsModel.fromJson(Map<String, dynamic> json) {
    return PreviousWordsModel(
      id: json['id'],
      word: json['word'],
      lang: json['lang'],
      created_at: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'word': word,
        'lang': lang,
        'created_at': created_at,
      };
}
