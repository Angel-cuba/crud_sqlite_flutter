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
  static const String tableName = 'employees';

  //init database
  initializeDatabase() async {
    // Get path where database is stored
    Directory directory = await getApplicationDocumentsDirectory();
    // path to database
    String path = '${directory.path}employees.db';
    // open database
    _database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      return db.execute('''
        CREATE TABLE $tableName(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          designation TEXT NOT NULL,
          isMale BOOLEAN
        )
      ''');
    });
  }

  //? CRUD operations
  //! Read
  Future<List<Map<String, dynamic>>> getEmployees() async {
    return await _database.query(tableName, orderBy: 'name');
  }

  //! Insert5
  Future<int> insertEmployee(Employee employee) async {
    int result = await _database.insert(tableName, employee.toMap());
    return result;
  }

  //! Update
  Future<int> updateEmployee(Employee employee) async {
    int result = await _database.update(tableName, employee.toMap(),
        where: 'id = ?', whereArgs: [employee.id]);
    return result;
  }

  //! Delete
  Future<int> deleteEmployee(int id) async {
    int result =
        await _database.delete(tableName, where: 'id = ?', whereArgs: [id]);
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
