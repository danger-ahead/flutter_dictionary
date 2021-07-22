final String tableWords = 'words';

class WordFields {
  static final List<String> values = [id, word];

  static final String id = '_id';
  static final String word = 'word';
}

class Word {
  final int? id;
  final String word;

  const Word({
    this.id,
    required this.word,
  });

  Word copy({
    int? id,
    String? word,
  }) =>
      Word(
        id: id ?? this.id,
        word: word ?? this.word,
      );

  static Word fromJson(Map<String, Object?> json) => Word(
        id: json[WordFields.id] as int?,
        word: json[WordFields.word] as String,
      );

  Map<String, Object?> toJson() => {
        WordFields.id: id,
        WordFields.word: word,
      };
}
