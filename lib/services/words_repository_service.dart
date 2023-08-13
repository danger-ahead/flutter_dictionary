import 'package:flutter_dictionary/models/previous_words_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class WordsRepositoryService {
  static const String TABLE = 'previous_words';
  static const String DB_NAME = 'dictionary.db';
  static const String WORD = 'word';
  static const String LANG = 'lang';
  static const String SEARCHED_AT = 'searched_at';

  static Future<Database?> get _db async => await initDB();

  static Future<Database?> initDB() async {
    final directory = await getDatabasesPath();
    final path = join(directory, DB_NAME);
    return openDatabase(path, version: 1, onCreate: createDatabase);
  }

  static createDatabase(Database db, int version) async {
    await db.execute('''CREATE TABLE $TABLE(
      $WORD TEXT PRIMARY KEY,
      $SEARCHED_AT TEXT NOT NULL,
      $LANG TEXT NOT NULL)''');
  }

  static Future<int> saveWord(PreviousWordsModel model) async {
    var dbClient = await _db;

    List<Map<String, dynamic>> existingWords = await dbClient!.query(TABLE,
        where: 'word = ? AND lang = ?', whereArgs: [model.word, model.lang]);

    PreviousWordsModel temp = PreviousWordsModel(
      word: model.word,
      lang: model.lang,
      searched_at: DateTime.now().toString(),
    );

    if (existingWords.isNotEmpty) {
      return await dbClient.update(TABLE, temp.toJson(),
          where: 'word = ?', whereArgs: [model.word]);
    } else {
      return await dbClient.insert(TABLE, temp.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  static Future<List<PreviousWordsModel>> getSavedWords() async {
    var dbClient = await _db;
    List<Map<String, dynamic>> map =
        await dbClient!.query(TABLE, orderBy: '$SEARCHED_AT DESC');
    return map.map((e) => PreviousWordsModel.fromJson(e)).toList();
  }

  static Future<int> deleteSavedWord(String word) async {
    var dbClient = await _db;
    return dbClient!.delete(TABLE, where: '$WORD = ?', whereArgs: [word]);
  }

  static Future<int> deleteAllSavedWords() async {
    var dbClient = await _db;
    return dbClient!.delete(TABLE);
  }
}
