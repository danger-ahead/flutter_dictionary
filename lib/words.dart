final String tableWords = 'words';

class WordFields {
  static final List<String> values = [id, word, lang];

  static final String id = '_id';
  static final String word = 'word';
  static final String lang = 'lang';
}

class Word {
  final int? id;
  final String word;
  final String lang;

  const Word({
    this.id,
    required this.word,
    required this.lang,
  });

  Word copy({
    int? id,
    String? word,
    String? lang,
  }) =>
      Word(
        id: id ?? this.id,
        word: word ?? this.word,
        lang: word ?? this.lang,
      );

  static Word fromJson(Map<String, Object?> json) => Word(
        id: json[WordFields.id] as int?,
        word: json[WordFields.word] as String,
        lang: json[WordFields.lang] as String,
      );

  Map<String, Object?> toJson() => {
        WordFields.id: id,
        WordFields.word: word,
        WordFields.lang: lang,
      };
}
