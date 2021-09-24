import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/function/function.dart';

class GraficoLinea extends StatefulWidget {
  final range;

  const GraficoLinea({this.range});

  @override
  State<GraficoLinea> createState() => _GraficoLineaState();
}

class _GraficoLineaState extends State<GraficoLinea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(15),
      child: FutureBuilder(
        future: GeneraSpot(widget.range),
        builder: (BuildContext, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return LineChart(
              LineChartData(
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: SideTitles(showTitles: false),
                    topTitles: SideTitles(showTitles: false),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 20,
                      interval: 1,
                      getTextStyles: (context, value) =>
                      const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
                      getTitles: (value) {
                        switch (widget.range) {
                          case 0:
                            return '${dataToString(DateTime.now().add(Duration(days: -7 + value.toInt())))}';
                          case 1:
                            switch (value.toInt()) {
                            }
                            return '';

                          case 2:
                            switch (value.toInt()) {
                            }
                            return '';
                      }
                        return '';
                      },
                      margin: 8,
                    ),
                    leftTitles: SideTitles(showTitles: false)
                  ),


                  betweenBarsData: [BetweenBarsData(fromIndex: 0, toIndex: 0)],
                  borderData: FlBorderData(
                      border: Border(
                          left: BorderSide(color: Colors.grey, width: 2.0, style: BorderStyle.solid),
                          bottom: BorderSide(color: Colors.grey, width: 2.0, style: BorderStyle.solid)
                      )
                  ),

                  gridData: FlGridData(
                      show: true,
                      verticalInterval: widget.range==0? 1.0 : widget.range==1? 7.0 : 30.0, //1 se settimana, 7 se mese, 30 se anno
                      horizontalInterval: 999999999999999
                  ),

                  lineBarsData: [

                    //totale
                    LineChartBarData(
                        belowBarData: BarAreaData(
                          show: true,
                          colors: [Colors.white.withOpacity(0.2)],
                        ),
                        barWidth: 3.0,
                        dotData: FlDotData(show: false),
                        colors: [Colors.white],
                        isCurved: false,
                        spots: snapshot.data
                    ),
                  ]
              ),
              swapAnimationDuration: Duration(milliseconds: 300), // Optional
              swapAnimationCurve: Curves.easeInOut, // Optional
            );
          } else {
            return SizedBox();
          }
        }
      )
    );
  }
}
