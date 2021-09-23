import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  Widget build(BuildContext context)  {

    elimina(a, b) async {
      var database;
      var databasesPath = await getDatabasesPath();

      String path = join(databasesPath, '$b.db');

      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
                'CREATE TABLE $a (id INTEGER PRIMARY KEY AUTOINCREMENT, id_catgoria TEXT, valore INTEGER,descrizione TEXT, data TEXT,siRipete BOOL, giorni INTEGER, mesi INTEGER, anni INTEGER)'
            );
          }
      );
      var risultato = await database.rawQuery('DELETE FROM $a');
    }


    printaa(a, b) async {
      var database;
      var databasesPath = await getDatabasesPath();

      String path = join(databasesPath, '$b.db');

      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
                'CREATE TABLE $a (id INTEGER PRIMARY KEY AUTOINCREMENT, id_catgoria TEXT, valore INTEGER,descrizione TEXT, data TEXT,siRipete BOOL, giorni INTEGER, mesi INTEGER, anni INTEGER)'
            );
          }
      );
      var risultato = await database.rawQuery('SELECT * FROM $a');
      for (var ris in risultato) {
        print(ris);
      }
    }


    printa1(a, b) async {
      var database;
      var databasesPath = await getDatabasesPath();

      String path = join(databasesPath, '$b.db');

      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
                'CREATE TABLE $a (id INTEGER PRIMARY KEY AUTOINCREMENT, id_catgoria TEXT, valore INTEGER,descrizione TEXT, data TEXT,siRipete BOOL, giorni INTEGER, mesi INTEGER, anni INTEGER)'
            );
          }
      );
      List risultato = await database.rawQuery('SELECT * FROM $a WHERE id = 22');
      print(risultato[0]);
    }

    test(a, b) async {
      var database;
      var databasesPath = await getDatabasesPath();

      String path = join(databasesPath, '$b.db');

      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
                'CREATE TABLE $a (id INTEGER PRIMARY KEY AUTOINCREMENT, id_catgoria TEXT, valore INTEGER,descrizione TEXT, data TEXT,siRipete BOOL, giorni INTEGER, mesi INTEGER, anni INTEGER)'
            );
          }
      );
      List risultato = await database.rawQuery('SELECT * FROM $a WHERE id = 22');
      print(DateTime.parse(risultato[0]['data']));
    }

    eliminaTable(a, b) async {
      var database;
      var databasesPath = await getDatabasesPath();

      String path = join(databasesPath, '$b.db');

      database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
            // When creating the db, create the table
            await db.execute(
                'CREATE TABLE $a (id INTEGER PRIMARY KEY AUTOINCREMENT, id_catgoria TEXT, valore INTEGER,descrizione TEXT, data TEXT,siRipete BOOL, giorni INTEGER, mesi INTEGER, anni INTEGER)'
            );
          }
      );
      database.rawQuery('DROP TABLE $a');
    }

    DateTime data = DateTime.now();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text('database test'),
            IconButton(
              onPressed: () {
                printaa('dati', 'database');
              },
              icon: Icon(Icons.account_tree)),
            IconButton(
                onPressed: () {
                  printa1('dati', 'database');
                },
                icon: Icon(Icons.ac_unit_rounded)),
            IconButton(
              onPressed: () {
                elimina('dati', 'database');
              },
              icon: Icon(Icons.delete)),
            IconButton(
              onPressed: () {
                test('dati', 'database');
              },
              icon: Icon(Icons.info)),
            IconButton(
              onPressed: () {
                eliminaTable('dati', 'database');
              },
              icon: Icon(Icons.delete, color: Colors.red)),

            Text('database transazioni'),
            IconButton(
              onPressed: () {
                printaa('transazioni', 'database');
              },
              icon: Icon(Icons.account_tree)),
            IconButton(
                onPressed: () {
                  printa1('transazioni', 'database');
                },
                icon: Icon(Icons.ac_unit_rounded)),
            IconButton(
              onPressed: () {
                elimina('transazioni', 'database');
              },
              icon: Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  eliminaTable('transazioni', 'database');
                },
                icon: Icon(Icons.delete, color: Colors.red)),

            Text('database categorie'),
            IconButton(
              onPressed: () {
                printaa('categorie', 'database');
              },
              icon: Icon(Icons.account_tree)),
            IconButton(
                onPressed: () {
                  printa1('categorie', 'database');
                },
                icon: Icon(Icons.ac_unit_rounded)),
            IconButton(
              onPressed: () {
                elimina('categorie', 'database');
              },
              icon: Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  eliminaTable('categorie', 'database');
                },
                icon: Icon(Icons.delete, color: Colors.red)),

          ],
        ),
      ),
    );
  }
}
