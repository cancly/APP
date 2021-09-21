import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/card/transazioni_con_singolo_tipo.dart';
import 'package:portfolio/home.dart';

class Transazione extends StatefulWidget {
  const Transazione({required this.dati});

  final dati;

  @override
  State<Transazione> createState() => _TransazioneState();
}

class _TransazioneState extends State<Transazione> {
  var modifica = false;

  @override
  Widget build(BuildContext context) {

    String strData = getData(widget.dati['data']);
    var valore = widget.dati['valore'];
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
                          widget.dati['categoria'][0],
                          widget.dati['categoria'][1],
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
              title: widget.dati['categoria'][1],
              actions: [
                IconButton(
                  icon: Icon(Icons.delete_outlined),
                  onPressed: () {
                    var index = transazioni.indexOf(widget.dati);
                    transazioni.removeAt(index);
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                )
              ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    alignment: Alignment.bottomCenter,
                    child: Transform.translate(child: Transform.scale(scale: 2.2, child: widget.dati['categoria'][0]), offset: Offset(10,0)),
                ),
                SizedBox(height: 30),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  color: Colors.grey[900],
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Text('${widget.dati['valore']} €', style: TextStyle(color: widget.dati['valore']<0? Colors.red : Colors.green, fontSize: 20)),
                            IconButton(
                              icon: Icon(modifica? Icons.edit : Icons.edit_outlined),
                              onPressed: () {
                                setState(() {
                                  modifica? modifica = false : modifica = true;
                                  print(modifica);
                                });
                              },
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Data:'),
                            Text('${widget.dati['data'].day}-${widget.dati['data'].month}-${widget.dati['data'].year}', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        if (widget.dati['descrizione'] != '') Row(
                          children: [
                            Text('Descrizione:'),
                            Text('${widget.dati['descrizione']}',  style: TextStyle(color: Colors.white, fontSize: 15)),
                          ],
                        ),
                      ]
                    ),
                  )
                ),
                Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                CardTransazioni(dati: widget.dati, isPassato: true, titolo: 'transazioni simili passate'),
                CardTransazioni(dati: widget.dati, isPassato: false, titolo: 'transazioni simili in arrivo'),
                SizedBox(height: 20),
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