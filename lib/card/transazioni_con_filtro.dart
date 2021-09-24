import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/widget/transazioni.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CardTransazioni extends StatefulWidget {
  const CardTransazioni({required this.titolo, required this.isPassato, required this.tipo});

  final titolo;
  final isPassato;
  final tipo;

  @override
  State<CardTransazioni> createState() => _CardTransazioniState();
}

class _CardTransazioniState extends State<CardTransazioni> {
  var decrescente = true;
  var max = 3;
  var _selection = 0;
  var filtri= [
    Text('data'),
    Text('importo'),
    Text('categoria')
  ];

  @override
  Widget build(BuildContext context) {

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

      if (widget.tipo == 'costi') {
        var transazioni = await database.rawQuery('SELECT * FROM transazioni WHERE valore < 0');
        for (var i in transazioni) {
          totale++;
        }
      } else {
        var transazioni = await database.rawQuery('SELECT * FROM transazioni WHERE valore > 0');
        for (var i in transazioni) {
          totale++;
        }
      }

      return totale;
    }


    printTransazioni(max) async {
      ///max = 0 è infinito
      var lista = <Widget>[];
      var a = 0;
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'database.db');

      Database database = await openDatabase(path, version: 1);



          if (widget.tipo == 'costi') {
            var dati;
            switch (_selection) {
              case 1:
                if (!decrescente) {
                  dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore < 0 ORDER BY transazioni.valore DESC');
                } else {
                  dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore < 0 ORDER BY transazioni.valore ASC');
                }
                break;
              case 0:
                dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore < 0');
                break;
              case 2:
                if (!decrescente) {
                  dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore < 0 ORDER BY transazioni.id_catgoria DESC');
                } else {
                  dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore < 0 ORDER BY transazioni.id_catgoria ASC');
                }
                break;
            }

            var dati1 = new List.from(dati);

            if (_selection == 0) {
              //importo
              if (decrescente) {
                dati1.sort((a, b) =>
                    DateTime.parse('${b['data']}').compareTo(
                        DateTime.parse('${a['data']}')));
              } else {
                dati1.sort((a, b) =>
                    DateTime.parse('${a['data']}').compareTo(
                        DateTime.parse('${b['data']}')));
              }
            }
            print(dati1);
            for (var i in dati1) {
              if (getTransazione(DateTime.parse(i['data'].toString()))) {
                lista.add(Transazione(dati: i));
                a++;
                if (a == max && max != 0) {
                  break;
                }
              }
            }


          } else {
            var dati;
            switch (_selection) {
              case 1:
                if (!decrescente) {
                  dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore > 0 ORDER BY transazioni.valore DESC');
                } else {
                  dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore > 0 ORDER BY transazioni.valore ASC');
                }
                break;
              case 0:
                dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore > 0');
                break;
              case 2:
                if (!decrescente) {
                  dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore > 0 ORDER BY transazioni.id_catgoria DESC');
                } else {
                  dati = await database.rawQuery('SELECT * FROM transazioni WHERE valore > 0 ORDER BY transazioni.id_catgoria ASC');
                }
                break;
            }

            var dati1 = new List.from(dati);

            if (_selection == 0) {
              //importo
              if (decrescente) {
                dati1.sort((a, b) =>
                    DateTime.parse('${b['data']}').compareTo(
                        DateTime.parse('${a['data']}')));
              } else {
                dati1.sort((a, b) =>
                    DateTime.parse('${a['data']}').compareTo(
                        DateTime.parse('${b['data']}')));
              }
            }
            print(dati1);
            for (var i in dati1) {
              if (getTransazione(DateTime.parse(i['data'].toString()))) {
                lista.add(Transazione(dati: i));
                a++;
                if (a == max && max != 0) {
                  break;
                }
              }
            }


          }
      var num = await contaTransazioni();
      lista.add(Text('$num'));
      return lista;
    }


    return OpenContainer(
      closedBuilder: (_, openContainer) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
          color: Colors.grey[900],
          child: Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.titolo, style: TextStyle(color: Colors.white, fontSize: 20)),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFF424242)),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            padding: EdgeInsets.all(0),
                            iconSize: 20,
                            splashRadius: 20,
                            icon: Icon(decrescente? Icons.arrow_downward : Icons.arrow_upward),
                            onPressed: () {
                              setState(() {
                                decrescente? decrescente = false : decrescente = true;
                              });
                            },
                          ),
                          PopupMenuButton(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 6),
                              child: Row(
                                children: [
                                  filtri[_selection],

                                ],
                              ),
                            ),
                            iconSize: 25,
                            color: Colors.black,
                            onSelected: (int result) { setState(() { _selection = result;});},
                            itemBuilder: (BuildContext context) => filtri.map((e) => PopupMenuItem<int>(
                                value: filtri.indexOf(e),
                                child: e
                            )).toList()
                          )
                        ]
                      )
                    )
                  ]
                ),
                SizedBox(height: 5),
                FutureBuilder(
                  future: printTransazioni(max),
                  builder: (BuildContext, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List lista = [];

                      for (var i in snapshot.data) if (i != snapshot.data.last) lista.add(i);

                        // if (_selection == 0) {
                        //   //importo
                        //   if (decrescente) {
                        //     lista.sort((a, b) =>
                        //         DateTime.parse('${b['data']}').compareTo(
                        //             DateTime.parse('${a['data']}')));
                        //   } else {
                        //     lista.sort((a, b) =>
                        //         DateTime.parse('${a['data']}').compareTo(
                        //             DateTime.parse('${b['data']}')));
                        //   }
                        // }
                      return Column(
                        children: [
                          for (var i in snapshot.data) if (i != snapshot.data.last) i,
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if(int.parse(snapshot.data.last.data) > 3) TextButton(
                                    child: Row(
                                      children: const [
                                        Icon(Icons.more_horiz, color: Colors.white),
                                        Text(' visualizza tutte', style: TextStyle(
                                            color: Colors.white))
                                      ],
                                    ),
                                    onPressed: openContainer
                                )
                              ]
                          )

                        ]
                      );
                    } else {
                      return SizedBox();
                    }
                  }
                ),

              ]
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
            title: Text(widget.titolo, style: TextStyle(color: Colors.white, fontSize: 20)), //TODO: titolo
          ),
          body: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(15),
            color: Colors.grey[900],
            child: Container(
              margin: EdgeInsets.all(15),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: FutureBuilder(
                  future: printTransazioni(0),
                  builder: (BuildContext, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var i in snapshot.data) if(i != snapshot.data.last) i,
                          ]
                      );
                    }else {
                      return SizedBox();
                    }
                  },
                )
              )
            )
          )
        );
      }
    );
  }
}