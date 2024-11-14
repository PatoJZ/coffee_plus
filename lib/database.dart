import 'package:coffee_plus/reciepe.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'recipes.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE recipes (
            id INTEGER PRIMARY KEY,
            name TEXT,
            ingredients TEXT,
            steps TEXT,
            imagePath TEXT,
            isAssetImage INTEGER,
            dateCreated TEXT
          )
          ''',
        );
      },
    );
  }

  Future<List<Reciepe>> getAllRecipes() async {
    final db = await database;
    final recipes = await db.query('recipes', orderBy: "dateCreated DESC");
    return recipes.map((r) => Reciepe.fromMap(r)).toList();
  }

  Future<int> insertRecipe(Reciepe recipe) async {
    final db = await database;
    return await db.insert('recipes', recipe.toMap());
  }

  Future<int> updateRecipe(Reciepe recipe) async {
    final db = await database;
    return await db.update('recipes', recipe.toMap(), where: "id = ?", whereArgs: [recipe.id]);
  }

  Future<int> deleteRecipe(int id) async {
    final db = await database;
    return await db.delete('recipes', where: "id = ?", whereArgs: [id]);
  }
}