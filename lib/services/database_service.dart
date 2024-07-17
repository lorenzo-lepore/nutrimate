import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _nutrimateTableName = 'products';
  final String _nutrimateIdColumnName = 'id';
  final String _nutrimateBarcodeColumnName = 'barcode';
  final String _nutrimateNameColumnName = 'name';
  final String _nutrimateQuantityColumnName = 'quantity';
  final String _nutrimateStatusColumnName = 'status';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = '$databaseDirPath/nutrimate.db';
    final database = await openDatabase(
      databasePath,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_nutrimateTableName (
            $_nutrimateIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
            $_nutrimateNameColumnName TEXT NOT NULL,
            $_nutrimateQuantityColumnName TEXT NOT NULL,
            $_nutrimateStatusColumnName TEXT NOT NULL
            $_nutrimateBarcodeColumnName TEXT,
          )
        ''');
      },
    );
    return database;
  }
}
