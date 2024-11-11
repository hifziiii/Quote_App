import 'package:login_signup/model/UserModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users('
              'id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'firstName TEXT IS DEFAULT   ,'
              ' lastName TEXT IS DEFAULT    , '
              'email TEXT EMAIL IS UNIQUE   ,'
              ' password TEXT IS DEFAULT   '

              ')',
        );
      },
    );
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert('users', user.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (result.isNotEmpty) {
      return User(
        id: result.first['id'],
        firstName: result.first['firstName'],
        lastName: result.first['lastName'],
        email: result.first['email'],
        password: result.first['password'],
      );
    }
    return null;
  }
}
