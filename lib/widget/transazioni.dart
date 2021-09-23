import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/card/transazioni_con_singolo_tipo.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/widget/simbolo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Transazione extends StatefulWidget {
  const Transazione({required this.dati});

  final dati;

  @override
  State<Transazione> createState() => _TransazioneState();
}

class _TransazioneState extends State<Transazione> {
  var modifica = false;
  DateTime selectedDate = DateTime.now();

  afon() async {
    Database database;
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');
    database = await openDatabase(path, version: 1);
    var risultato = await database.rawQuery("SELECT * FROM categorie WHERE id = ${widget.dati['id_catgoria']}");
    return risultato;
  }
  getGraficaCategoria () {
    var datii = afon();
    var risultato = [];
    risultato.add(Simbolo(icona: icone['${datii['icona']}'], colore: colori['${datii['colore']}']));
    risultato.add(Text('${datii['testo']}', style: TextStyle(color: Colors.white)));
    return risultato;
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
                          getGraficaCategoria()[0],
                          getGraficaCategoria()[1],
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
      openBuilder: (_, closeContainer) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.black,
              title: widget.dati['categoria'][1],
              actions: [
                IconButton(
                  splashRadius: 20,
                  icon: Icon(modifica? Icons.edit : Icons.edit_outlined),
                  onPressed: () {
                    setState(() {
                      modifica? modifica = false : modifica = true;
                      print(modifica);
                    });
                  },
                ),
                IconButton(
                  splashRadius: 20,
                  icon: Icon(Icons.delete_outlined),
                  onPressed: () {
                    var index = transazioni.indexOf(widget.dati);
                    transazioni.removeAt(index);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('rimossa transazione di ${widget.dati['categoria'][1].data} dal valore di ${widget.dati['valore']} €'),
                      action: SnackBarAction(
                        textColor: colorePrincipale,
                        label: 'annulla',
                        onPressed: () {
                          transazioni.add(widget.dati);
                          print('adsmodmn');
                        },
                      ),
                      backgroundColor: coloreCard,
                    ));
                    Navigator.pop(context);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
                  },
                )
              ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: 10),
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
                            Text('Importo', style: TextStyle(fontSize: 18)),
                            Text('${widget.dati['valore']} €', style: TextStyle(color: Colors.white, fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Data:', style: TextStyle(fontSize: 18)),
                            Text('${widget.dati['data'].day}/${widget.dati['data'].month}/${widget.dati['data'].year}', style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                        SizedBox(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tipo:', style: TextStyle(fontSize: 18)),
                            TextButton(
                              child: Row(
                                children: [
                                  Transform.scale(scale: 1, child: widget.dati['categoria'][0]),
                                  Transform.scale(scale: 1.2, child: widget.dati['categoria'][1],)
                                ],
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                        SizedBox(height: 0),
                        Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Descrizione:', style: TextStyle(fontSize: 18)),
                            Text(widget.dati['descrizione'] != ''? '${widget.dati['descrizione']}' : 'nessuna descrizione',  style: TextStyle(color: widget.dati['descrizione'] != ''? Colors.white : Colors.grey, fontSize: 18)),
                          ],
                        ),
                      ]
                    ),
                  )
                ),
                Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                CardTransazioni(dati: widget.dati, isPassato: true, titolo: widget.dati['valore'] < 0? 'spese simili passate' : 'guadagni simili passate'),
                CardTransazioni(dati: widget.dati, isPassato: false, titolo: widget.dati['valore'] < 0? 'spese simili in arrivo' : 'guadagni simili futuri'),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
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