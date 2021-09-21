import 'package:flutter/material.dart';
import 'package:portfolio/widget/simbolo.dart';

var colorePrincipale = Color(0xFF1565C0); /// o Colors.green[800]
const coloreSpesa = Colors.red;
const coloreGuadagni = Colors.green;
const coloreCard = Color(0xFF212121);
var verificaFatta = false;


var categoria_costi = [
  [
    Simbolo(icona: Icons.home, colore: Colors.blue),
    Text('affitto', style: TextStyle(color: Colors.white))
  ],
  [
    Simbolo(icona: Icons.shopping_bag, colore: Colors.green),
    Text('spesa', style: TextStyle(color: Colors.white))
  ],
  [
    Simbolo(icona: Icons.pets, colore: Colors.yellow),
    Text('animale', style: TextStyle(color: Colors.white))
  ],
  [
    Simbolo(icona: Icons.directions_bus, colore: Colors.tealAccent),
    Text('trasporto', style: TextStyle(color: Colors.white))
  ],
  [
    Simbolo(icona: Icons.phone, colore: Colors.red),
    Text('telefono', style: TextStyle(color: Colors.white))
  ],
  [
    Simbolo(icona: Icons.school, colore: Colors.lightGreenAccent),
    Text('istruzione', style: TextStyle(color: Colors.white))
  ],
  [
    Simbolo(icona: Icons.explore, colore: Colors.white70),
    Text('viaggo', style: TextStyle(color: Colors.white))
  ],

];

var categoria_guadagni = [
  [
    Simbolo(icona: Icons.redeem_outlined, colore: Colors.green),
    Text('regalo', style: TextStyle(color: Colors.white)),
  ],
  [
    Simbolo(icona: Icons.payments, colore: Colors.yellow),
    Text('stipendio', style: TextStyle(color: Colors.white))
  ],
  [
    Simbolo(icona: Icons.home, colore: Colors.red),
    Text('affitto', style: TextStyle(color: Colors.white))
  ],
];

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