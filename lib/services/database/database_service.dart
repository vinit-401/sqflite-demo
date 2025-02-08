import 'package:demo_sqlite/services/database/db_helper.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService dbInstance = DatabaseService._();
  static Database? _database;

  DatabaseService._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;

  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, DBHelper.databaseName);
    return openDatabase(
      path,
      version: DBHelper.databaseVersion,
      onCreate: (db, version) {
        db.execute(DBHelper.createTableQuery);
      },
    );
  }
}
