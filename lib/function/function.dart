import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:portfolio/constants/const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

verificaTipo(id) async {


  var database;

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'database.db');

  database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE dati (id INTEGER PRIMARY KEY AUTOINCREMENT, id_catgoria TEXT, valore INTEGER,descrizione TEXT, data TEXT,siRipete BOOL, giorni INTEGER, mesi INTEGER, anni INTEGER)'
        );
      }
  );

  var tipo = await database.rawQuery('SELECT * FROM dati WHERE id = $id');




  if (tipo[0]['siRipete'] == 0) {
     //aggiungere alla lista se unico
     // var transazione = {
     //   'categoria': tipo['categoria'],
     //   'valore': tipo['valore'],
     //   'data': tipo['data'],
     //   'descrizione': tipo['descrizione']
     // };
     //   transazioni.add(transazione);
  } else {
     //aggiungere alla lista se multiplo

    DateTime data = DateTime.parse(tipo[0]['data']);
    while (data.isBefore(dataLimite)) {
            // var transazione = {
            //   'categoria': tipo['categoria'],
            //   'valore': tipo['valore'],
            //   'data': data,
            //   'descrizione': tipo['descrizione']
            // };
            // transazioni.add(transazione);
      //TODO: inserire nel database transazioni




      await database.transaction((txn) async {
        int result = await txn.rawInsert("INSERT INTO transazioni(id_catgoria, valore, descrizione, data) VALUES(${tipo[0]['id_catgoria']}, '${tipo[0]['valore']}', '${tipo[0]['descrizione']}','${data.toString()}' )");
        return ('inserted1: $result');
      });




      int anni = tipo[0]['anni'].toInt();
      int mesi = tipo[0]['mesi'].toInt();
      int giorni = tipo[0]['giorni'].toInt();

      data = DateTime.utc((data.year + anni), (data.month + mesi), (data.day + giorni));
    }
  }
}



GeneraSpot(range) {
  /// prende data e valore transazioni
  ///
  /// data minore = 0
  ///
  /// return FlSpot(x,y)
  ///
  /// range = _selection
  ///   0 settimana
  ///   1 mese
  ///   2 anno
  ///   3 totale
  var lista = [];

  switch (range) {
    case 0:
      /// var punti = []
      /// oggi = DateTime.now()
      /// data = DateTime(oggi.year, oggi.month, oggi.day - 7)
      /// sql2 = 'sum() importo where data < data'
      /// importoSommato = la somma sopra
      /// punti.add(FlSpot(0,importo sommato))
      /// sql = 'select order by data where settimanaPassataEFutura'
      /// salvo in lista
      ///
      /// x = 0
      /// datiAlGiorno = (lista.count/14).ceil()
      ///
      /// while(data.isBefore(DateTime(oggi.year, oggi.month, oggi.day + 7))) {
      ///   if ((lista[0]['data'].year == data.year) && (lista[0]['data'].month == data.month) && (lista[0]['data'].day == data.day)) {
      ///     datiGiorno += 1
      ///     x++
      ///     importoSommato += lista[0]['valore']
      ///     punti.add(FlSpot(x, importoSommato))
      ///     lista.removeAt(0)
      ///   } else if (datiGiorno < DatiAlGiorno) {
      ///     datiGiorno +=1
      ///     x++
      ///     punti.add(FlSpot(x, importoSommato))
      ///   } else {
      ///     datiGiorno = 0
      ///     data = data(data.year, data.month, data.day +1)
      ///   }
      /// }
      /// return punti

      break;
    case 1:

      break;
    case 2:

      break;
    case 3:

      break;
  }



}

dataToString(data) => DateFormat.E().format(data);