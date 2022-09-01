import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '/models/task.dart';

class DBHelper {
  static Database _db;
  static final int _version = 1;
  static final String _tableName = 'task';

//we define async bec it takes some time
//initialize a databas
  static Future<void> initDb() async {
    //if we already have a data base dont do it
    if (_db != null) {
      debugPrint('not null db');
      return;
    } 
      try {
        String _path = await getDatabasesPath() + 'task.db';
        debugPrint('in database path');
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          debugPrint('create new db');
          // When creating the db, create the table
          await db.execute(
            //sql lang
            //to make id uniqe so we cant play with it just put auto increment
            'CREATE TABLE $_tableName ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT, '
            'title STRING, note TEXT, date STRING, '
            'startTime STRING, endTime STRING, '
            'remind INTEGER, repeat STRING, '
            'color INTEGER, '
            'isCompleted INTEGER)',
          );
        });
      } catch (e) {
        print(e);
      
    }
  }

   static Future<int> insert(Task task) async {
     print(';insert function');
    return await _db.insert(_tableName, task.toJson());
   }

    static Future<int> delete(Task task) async {
     print(';delete function');
    return await _db.delete(_tableName, where: 'id = ?',whereArgs: [task.id]);
   }

   static Future<int> deleteAll() async {
     print(';delete all function');
    return await _db.delete(_tableName);
   }

   static Future<List<Map<String, dynamic>>> query() async {
     print(';query function');
    return await _db.query(_tableName);
   }

    static Future<int> update(int id) async {
     print('Update function');
    return await _db.rawUpdate('UPDATE task SET isCompleted = ? WHERE id = ?', [1,id]);
   }

}
