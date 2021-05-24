import 'package:mobile_cw2/model/user.dart';
import 'dart:async';
import 'package:mobile_cw2/data/database_helper.dart';

class LoginCtr {
  DatabaseHelper con = DatabaseHelper.instance;
//insertion
  Future<int> saveUser(User user) async {
    var dbClient = await con.database;
    int res = await dbClient.insert(DatabaseHelper.tableStaff, user.toMap());
    return res;
  }
  //deletion
  Future<int> deleteUser(User user) async {
    var dbClient = await con.database;
    int res = await dbClient.delete("User");
    return res;
  }
  Future<User> getLogin(String user, String password) async {
    var dbClient = await con.database;
    var res = await dbClient.rawQuery
      ("SELECT * FROM "+DatabaseHelper.tableStaff+" WHERE "+
        DatabaseHelper.columnStaffUsername+" = '$user' and "+
        DatabaseHelper.columnStaffPassword+" = '$password'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }
    return null;
  }
  Future<List<User>> getAllUser() async {
    var dbClient = await con.database;
    var res = await dbClient.query(DatabaseHelper.tableStaff);

    List<User> list =
    res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;
    return list;
  }
}