import 'package:flutter/material.dart';
import 'package:portfolio/card/saldo.dart';
import 'package:portfolio/card/transazioni_con_filtro.dart';
import 'package:portfolio/chart/torta.dart';
import 'package:portfolio/constants/const.dart';

class Guadagni extends StatelessWidget {
  const Guadagni({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          SaldoCard(denaroTotale: 800.00, tipo: 'guadagni'),
          CardTorta(categoria: categoria_guadagni),
          Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
          CardTransazioni(titolo: 'Ultime transazioni', isPassato: true, tipo: 'guadagni'),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
