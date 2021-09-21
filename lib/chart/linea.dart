import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficoLinea extends StatelessWidget {
  const GraficoLinea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(15),
      child: LineChart(

        LineChartData(

            titlesData: FlTitlesData(
              show: true,
              rightTitles: SideTitles(showTitles: false),
              topTitles: SideTitles(showTitles: false),
              bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                interval: 1,
                getTextStyles: (context, value) =>
                const TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
                // getTitles: (value) {
                //   switch (value.toInt()) {
                //     case 2:
                //       return 'MAR';
                //     case 5:
                //       return 'JUN';
                //     case 8:
                //       return 'SEP';
                //   }
                //   return '';
                // },
                margin: 8,
              ),
              leftTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTextStyles: (context, value) => const TextStyle(
                  color: Color(0xff67727d),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                // getTitles: (value) {
                //   switch (value.toInt()) {
                //     case 1:
                //       return '10k';
                //     case 3:
                //       return '30k';
                //     case 5:
                //       return '50k';
                //   }
                //   return '';
                // },
                reservedSize: 32,
                margin: 12,
              ),
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
                verticalInterval: 7, //1 se settimana, 7 se mese, 30 se anno
                horizontalInterval: 100
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
                  isCurved: true,
                  spots: [
                    FlSpot(0, 0),
                    FlSpot(1, 5),
                    FlSpot(2, 4),
                    FlSpot(3, 8),
                    FlSpot(4, 26),
                    FlSpot(5, 5),
                    FlSpot(6, 0),
                    FlSpot(7, 5),
                    FlSpot(8, 4),
                    FlSpot(9, 8),
                    FlSpot(10, 22),
                    FlSpot(11, 5),
                    FlSpot(12, 0),
                    FlSpot(13, 5),
                    FlSpot(14, 4),
                    FlSpot(15, 8),
                    FlSpot(16, 22),
                    FlSpot(17, 5),
                    FlSpot(18, 0),
                    FlSpot(19, 5),
                    FlSpot(20, 4),
                    FlSpot(21, 8),
                    FlSpot(22, 30),
                    FlSpot(23, 5)
                  ]
              ),
            ]
        ),
        swapAnimationDuration: Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      )
    );
  }
}
