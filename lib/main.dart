import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/home.dart';
import 'package:portfolio/test/test.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
    theme: ThemeData(
        primaryColor: colorePrincipale,
        brightness: Brightness.dark
      ),
      debugShowCheckedModeBanner: false
    )
  );
}