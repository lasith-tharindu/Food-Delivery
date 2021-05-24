import 'dart:io';
import 'package:mobile_cw2/controller/login_ctr.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mobile_cw2/model/user.dart';

class DatabaseHelper {
  static final _databaseName = "Horizon.db";
  static final _databaseVersion = 1;//4

  static const tableStaff = 'staff';
  static const columnStaffId = tableStaff+'_id';
  static const columnStaffName = tableStaff+'_name';
  static const columnStaffRole = tableStaff+'_role';
  static const columnStaffStatus = tableStaff+'_status';
  static const columnStaffUsername = tableStaff+'_username';
  static const columnStaffPassword = tableStaff+'_password';

  static const tableProject = 'project';
  static const columnProjectId = tableProject+'_id';
  static const columnProjectStartDate = tableProject+'_startdate';
  static const columnProjectEndDate= tableProject+'_enddate';
  static const columnProjectCost = tableProject+'_cost';
  static const columnProjectClient = tableProject+'_client';
  static const columnProjectStatus = tableProject+'_status';
  static const columnProjectStatusReason = tableProject+'_status_reason';

  static const tableTask = 'task';
  static const columnTaskId = tableTask+'_id';
  static const columnTaskName = tableTask+'_name';
  static const columnTaskStatus= tableTask+'_status';
  //project_project_id
  static const columnForeignProjectID= tableProject+'_'+columnProjectId;
  static const columnForeignTaskID= tableTask+'_'+columnTaskId;
  static const columnForeignStaffID= tableStaff+'_'+columnStaffId;

  static const tableStaffInTask = 'staff_in_task';
  static const tableStaffInProject = 'staff_in_project';

  static const columnRole = 'role';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // only have a single app-wide reference to the database
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }
  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }
  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    print('Upgrading database');
    await db.rawDelete('DROP TABLE IF EXISTS '+tableStaff);
    await db.rawDelete('DROP TABLE IF EXISTS '+tableStaffInTask);
    await db.rawDelete('DROP TABLE IF EXISTS '+tableStaffInProject);
    await db.rawDelete('DROP TABLE IF EXISTS '+tableTask);
    await db.rawDelete('DROP TABLE IF EXISTS '+tableProject);
    await db.execute('''
          CREATE TABLE $tableStaff (
            $columnStaffId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnStaffName TEXT NOT NULL,
            $columnStaffRole TEXT NOT NULL,
            $columnStaffStatus TEXT NOT NULL,
            $columnStaffUsername TEXT NOT NULL,
            $columnStaffPassword TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableProject (
            $columnProjectId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnProjectStartDate DATE NOT NULL,
            $columnProjectEndDate DATE NOT NULL,
            $columnProjectCost INT NOT NULL,
            $columnProjectStatus TEXT NOT NULL,
            $columnProjectStatusReason TEXT NOT NULL,
            $columnProjectClient TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableTask (
            $columnTaskId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTaskName TEXT NOT NULL,
            $columnTaskStatus TEXT NOT NULL,
            $columnForeignProjectID INT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableStaffInTask (
            $columnForeignStaffID INTEGER ,
            $columnForeignTaskID INTEGER ,
            PRIMARY KEY ( $columnForeignStaffID, $columnForeignTaskID)
          )
          ''');

    await db.execute('''
          CREATE TABLE $tableStaffInProject (
            $columnForeignStaffID INTEGER,
            $columnForeignProjectID INTEGER,
            $columnRole TEXT NOT NULL,
            PRIMARY KEY ( $columnForeignStaffID, $columnForeignProjectID)
          )
          ''');
    print('Database created');
    await LoginCtr().saveUser(User('Ajith', 'admin', 'Active','admin', '123'));
    await LoginCtr().saveUser(User('Lasitha', 'employee', 'Active', 'lasitha', '123'));
    await LoginCtr().saveUser(User('Sanuda', 'employee', 'Active', 'sanuda', '123'));
    print('Test Data inserted');

  }
  // Helper methods
  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> staffInsert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableStaff, row);
  }

  Future<int> updateDatabase() async {
    Database db = await instance.database;
    _onCreate(db, _databaseVersion);
  }
  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> StaffQueryAllRows() async {
    Database db = await instance.database;
    return await db.query(tableStaff);
  }
  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> StaffQueryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableStaff'));
  }


  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> StaffUpdate(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnStaffId];
    return await db.update(tableStaff, row, where: '$columnStaffId = ?', whereArgs: [id]);
  }


  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> StaffDelete(int id) async {
    Database db = await instance.database;
    return await db.delete(tableStaff, where: '$columnStaffId = ?', whereArgs: [id]);
  }
}