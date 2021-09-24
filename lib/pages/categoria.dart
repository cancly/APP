import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/widget/simbolo.dart';
import 'package:sqflite/sqflite.dart';

class Categoria extends StatefulWidget {
  final dati;

  const Categoria({this.dati});

  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  bool modifica = false;

  dati() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');
    Database database;
    database = await openDatabase(path, version: 1);

    var a = await database.rawQuery('SELECT * FROM dati WHERE id_catgoria = ${widget.dati['id_catgoria']}');
    print('a $a');
    return a;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dati(),
      builder: (BuildContext, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var frequenza = '8';
          if (snapshot.data[0]['giorni'] != 0) {
            frequenza = '${snapshot.data[0]['giorni']} giorni';
          } else if (snapshot.data[0]['mesi'] != 0) {
            if (snapshot.data[0]['mesi'] == 1) {
              frequenza = '${snapshot.data[0]['mesi']} mese';
            } else {
              frequenza = '${snapshot.data[0]['mesi']} mesi';
            }
          } else if (snapshot.data[0]['anni'] != 0) {
            if (snapshot.data[0]['mesi'] == 1) {
              frequenza = '${snapshot.data[0]['anni']} anno';
            } else {
              frequenza = '${snapshot.data[0]['anni']} anni';
            }
          }

          var icona = categoria_costi[0][0];
          var descrizione = categoria_costi[0][1];
          if (snapshot.data[0]['valore'] < 0) {
            for (var i in categoria_costi) {
              if (int.parse(widget.dati['id_catgoria']) == i[0].id) {
                icona = i[0];
                descrizione = i[1];
              }
            }
          } else {
            for (var i in categoria_guadagni) {
              if (int.parse(widget.dati['id_catgoria']) == i[0].id) {
                icona = i[0];
                descrizione = i[1];
              }
            }
          }
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              actions: [
                IconButton(
                  icon: Icon(modifica? Icons.edit : Icons.edit_outlined),
                  onPressed: () async {
                    setState(() {
                      modifica? modifica = false : modifica = true;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete_outlined),
                  onPressed: () async {

                    var databasesPath = await getDatabasesPath();
                    String path = join(databasesPath, 'database.db');
                    Database database;
                    database = await openDatabase(path, version: 1);

                    var a = await database.rawQuery('DELETE FROM transazioni WHERE id_catgoria = ${widget.dati['id_catgoria']}');
                    print(widget.dati['id_catgoria']);
                    a = await database.rawQuery('DELETE FROM dati WHERE id_catgoria = ${widget.dati['id_catgoria']}');
                    print(a);

                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                ),
              ],
            ),
            body: Column(
              children: [
                SizedBox(),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  color: Colors.grey[900],
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Importo:', style: TextStyle(fontSize: 18)),
                            Text('${snapshot.data[0]['valore']} €', style: TextStyle(color: Colors.white, fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Data:', style: TextStyle(fontSize: 18)),
                            Text('${DateTime.parse(snapshot.data[0]['data'].toString()).day}/${DateTime.parse(snapshot.data[0]['data'].toString()).month}/${DateTime.parse(snapshot.data[0]['data'].toString()).year}', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('icona:', style: TextStyle(fontSize: 18)),
                            icona,
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('descrizione:', style: TextStyle(fontSize: 18)),
                            Transform.scale(scale: 1.2, child: descrizione),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('si ripete:', style: TextStyle(fontSize: 18)),
                            Text(snapshot.data[0]['siRipete'] == 1? 'si' : 'no', style: TextStyle(color: Colors.white, fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),

                        if (snapshot.data[0]['siRipete'] == 1) Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                        if (snapshot.data[0]['siRipete'] == 1) SizedBox(height: 10),
                        if (snapshot.data[0]['siRipete'] == 1) Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ogni:', style: TextStyle(fontSize: 18)),
                            Text('$frequenza', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        if (snapshot.data[0]['siRipete'] == 1) SizedBox(height: 10)
                      ]
                    )
                  )
                )
              ]
            )
          );
        } else {
          return SizedBox();
        }
      }
    );
  }
}
