import 'package:flutter/material.dart';
import 'package:portfolio/widget/simbolo.dart';

var colorePrincipale = Color(0xFF1565C0); /// o Colors.green[800]
const coloreSpesa = Colors.red;
const coloreGuadagni = Colors.green;
const coloreCard = Color(0xFF212121);
var verificaFatta = false;


var categoria_costi = [];

var categoria_guadagni = [];



List dati = <Map>[
  {
    'categoria': categoria_costi[0],
    'valore': -500,
    'data': DateTime.utc(2022, 09, 15),
    'descrizione': 'descrizione affitto',
    'siRipete': true,
    'giorni': 0,
    'mesi': 1,
    'anni': 0,
  },

  {
    'categoria': categoria_costi[1],
    'valore': -15,
    'data': DateTime.utc(2021, 09, 14),
    'descrizione': 'descrizione',
    'siRipete': true,
    'giorni': 7,
    'mesi': 0,
    'anni': 0,
  },

  {
    'categoria': categoria_guadagni[1],
    'valore': 1500,
    'data': DateTime.utc(2020, 09, 14),
    'descrizione': 'descrizione',
    'siRipete': true,
    'giorni': 0,
    'mesi': 2,
    'anni': 0,
  },
];

List transazioni = <Map>[]; ///categoria, valore, data

var dataLimite = DateTime.utc(2023, 09, 17);

Map icone = {
  'home': Icons.home,
  'shopping_bag':Icons.shopping_bag,
  'pets': Icons.pets,
  'directions_bus': Icons.directions_bus,
  'phone': Icons.phone,
  'school': Icons.school,
  'explore': Icons.explore,
  'redeem_outlined': Icons.redeem_outlined,
  'payments': Icons.payments,
  'home': Icons.home
};

Map colori = {
  'blue': Colors.blue,
  'green':Colors.green,
  'yellow': Colors.yellow,
  'tealAccent': Colors.tealAccent,
  'red': Colors.red,
  'lightGreenAccent': Colors.lightGreenAccent,
  'white70': Colors.white70,
};