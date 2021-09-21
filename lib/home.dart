import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/function/function.dart';
import 'package:portfolio/pages/home%20tab/generale.dart';
import 'package:portfolio/pages/home%20tab/spese.dart';
import 'package:portfolio/pages/home%20tab/guadagni.dart';
import 'package:portfolio/pages/nuova_transazione.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();

    for (var tipo in dati) {
      verificaTipo(tipo);
    }

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  final List<Widget> _widgetOptions = <Widget>[
    Spese(),
    Generale(),
    Guadagni(),
  ];

  @override
  Widget build(BuildContext context) {



    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [

          BottomNavigationBarItem(icon: Icon(Icons.trending_down_outlined), label: 'spese'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'generale'),
          BottomNavigationBarItem(icon: Icon(Icons.trending_up_outlined), label: 'guadagni'),

        ],

      ),

      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('portfolio'),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {}
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: colorePrincipale,
        onPressed: () {
          print(transazioni.length);
          Navigator.push(context, MaterialPageRoute(builder: (context) => NuovaTransazione()));
        },
      ),

      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}