import 'package:flutter_dictionary/words.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WordsDatabase {
  static final WordsDatabase instance = WordsDatabase._init();

  static Database? _database;

  WordsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('words.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final wordType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableWords(
      ${WordFields.id} $idType,
      ${WordFields.word} $wordType
    )
    ''');
  }

  Future<Word> create(Word word) async {
    final db = await instance.database;

    final id = await db.insert(tableWords, word.toJson());
    return word.copy(id: id);
  }

  Future<List<Word>> readAllWords() async {
    final db = await instance.database;

    final orderBy = '${WordFields.id} DESC';

    final result = await db.query(tableWords, orderBy: orderBy);

    return result.map((json) => Word.fromJson(json)).toList();
  }

  /* <---- NOT NEEDED IN THIS APP ---->
  Future<Word?> readWord(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableWords,
      columns: WordFields.values,
      where: '${WordFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Word.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }
  <---- x ----> */

  Future<int> delete(int? id) async {
    final db = await instance.database;

    return await db.delete(
      tableWords,
      where: '${WordFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future deleteAll() async {
    final db = await instance.database;

    return db.delete(tableWords);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
