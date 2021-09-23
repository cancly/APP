
import 'package:flutter/material.dart';
import 'package:portfolio/card/transazioni.dart';
import 'package:portfolio/chart/linea.dart';

class Generale extends StatefulWidget {
  const Generale({Key? key}) : super(key: key);

  @override
  State<Generale> createState() => _GeneraleState();
}

class _GeneraleState extends State<Generale> {

  int _selection = 0;
  var frequenza = [
    Text('settimanale', style: TextStyle(color: Colors.white)),
    Text('mensile', style: TextStyle(color: Colors.white)),
    Text('annuale', style: TextStyle(color: Colors.white)),
    Text('sempre', style: TextStyle(color: Colors.white)),
  ];

  var frequenza1 = [
    'settimanale',
    'mensile',
    'annuale',
    'complessivo'
  ];

  @override
  Widget build(BuildContext context) {
    var saldoTotale = 500.32;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(15),
            color: Colors.grey[900],
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('saldo',style: TextStyle(color: Colors.white)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${saldoTotale} €', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                      PopupMenuButton<int>(
                          tooltip: 'scegli arco temporale',
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF424242)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                frequenza[_selection],
                                Icon(Icons.arrow_drop_down_outlined, color: Colors.white)
                              ],
                            ),
                          ),
                          iconSize: 25,
                          color: Colors.black,
                          onSelected: (int result) { setState(() { _selection = result;});},
                          itemBuilder: (BuildContext context) => frequenza.map((e) => PopupMenuItem<int>(
                              value: frequenza.indexOf(e),
                              child: e
                          )).toList()
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('guadagno ${frequenza1[_selection]}', style: TextStyle(color: Colors.grey)), //TODO: var data
                      Row(
                        children: [
                          Text('+03.45€  ', style: TextStyle(color: Colors.green)),
                          Text('+10.33%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, backgroundColor: Colors.green.withOpacity(0.1)))
                        ],
                      ), //TODO: var
                    ],
                  ),
                  SizedBox(height: 5),

                  _selection!= 3? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('rispetto al periodo precedente', style: TextStyle(color: Colors.grey)), //guadagno o perdita
                      Row(
                        children: [
                          Text('+03.45€  ', style: TextStyle(color: Colors.green)),
                          Text('+10.33%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, backgroundColor: Colors.green.withOpacity(0.1)))
                        ],
                      ), //TODO: var
                    ],
                  ) : SizedBox(),
                ],
              ),
            ),
          ),

          GraficoLinea(range: _selection),

          Divider(color: Colors.grey[850], height: 1, endIndent: 40, indent: 40),




          CardTransazioni(titolo: 'Ultime transazioni', isPassato: true),
          CardTransazioni(titolo: 'transazioni in arrivo', isPassato: false),

          SizedBox(height: 80)

        ],
      ),
    );
  }
}
