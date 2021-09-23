import 'package:fl_chart/fl_chart.dart';
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

    await database.transaction((txn) async {
      int result = await txn.rawInsert("INSERT INTO transazioni(id_catgoria, valore, descrizione, data) VALUES(${tipo[0]['id_catgoria']}, '${tipo[0]['valore']}', '${tipo[0]['descrizione']}','${tipo[0]['data']}' )");
      return ('inserted1: $result');
    });

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



GeneraSpot(range) async {
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


  switch (range) {
    case 0:
      return await generaPunti(7);
    case 1:
      return await generaPunti(31);
    case 2:
      return await generaPunti(365);
    case 3:
      return await generaPunti(7); //FIXME: OCIO
  }
}

generaPunti(int numero) async {
  var lista = [];
  var punti = <FlSpot>[];
  var oggi = DateTime.now();
  var data = DateTime(oggi.year, oggi.month, oggi.day - numero);
  var fine = DateTime(oggi.year, oggi.month, oggi.day + numero);

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'database.db');
  var database = await openDatabase(path, version: 1);

  var tipo = await database.rawQuery('SELECT * FROM transazioni');
  var dati1 = new List.from(tipo);
  var importoSommato = 0.0;

  for (var dati in dati1) {
    if (DateTime.parse(dati['data'].toString()).isBefore(data)) {

      importoSommato += dati['valore'];
    }
  }
  punti.add(FlSpot(0,importoSommato));

  var tipoo = await database.rawQuery('SELECT * FROM transazioni');
  dati1 = new List.from(tipoo);

  for (var dati in dati1) {
    if ((DateTime.parse(dati['data'].toString()).isAfter(data)) && (DateTime.parse((dati['data'].toString())).isBefore(DateTime.now().add(Duration(days: 7))))) {
      lista.add(dati);
    }
  }

  lista.sort((a, b) => DateTime.parse('${a['data']}').compareTo(DateTime.parse('${b['data']}')));

  var x = 0;
  var millisecondiFine = fine.millisecondsSinceEpoch - data.millisecondsSinceEpoch;

  for (var e in lista) {
    punti.add(FlSpot((numero * 2 * (DateTime.parse(e['data'].toString()).millisecondsSinceEpoch - data.millisecondsSinceEpoch)) / millisecondiFine , importoSommato));

    importoSommato += e['valore'];
    punti.add(FlSpot((numero * 2 * (DateTime.parse(e['data'].toString()).millisecondsSinceEpoch - data.millisecondsSinceEpoch)) / millisecondiFine , importoSommato));
  }
  punti.add(FlSpot(numero * 2, importoSommato));
  return punti;
}

connData() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'database.db');
  Database database;
  database = await openDatabase(path, version: 1);
  List<Map> list = await database.rawQuery('SELECT * FROM transazioni');
  return list;
}

getSaldo(tipo) async {
  var list = await connData();
  var saldo = 0.00;

  switch (tipo) {
    case 'T':
      if (list.length != 0){
        for (var transazione in list) {
          if (DateTime.parse(transazione['data']).isBefore(DateTime.now())) {
            saldo += transazione['valore'];
          }
        }
      }

      return saldo;

    case 'G':
      if (list.length != 0) {
        for (var transazione in list) {
          if ((DateTime.parse(transazione['data']).isBefore(DateTime.now())) &&
              (transazione['valore'] > 0.00)) {
            saldo += transazione['valore'];
          }
        }
      }
      return saldo;
    case 'S':
      if (list.length != 0) {
        for (var transazione in list) {
          if ((DateTime.parse(transazione['data']).isBefore(DateTime.now())) &&
              (transazione['valore'] < 0.00)) {
            saldo += transazione['valore'];
          }
        }
      }
      return (saldo * -1);
  }
}

calcolaDelta(range, tipo) async {

  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'database.db');
  Database database;
  database = await openDatabase(path, version: 1);
  var totaleVecchio;
  switch (tipo) {

    case 'T':
      List<Map> list = await database.rawQuery('SELECT * FROM transazioni');
      var list1 = new List.from(list);

      switch (range) {
        case 0:
          for (var e in list1) {
            if (DateTime.parse(e['data'].toString()).isBefore(DateTime.now().add(Duration(days: -7)))) {
              totaleVecchio += e['valore'];
            }
          }
          var totaleAttuale = await getSaldo('T');
          var delta = totaleAttuale - totaleVecchio;
          var deltaPercentuale = delta/totaleVecchio * 100;
          return [delta, deltaPercentuale];
        case 1:
          for (var e in list1) {
            if (DateTime.parse(e['data'].toString()).isBefore(DateTime.utc(DateTime.now().year, DateTime.now().month - 1, DateTime.now().day))) {
              totaleVecchio += e['valore'];
            }
          }
          var totaleAttuale = await getSaldo('T');
          var delta = totaleAttuale - totaleVecchio;
          var deltaPercentuale = delta/totaleVecchio * 100;
          return [delta, deltaPercentuale];
        case 2:
          break;
        case 3:
          break;
      }
      break;

    case 'S':
      List<Map> list = await database.rawQuery('SELECT * FROM transazioni WHERE valore < 0');
      break;
      //TODO:
    case 'G':
      List<Map> list = await database.rawQuery('SELECT * FROM transazioni WHERE valore > 0');
      break;
      //TODO:
  }
}

dataToString(data) => DateFormat.E().format(data);