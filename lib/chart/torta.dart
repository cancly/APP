import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/widget/simbolo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CardTorta extends StatelessWidget {
  final categoria;


  getDataTorta() async {
    /// variabile somma di tutti i costi
    ///
    /// trovare la percentuale dei costi
    ///
    /// for loop inserire percentuale, colore simbolo
    ///
    /// togliere numeri da grafico
    ///
    /// legenda con valori

    var datiGrafico = <PieChartSectionData>[];
    Simbolo simbolo;

      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'database.db');
      Database database;
      database = await openDatabase(path, version: 1);



      if (categoria == categoria_costi) {
        List<Map> list = await database.rawQuery('SELECT * FROM transazioni WHERE valore < 0');
        Simbolo simbolo = categoria_costi[0][0];
        for (var transazione in list) {
          if (DateTime.parse(transazione['data'].toString()).isBefore(DateTime.now())) {

            for (var tipo in categoria_costi) {
              if (tipo[0].id == int.parse(transazione['id_catgoria'])) {
                simbolo = tipo[0];
              }
            }

            datiGrafico.add(
                PieChartSectionData(value: ((-1) * (double.parse(transazione['valore'].toString()))),
                    color: simbolo.colore,
                    radius: 4.0,
                    showTitle: false)
            );
          }
        }
      } else {
        List<Map> list = await database.rawQuery('SELECT * FROM transazioni WHERE valore > 0');
        Simbolo simbolo = categoria_guadagni[0][0];
        for (var transazione in list) {
          if (DateTime.parse(transazione['data'].toString()).isBefore(DateTime.now())) {

            for (var tipo in categoria_guadagni) {

              if (tipo[0].id == int.parse(transazione['id_catgoria'])) {
                simbolo = tipo[0];
              }
            }
            // print('risultato');
            // print(simbolo.colore);
            datiGrafico.add(
                PieChartSectionData(value: (double.parse(transazione['valore'].toString())),
                    color: simbolo.colore,
                    radius: 4.0,
                    showTitle: false)
            );
          }
        }
      }
    return datiGrafico;

  }

  const CardTorta({this.categoria});

  @override
  Widget build(BuildContext context) {
    Simbolo simbolo;
    var row = <Widget>[];
    for (var tipo in categoria) {
      simbolo = tipo[0];
      row.add(
        Row(
          children: [
            Container(
              decoration: BoxDecoration(color: simbolo.colore, shape: BoxShape.circle),
              height: 10,
              width: 10,
            ),
            tipo[1]
          ]
        )
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
      color: Colors.grey[900],
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width /2,
              height: 200,
              child: FutureBuilder(
                future: getDataTorta(),
                builder: (BuildContext, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return PieChart(
                      PieChartData(
                        sections: snapshot.data,
                        centerSpaceRadius: 80,
                      ),
                      swapAnimationDuration: Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.easeInOut, // Optional
                    );
                  } else {
                    return PieChart(
                      PieChartData(
                        sections: snapshot.data,
                        centerSpaceRadius: 80,
                      ),
                      swapAnimationDuration: Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.easeInOut,
                    );
                  }
                }
              ),
            ),

            Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start, children: row)
          ],
        ),
      ),
    );
  }
}