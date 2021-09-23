import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/function/function.dart';
import 'package:portfolio/pages/home%20tab/generale.dart';
import 'package:portfolio/pages/home%20tab/spese.dart';
import 'package:portfolio/pages/home%20tab/guadagni.dart';
import 'package:portfolio/pages/nuova_transazione.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;

  tipi() async {
    Database database;
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'database.db');
    print(path);
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute('CREATE TABLE categorie (id INTEGER PRIMARY KEY AUTOINCREMENT, icona TEXT, colore INTEGER, testo TEXT, guadagno BOOL)');
          await db.execute('CREATE TABLE transazioni (id INTEGER PRIMARY KEY AUTOINCREMENT, id_catgoria TEXT, valore INTEGER,descrizione TEXT, data TEXT)');
          await db.execute('CREATE TABLE dati (id INTEGER PRIMARY KEY AUTOINCREMENT, id_catgoria TEXT, valore INTEGER,descrizione TEXT, data TEXT,siRipete BOOL, giorni INTEGER, mesi INTEGER, anni INTEGER)');
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('home', 'blue', 'affitto', false)");
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('shopping_bag', 'green', 'spesa', false)");
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('pets', 'yellow', 'animale', false)");
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('directions_bus', 'tealAccent', 'trasporto', false)");
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('phone', 'red', 'telefono', false)");
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('school', 'lightGreenAccent', 'istruzione', false)");
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('explore', 'white70', 'viaggo', false)");
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('redeem_outlined', 'green', 'regalo', true)");
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('payments', 'yellow', 'stipendio', true)");
          await db.execute("INSERT INTO categorie(icona,colore,testo,guadagno) VALUES ('home', 'red', 'affitto', true)");
        }
    );

  }

  @override
  void initState() {
    super.initState();

    if (categoria_costi.isEmpty) {
      tipi();
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
    tipi();


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