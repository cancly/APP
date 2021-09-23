import 'package:flutter/material.dart';
import 'package:portfolio/constants/const.dart';
import 'package:portfolio/function/function.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class NuovaTransazione extends StatefulWidget {
  const NuovaTransazione({Key? key}) : super(key: key);

  @override
  _NuovaTransazioneState createState() => _NuovaTransazioneState();
}

class _NuovaTransazioneState extends State<NuovaTransazione> {
  verificaDenaro(value, controller) {
    if (value.contains(RegExp('[a-zA-Z]'))) {
      value = value.replaceAll(RegExp('[a-zA-Z]'), '');
      print('entra');
    }

    if (value.contains(',')) {
      value = value.replaceAll(',','');
      print(value);
    }

    if (value.contains('..')) {
      print('contiene ".."');
      value = value.replaceAll('..', '.');
    } else if (value.contains('.')) {
      print('contiene "."');
      print(value);
      var f = value.substring(value.indexOf('.')).length - 1;
      if (f > 2) {
        value = value.substring(0, value.length - (value.substring(value.indexOf('.')).length - 3));
      }

    }

    setState(() {
      controller.text = value;
      controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
    });
  }

  int _selection = 0;
  int _selection2 = 0;
  int _selection3 = 0;
  int _selection4 = 0;
  var descrizione = TextEditingController();
  var descrizione2 = TextEditingController();
  var txt = TextEditingController();
  var txt2 = TextEditingController();
  var txt3 = TextEditingController();
  var txt4 = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var siRipete = false;
  var frequenza = [
    const Text('giorni'),
    const Text('mesi'),
    const Text('anni'),
  ];

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_outlined),
                onPressed: () => Navigator.pop(context)
              ),
              title: Text('aggiungi transazione', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black,
              bottom: const TabBar(
                indicatorWeight: 1,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.white, //TODO: cambia colore rosso verde
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.white, //TODO: cambia colore rosso verde
                tabs: [
                  Tab(icon: Icon(Icons.trending_up_outlined)),
                  Tab(icon: Icon(Icons.trending_down_outlined)),
                ],
              ),
            ),
            body: TabBarView(
              children: [

                Column(
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        color: Colors.grey[900],
                        child: Container(
                            margin: const EdgeInsets.all(15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('guadagno', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            height: 50,
                                            child: TextField(
                                                textAlign: TextAlign.end,
                                                controller: txt,
                                                onChanged: (String value) {
                                                  verificaDenaro(value, txt);
                                                },
                                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.white
                                            ),
                                          ),
                                          Text('€', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
                                        ],
                                      ),
                                      Row(
                                        children: [

                                          PopupMenuButton<int>(
                                              tooltip: 'scegli categoria',
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Color(0xFF424242)),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Row(
                                                    children:[
                                                      categoria_guadagni[_selection][0],
                                                      categoria_guadagni[_selection][1],

                                                    ]
                                                ),
                                              ),
                                              iconSize: 25,
                                              color: Colors.black,
                                              onSelected: (int result) { setState(() { _selection = result;});},
                                              itemBuilder: (BuildContext context) => categoria_guadagni.map((e) => PopupMenuItem<int>(
                                                  value: categoria_guadagni.indexOf(e),
                                                  child: Row(
                                                      children: [
                                                        e[0],
                                                        e[1]
                                                      ]
                                                  )
                                              )).toList()
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ]
                            )
                        )
                    ),

                    Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        color: Colors.grey[900],
                        child: Container(
                            margin: const EdgeInsets.all(15),
                            child: Column(
                                children: [

                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFF424242)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: MaterialButton(
                                        height: 50,
                                        onPressed: () => _selectDate(context),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("${selectedDate.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20, color: Colors.white)),
                                            SizedBox(width: 10),
                                            Icon(Icons.date_range_outlined, color: Colors.white)
                                          ],
                                        )
                                    ),

                                  ),
                                  Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                                  SizedBox(height: 15),
                                  TextField(
                                    controller: descrizione,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF1565C0)),
                                      ),
                                      hintText: 'descrizione',
                                    ),

                                    maxLines: 1,

                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('si ripete', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      Switch(
                                        value: siRipete,
                                        onChanged: (value) {
                                          setState(() {
                                            siRipete = value;
                                          });
                                        },
                                        activeTrackColor: colorePrincipale,
                                        activeColor: Colors.blueAccent,
                                      ),
                                    ],
                                  ),

                                  if (siRipete==true) Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ogni', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: TextField(
                                                controller: txt2,
                                                onChanged: (String value) {
                                                  if (value.contains(RegExp('[a-zA-Z.,]'))) {
                                                    value = value.replaceAll(RegExp('[a-zA-Z-.,]'), '');
                                                    print('entra');
                                                  }

                                                  setState(() {
                                                    txt2.text = value;
                                                    txt2.selection = TextSelection.fromPosition(TextPosition(offset: txt2.text.length));
                                                  });
                                                },
                                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.white
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          PopupMenuButton<int>(
                                              tooltip: '',
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Color(0xFF424242)),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Row(
                                                  children: [
                                                    frequenza[_selection2],
                                                    Icon(Icons.arrow_drop_down_outlined, color: Colors.white)
                                                  ],
                                                ),
                                              ),
                                              iconSize: 25,
                                              color: Colors.black,
                                              onSelected: (int result) { setState(() { _selection2 = result;});},
                                              itemBuilder: (BuildContext context) => frequenza.map((e) => PopupMenuItem<int>(
                                                  value: frequenza.indexOf(e),
                                                  child: e
                                              )
                                              ).toList()
                                          ),
                                        ],
                                      )
                                    ],
                                  ) else Container()
                                ]
                            )
                        )
                    )
                  ],
                ),

                Column(
                  children: [
                    Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        color: Colors.grey[900],
                        child: Container(
                            margin: const EdgeInsets.all(15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('costi', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            height: 50,
                                            child: TextField(
                                                textAlign: TextAlign.end,
                                                controller: txt3,
                                                onChanged: (String value) {
                                                  verificaDenaro(value, txt3);
                                                },
                                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.white
                                            ),
                                          ),
                                          Text('€', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
                                        ],
                                      ),
                                      Row(
                                        children: [

                                          PopupMenuButton<int>(
                                              tooltip: 'scegli categoria',
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Color(0xFF424242)),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Row(
                                                    children:[
                                                      categoria_costi[_selection3][0],
                                                      categoria_costi[_selection3][1],

                                                    ]
                                                ),
                                              ),
                                              iconSize: 25,
                                              color: Colors.black,
                                              onSelected: (int result) { setState(() { _selection3 = result;});},
                                              itemBuilder: (BuildContext context) => categoria_costi.map((e) => PopupMenuItem<int>(
                                                  value: categoria_costi.indexOf(e),
                                                  child: Row(
                                                      children: [
                                                        e[0],
                                                        e[1]
                                                      ]
                                                  )
                                              )).toList()
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ]
                            )
                        )
                    ),

                    Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                        color: Colors.grey[900],
                        child: Container(
                            margin: const EdgeInsets.all(15),
                            child: Column(
                                children: [

                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                    width: 170,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xFF424242)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: MaterialButton(
                                        height: 50,
                                        onPressed: () => _selectDate(context),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("${selectedDate.toLocal()}".split(' ')[0], style: TextStyle(fontSize: 20, color: Colors.white)),
                                            SizedBox(width: 10),
                                            Icon(Icons.date_range_outlined, color: Colors.white)
                                          ],
                                        )
                                    ),

                                  ),
                                  Divider(color: Colors.grey[850], height: 1, endIndent: 20, indent: 20),
                                  SizedBox(height: 15),
                                  TextField(
                                    controller: descrizione2,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF1565C0)),
                                      ),
                                      hintText: 'descrizione',
                                    ),

                                    maxLines: 1,

                                  ),
                                  SizedBox(height: 15),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('si ripete', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      Switch(
                                        value: siRipete,
                                        onChanged: (value) {
                                          setState(() {
                                            siRipete = value;
                                          });
                                        },
                                        activeTrackColor: colorePrincipale,
                                        activeColor: Colors.blueAccent,
                                      ),
                                    ],
                                  ),

                                  if (siRipete==true) Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('ogni', style: TextStyle(color: Colors.white, fontSize: 20)),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: TextField(
                                                controller: txt4,
                                                onChanged: (String value) {
                                                  if (value.contains(RegExp('[a-zA-Z.,]'))) {
                                                    value = value.replaceAll(RegExp('[a-zA-Z-.,]'), '');
                                                    print('entra');
                                                  }

                                                  setState(() {
                                                    txt4.text = value;
                                                    txt4.selection = TextSelection.fromPosition(TextPosition(offset: txt4.text.length));
                                                  });
                                                },
                                                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                                                keyboardType: TextInputType.number,
                                                cursorColor: Colors.white
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          PopupMenuButton<int>(
                                              tooltip: '',
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Color(0xFF424242)),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: Row(
                                                  children: [
                                                    frequenza[_selection4],
                                                    Icon(Icons.arrow_drop_down_outlined, color: Colors.white)
                                                  ],
                                                ),
                                              ),
                                              iconSize: 25,
                                              color: Colors.black,
                                              onSelected: (int result) { setState(() { _selection4 = result;});},
                                              itemBuilder: (BuildContext context) => frequenza.map((e) => PopupMenuItem<int>(
                                                  value: frequenza.indexOf(e),
                                                  child: e
                                              )
                                              ).toList()
                                          ),
                                        ],
                                      )
                                    ],
                                  ) else Container()
                                ]
                            )
                        )
                    )
                  ],
                )

              ]
            ),

            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: colorePrincipale,
                label: Text('aggiungi', style: TextStyle(color: Colors.white)),
                icon: Icon(Icons.send, color: Colors.white),
                onPressed: () async {
                  var dati1;
                  var database;

                  var databasesPath = await getDatabasesPath();
                  String path = join(databasesPath, 'database.db');

                  database = await openDatabase(path, version: 1);


                  if (DefaultTabController.of(context)!.index == 0) {
                    //guadagno


                            if (txt.text != '') {
                              var giorni = 0;
                              var mesi = 0;
                              var anni = 0;
                              if (siRipete) {
                                switch (_selection2) {
                                  case 0:
                                    giorni = int.parse(txt2.text);
                                    break;
                                  case 1:
                                    mesi = int.parse(txt2.text);
                                    break;
                                  case 2:
                                    anni = int.parse(txt2.text);
                                    break;
                                }
                              }
                              String strData = selectedDate.toString();
                              await database.transaction((txn) async {
                                int result = await txn.rawInsert("INSERT INTO dati(id_catgoria, valore, descrizione, data, siRipete, giorni, mesi, anni) VALUES($_selection, '${txt.text}', '${descrizione.text}','$strData' ,$siRipete, $giorni, $mesi, $anni)");
                                verificaTipo(result);
                                return ('inserted1: $result');
                              });


                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('aggiunta transazione di ${txt3.text} €'),
                                action: SnackBarAction(
                                  textColor: colorePrincipale,
                                  label: 'annulla',
                                  onPressed: () {
                                    //TODO: annullare
                                  },
                                ),
                                backgroundColor: coloreCard,
                              ));
                              Navigator.pop(context);
                            }



                  } else {
                    //spesa
                    if (txt3.text != '') {
                      var giorni = 0;
                      var mesi = 0;
                      var anni = 0;

                      if (siRipete) {
                        switch (_selection4) {
                          case 0:
                            giorni = int.parse(txt4.text);
                            break;
                          case 1:
                            mesi = int.parse(txt4.text);
                            break;
                          case 2:
                            anni = int.parse(txt4.text);
                            break;
                        }
                      }
                      String strData = selectedDate.toString();
                      await database.transaction((txn) async {
                        int result = await txn.rawInsert("INSERT INTO dati(id_catgoria, valore, descrizione, data, siRipete, giorni, mesi, anni) VALUES($_selection3, '-${txt3.text}', '${descrizione2.text}','$strData' ,$siRipete, $giorni, $mesi, $anni)");
                        print(result);
                        print('id: $result');
                        verificaTipo(result);
                        return 0;
                      });


                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('aggiunta transazione di -${txt3.text} €'),
                        action: SnackBarAction(
                          textColor: colorePrincipale,
                          label: 'annulla',
                          onPressed: () {
                            //TODO: annullare
                          },
                        ),
                        backgroundColor: coloreCard,
                      ));
                      Navigator.pop(context);
                    }
                  }
                },
            ),
          );
        })
      );

  }
}


