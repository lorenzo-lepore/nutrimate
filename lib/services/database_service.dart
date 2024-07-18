import 'package:nutrimate/models/shopping_list_element.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _nutrimateTableName = 'items';
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

  void addItem(ListElement element) async {
    final db = await database;
    await db.insert(_nutrimateTableName, {
      _nutrimateNameColumnName: element.title,
      _nutrimateQuantityColumnName: element.quantity.toString(),
      _nutrimateStatusColumnName: element.status ? '1' : '0',
      _nutrimateBarcodeColumnName: element.barcode,
    });
  }
}
