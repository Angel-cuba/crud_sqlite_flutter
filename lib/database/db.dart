import 'dart:io';
import 'package:crud_sqlite/crud/employee.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbConnection {
  static final DbConnection _dbConnection = DbConnection._privateConstructor();

  //!private constructor
  DbConnection._privateConstructor();

  //!static instance
  static late Database _database;
  factory DbConnection() {
    return _dbConnection;
  }

  //? variables
  final String tableName = 'employee.db';
  final String columnId = 'employeeId';
  final String columnName = 'name';
  final String columnEmail = 'email';
  final String columnDesignation = 'designation';
  final String columnIsMale = 'isMale';

  //init database
  initializeDatabase() async {
    // Get path where database is stored
    Directory directory = await getApplicationDocumentsDirectory();
    // path to database
    String path = '${directory.path}$tableName';
    // open database
    _database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $tableName(
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
          $columnName TEXT NOT NULL,
          $columnEmail TEXT NOT NULL,
          $columnDesignation TEXT NOT NULL,
          $columnIsMale BOOLEAN NOT NULL
        )
      ''');
    });
  }

  //? CRUD operations
  //! Read
  Future<List<Map<String, Object?>>> getEmployees() async {
    List<Map<String, Object?>> result =
        await _database.query(tableName, orderBy: columnName);
    return result;
  }

  //! Insert
  Future<int> insertEmployee(Employee employee) async {
    int result = await _database.insert(tableName, employee.toMap());
    return result;
  }

  //! Update
  Future<int> updateEmployee(Employee employee) async {
    int result = await _database.update(tableName, employee.toMap(),
        where: '$columnId = ?', whereArgs: [employee.id]);
    return result;
  }

  //! Delete
  Future<int> deleteEmployee(int id) async {
    int result = await _database
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
    return result;
  }

  //! Count number of employees
  Future<int> countEmployees() async {
    List<Map<String, Object?>> result =
        await _database.rawQuery('SELECT COUNT(*) FROM $tableName');
    int count = Sqflite.firstIntValue(result) ?? 0;
    return count;
  }
}
