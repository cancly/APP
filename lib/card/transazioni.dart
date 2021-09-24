import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/widget/transazioni.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class CardTransazioni extends StatefulWidget {
  const CardTransazioni({required this.titolo, required this.isPassato});

  final titolo;
  final isPassato;

  @override
  State<CardTransazioni> createState() => _CardTransazioniState();
}

class _CardTransazioniState extends State<CardTransazioni> {
  @override
  Widget build(BuildContext context) {
    var max = 3;



    getTransazione(data) {
      {
        if (widget.isPassato) {
          return data.isBefore(DateTime.now());
        } else {
          return data.isAfter(DateTime.now());
        }
      }
    }

    contaTransazioni() async {
      var totale = 0;
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'database.db');

      Database database = await openDatabase(path, version: 1);
      var dati = await database.rawQuery('SELECT * FROM transazioni');
      for (var i in dati) {
        if (getTransazione(DateTime.parse(i['data'].toString()))) {
          totale++;
        }
      }
      return totale;
    }

    printTransazioni (max) async {
      var lista = <Widget>[];

      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'database.db');

      Database database = await openDatabase(path, version: 1);
      var dati = await database.rawQuery('SELECT * FROM transazioni');
      var dati1 = new List.from(dati);

      widget.isPassato? dati1.sort((a, b) => DateTime.parse('${b['data']}').compareTo(DateTime.parse('${a['data']}'))) : dati1.sort((a, b) => DateTime.parse('${a['data']}').compareTo(DateTime.parse('${b['data']}')));
      var a = 0;
      for (var i in dati1) {
        if (getTransazione(DateTime.parse('${i['data']}'))) {
          lista.add(Transazione(dati: i));
          a++;
          if (a == max && a != 0) {
            break;
          }
        }
      }
      return lista;
    }

    getLista(max) async {
      var lista = await printTransazioni(max);
      var num = await contaTransazioni();
      lista.add(Text('$num'));
      return lista;
    }

    return OpenContainer(
        closedBuilder: (_, openContainer) {
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              color: Colors.grey[900],
              child: Container(
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                  child: FutureBuilder(
                      future: getLista(max),
                      builder: (BuildContext, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.titolo, style: const TextStyle(color: Colors.white, fontSize: 20)),
                              const SizedBox(height: 5),
                              for (var i in snapshot.data) if(snapshot.data.last != i) i,
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if(int.parse(snapshot.data.last.data) > 3) TextButton(
                                    child: Row(
                                      children: const [
                                        Icon(Icons.more_horiz, color: Colors.white),
                                        Text(' visualizza tutte', style: TextStyle(color: Colors.white))
                                      ],
                                    ),
                                    onPressed: openContainer,
                                  )
                                ]
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      }
                  )
              )
          );
        },
        closedColor: Colors.black,
        openBuilder: (_, closeContainer) {
          return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.black,
                title: Text(widget.titolo, style: const TextStyle(color: Colors.white, fontSize: 20)) //TODO: titolo
              ),
              body: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  color: Colors.grey[900],
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: FutureBuilder(
                        future: getLista(0),
                        builder: (BuildContext, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [for (var i in snapshot.data) if (i != snapshot.data.last)i]
                            );
                          } else {
                            return SizedBox();
                          }
                        }
                      )
                    )
                  )
              )
          );
        }
    );
  }
}
