import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/widget/transazioni.dart';

class CardTransazioni extends StatefulWidget {
  const CardTransazioni({required this.titolo, required this.isPassato, required this.dati});

  final titolo;
  final isPassato;
  final dati;

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

    printTransazioni(max) {
      ///max = 0 è infinito
      var lista = <Widget>[];
      var a = 0;
      for (var i in transazioni) {
        if (getTransazione(i['data'])) {
          if (widget.dati['categoria'] == i['categoria'] && (widget.dati['data'] != i['data'])) {
            lista.add(Transazione(dati: i));
            a++;
            if (a == max && max != 0) {
              break;
            }
          }
        }
      }
      if (lista.length == 0) {lista.add(Text('nessuna transazione', style: TextStyle(fontSize: 15, color: Colors.grey)));}
      return lista;
    }

  contaTransazioni() {
    var totale = 0;
    for (var i in transazioni) {
      if (getTransazione(i['data'])) {
        if (widget.dati['categoria'] == i['categoria'] && (widget.dati['data'] != i['data'])) {
          totale++;
        }
      }
    }
    return totale;
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
                    Text(widget.titolo, style: TextStyle(color: Colors.white, fontSize: 19)),
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
                                  Icon(Icons.filter_list_outlined, color: Colors.white)
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
                          ),
                        ],
                      ),
                    )
                  ]
                ),
                SizedBox(height: 5),
                for (var i in printTransazioni(max)) i,
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(contaTransazioni() > 3) TextButton(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var i in printTransazioni(0)) i,
                  ]
                )
              )
            )
          )
        );
      }
    );
  }
}