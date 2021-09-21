import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/card/transazioni_con_singolo_tipo.dart';

class Transazione extends StatelessWidget {
  const Transazione({required this.dati});

  final dati;

  @override
  Widget build(BuildContext context) {

    String strData = getData(dati['data']);
    var valore = dati['valore'];
    var strValore;

    if (valore < 0) {
      strValore = "$valore €";
    } else {
      strValore = "+$valore €";
    }


    return OpenContainer(

      closedBuilder: (_, openContainer) {
        return Container(
          child: MaterialButton(
            onLongPress: () {

            },
            onPressed: openContainer,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          dati['categoria'][0],
                          dati['categoria'][1],
                          Text(' • $strData', style: TextStyle(color: Colors.grey, fontSize: 10))
                        ]
                    ), //row transazione sinistra

                    Text(strValore, style: TextStyle(color: valore < 0 ? Colors.red : Colors.green)),
                  ],
                ),
                Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),

              ],
            ),
          ),
        );
      },
      openColor: Colors.black,
      closedElevation: 0.0,
      closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      closedColor: coloreCard,
      openBuilder: (_, closeContainer) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.black,
              title: dati['categoria'][1]
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    alignment: Alignment.center,
                    child: Transform.scale(scale: 2.2, child: dati['categoria'][0])
                ),

                CardTransazioni(dati: dati, isPassato: true, titolo: 'transazioni simili passate'),
                CardTransazioni(dati: dati, isPassato: false, titolo: 'transazioni simili in arrivo'),
                SizedBox(height: 20)
              ],
            ),
          ),
        );
      },
    );
  }
}


String getData(data) {
  DateTime now = new DateTime.now();
  var strData;
  if (data.year == now.year && data.month == now.month && data.day == (now.day-1)) {
    strData = 'ieri';
  } else if (data.year == now.year && data.month == now.month && data.day == now.day) {
    strData = 'oggi';
  } else {
    strData = data.day.toString();
    strData += ' ';
    switch (data.month) {
      case 1:
        strData += 'gennaio';
        break;
      case 2:
        strData += 'febbraio';
        break;
      case 3:
        strData += 'marzo';
        break;
      case 4:
        strData += 'aprile';
        break;
      case 5:
        strData += 'maggio';
        break;
      case 6:
        strData += 'giugno';
        break;
      case 7:
        strData += 'luglio';
        break;
      case 8:
        strData += 'agosto';
        break;
      case 9:
        strData += 'settembre';
        break;
      case 10:
        strData += 'ottobre';
        break;
      case 11:
        strData += 'novembre';
        break;
      case 12:
        strData += 'dicembre';
        break;
    }

    if (data.year != now.year) {
      strData += ' ' + data.year.toString();
    }
  }

  return strData;
}