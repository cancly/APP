import 'package:flutter/material.dart';

class Simbolo extends StatelessWidget {
  const Simbolo({ required this.icona, required this.colore, required this.id});
  final colore;
  final icona;
  final id;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(color: colore, shape: BoxShape.circle),
        child: Icon(icona, color: Colors.black),
        margin: EdgeInsets.fromLTRB(0,10,10,10)
    ); //container icona;
  }
}