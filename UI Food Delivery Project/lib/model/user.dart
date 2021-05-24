import 'package:mobile_cw2/data/database_helper.dart';

class User {
  int _id;
  String _name;
  String _role;
  String _status;
  String _username;
  String _password;

  String get name => _name;
  String get role => _role;
  String get status => _status;
  String get username => _username;
  String get password => _password;

  User(this._name,this._role,this._status,this._username, this._password);
  User.fromMap(dynamic obj) {
    this._id = obj[DatabaseHelper.columnStaffId];
    this._name = obj[DatabaseHelper.columnStaffName];
    this._role = obj[DatabaseHelper.columnStaffRole];
    this._status = obj[DatabaseHelper.columnStaffStatus];
    this._username = obj[DatabaseHelper.columnStaffUsername];
    this._password = obj[DatabaseHelper.columnStaffPassword];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map[DatabaseHelper.columnStaffId] = _id;
    map[DatabaseHelper.columnStaffName] = _name;
    map[DatabaseHelper.columnStaffRole] = _role;
    map[DatabaseHelper.columnStaffStatus] = _status;
    map[DatabaseHelper.columnStaffUsername] = _username;
    map[DatabaseHelper.columnStaffPassword] = _password;
    return map;
  }
}
//https://medium.com/@ekosuprastyo15/flutter-login-with-database-sqlite-50a808633be0