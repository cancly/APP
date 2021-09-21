import 'package:portfolio/constants/const.dart';

verificaTipo(tipo) {
  if (tipo['siRipete'] == false) {
    //aggiungere alla lista se unico
    var transazione = {
      'categoria': tipo['categoria'],
      'valore': tipo['valore'],
      'data': tipo['data'],
      'descrizione': tipo['descrizione']
    };
    transazioni.add(transazione);
  } else {
    //aggiungere alla lista se multiplo
    DateTime data = tipo['data'];
    while (data.isBefore(dataLimite)) {
      var transazione = {
        'categoria': tipo['categoria'],
        'valore': tipo['valore'],
        'data': data,
        'descrizione': tipo['descrizione']
      };

      transazioni.add(transazione);

      int anni = tipo['anni'].toInt();
      int mesi = tipo['mesi'].toInt();
      int giorni = tipo['giorni'].toInt();

      data = DateTime.utc(
          (data.year + anni), (data.month + mesi), (data.day + giorni));
    }
  }
}



GeneraSpot(dati) {
  /// prende data e valore transazioni
  ///
  /// data minore = 0
  ///
  /// return FlSpot(x,y)
}