import 'package:flutter_dictionary/models/previous_words_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

class WordsRepositoryService {
  static const String TABLE = 'previous_words';
  static const String DB_NAME = 'dictionary.db';
  static const String ID = 'id';
  static const String WORD = 'word';
  static const String LANG = 'lang';
  static const String CREATED_AT = 'created_at';

  static final Uuid uuid = Uuid();

  static Future<Database?> get _db async => await initDB();

  static Future<Database?> initDB() async {
    final directory = await getDatabasesPath();
    final path = join(directory, DB_NAME);
    return openDatabase(path, version: 1, onCreate: createDatabase);
  }

  static createDatabase(Database db, int version) async {
    await db.execute('''CREATE TABLE $TABLE(
      $ID TEXT PRIMARY KEY,
      $WORD TEXT NOT NULL,
      $CREATED_AT TEXT NOT NULL,
      $LANG TEXT NOT NULL)''');
  }

  static Future<int> saveWord(PreviousWordsModel model) async {
    var dbClient = await _db;
    PreviousWordsModel temp = PreviousWordsModel(
      id: uuid.v4(),
      word: model.word,
      lang: model.lang,
      created_at: DateTime.now().toString(),
    );
    return await dbClient!.insert(TABLE, temp.toJson());
  }

  static Future<List<PreviousWordsModel>> getSavedWords() async {
    var dbClient = await _db;
    List<Map<String, dynamic>> map =
        await dbClient!.query(TABLE, orderBy: '$CREATED_AT DESC');
    return map.map((e) => PreviousWordsModel.fromJson(e)).toList();
  }

  static Future<int> deleteSavedWord(String id) async {
    var dbClient = await _db;
    return dbClient!.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  static Future<int> deleteAllSavedWords() async {
    var dbClient = await _db;
    return dbClient!.delete(TABLE);
  }
}
