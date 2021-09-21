import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/widget/simbolo.dart';

class CardTorta extends StatelessWidget {
  final categoria;

  const CardTorta({this.categoria});

  @override
  Widget build(BuildContext context) {
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
    for (var transazione in transazioni) {
      print(transazione['data'].isBefore(DateTime.now()));

      if (categoria == categoria_costi) {
        if (transazione['data'].isBefore(DateTime.now()) && transazione['valore'] < 0) {
          simbolo = transazione['categoria'][0];
          datiGrafico.add(
              PieChartSectionData(value: ((-1) *
                  (double.parse(transazione['valore'].toString())).toDouble()),
                  color: simbolo.colore,
                  radius: 4.0,
                  showTitle: false)
          );
        }
      } else {
        if (transazione['data'].isBefore(DateTime.now()) && transazione['valore'] > 0) {
          simbolo = transazione['categoria'][0];
          datiGrafico.add(
              PieChartSectionData(value: ((-1) *
                  (int.parse(transazione['valore'].toString())).toDouble()),
                  color: simbolo.colore,
                  radius: 4.0,
                  showTitle: false)
          );
        }
      }
    }
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
              child: PieChart(
                PieChartData(
                  sections: datiGrafico,
                  centerSpaceRadius: 80,
                ),
                swapAnimationDuration: Duration(milliseconds: 150), // Optional
                swapAnimationCurve: Curves.easeInOut, // Optional
              ),
            ),

            Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start, children: row)
          ],
        ),
      ),
    );
  }
}
