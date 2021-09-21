
import 'package:flutter/material.dart';
import 'package:portfolio/card/transazioni.dart';
import 'package:portfolio/card/saldo.dart';
import 'package:portfolio/chart/linea.dart';

class Generale extends StatefulWidget {
  const Generale({Key? key}) : super(key: key);

  @override
  State<Generale> createState() => _GeneraleState();
}

class _GeneraleState extends State<Generale> {
  @override
  Widget build(BuildContext context) {
    var saldoTotale = 500.32;

    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          SaldoCard(tipo: 'saldo', denaroTotale: saldoTotale),

          GraficoLinea(),

          Divider(color: Colors.grey[850], height: 1, endIndent: 40, indent: 40),




          CardTransazioni(titolo: 'Ultime transazioni', isPassato: true),
          CardTransazioni(titolo: 'transazioni in arrivo', isPassato: false),

          SizedBox(height: 80)

        ],
      ),
    );
  }
}
