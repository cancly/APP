import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


creaDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'demo.db');


  database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY AUTOINCREMENT, id_catgoria TEXT, valore INTEGER, data TEXT,siRipete BOOL, giorni INTEGER, mesi INTEGER, anni INTEGER)'
      );
    });
}

  insert({required String descrizione, required int valore, required DateTime data, required Text simbolo}) async {
    String strData = data.toString();
    await database.transaction((txn) async {
      int result = await txn.rawInsert(
          "INSERT INTO Test(id, descrizione, valore, data, simbolo) VALUES($id, '$descrizione', $valore, '$strData', '$simbolo')");
      id += 1;
      return ('inserted1: $result');
  });
}

update({required String query}) async {
  int count = await database.rawUpdate(query);
  return 'modificate $count righe';
}

select(String where) async {
  if (where == '') {
    List<Map> list = await database.rawQuery('SELECT * FROM Test');
    return list;
  } else {
    List<Map> list = await database.rawQuery('SELECT * FROM Test WHERE $where');
    return list;
  }
}

count(String where) async {
  if (where == '') {
    int? count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM Test'));
    return count;
  } else {
    int? count = Sqflite.firstIntValue(
        await database.rawQuery('SELECT COUNT(*) FROM Test WHERE $where'));
    return count;
  }
}
