import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErogationPage extends StatefulWidget {
  final Dispenser dispenser;

  ErogationPage({this.dispenser});

  @override
  _ErogationPageState createState() => _ErogationPageState();
}

class _ErogationPageState extends State<ErogationPage> {
  String _currentQnt;
  Animal _currentAnimal;
  List<Animal> animals;

  DateTime pickedDate;
  TimeOfDay time;
  @override
  void initState() {
    super.initState();
    _currentAnimal = null;
    pickedDate = DateTime.now();
    time = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    Dispenser dispenser = widget.dispenser;
    final animals = Provider.of<List<Animal>>(context);
    final AuthService _authService = AuthService();
    final DatabaseService _dbService = DatabaseService();

    _pickDate() async {
      DateTime date = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime(DateTime.now().year + 5),
        initialDate: pickedDate,
      );
      if (date != null)
        setState(() {
          pickedDate = date;
        });
    }

    _pickTime() async {
      TimeOfDay t = await showTimePicker(context: context, initialTime: time);
      if (t != null)
        setState(() {
          time = t;
          print("tempo scelto: " + time.toString());
          // QUA DEVO PRENDERE IL DISPENSER E METTERE IL TEMPO NELLA VARIABILE GIUSTA
          //_dbService.updateDispenser(id, userId, qtnRation, collarId, ORARIO)
        });
    }

    return StreamBuilder(
        stream: DatabaseService().animals,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            return Container(
                child: Column(
              children: <Widget>[
                SizedBox(height: 40.0),
                Text(
                  'Seleziona il tuo animale',
                  style: TextStyle(fontSize: 16.0),
                  //textAlign: TextAlign.left,
                ),
                SizedBox(height: 20.0),
                DropdownButtonFormField<Animal>(
                    hint: Text("Seleziona il tuo animale"),
                    value: _currentAnimal,
                    items: animals.map((animal) {
                      return DropdownMenuItem(
                        value:
                            animal, //questo è il corrente che devo mettere nel db
                        child:
                            Text(animal.name, style: TextStyle(fontSize: 18.0)),
                      );
                    }).toList(),
                    onChanged: (Animal value) {
                      setState(() {
                        _currentAnimal = value;
                        print('SELEZIONATOOOO');
                        print(_currentAnimal.name);
                      });
                    }),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Quantità da erogare'),
                  validator: (val) =>
                      val.isEmpty ? 'Quantità da erogare' : null,
                  onChanged: (val) => setState(() => _currentQnt = val),
                ),
                //button
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Eroga Ora',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center),
                    onPressed: () async {
                      // DA METTERE CONTROLLO CHE UTENTE SELEZIONI SIA ANIMALE CHE QUANITTA
                      // ALTRIMENTI DIALOG CHE DICE DI METTERLI

                      // QUANITA NEGATIVA (?)
                      print(_currentQnt);
                      print('CLICCATO EROGAZIONE PER::::');
                      print(_currentAnimal);
                      if (_currentAnimal != null) {
                        if (_currentAnimal.availableRation >=
                            int.parse(_currentQnt)) {
                          print(_currentAnimal.name);
                          print(_currentQnt);
                          _currentAnimal.availableRation -=
                              int.parse(_currentQnt);
                          _dbService.updateDispenser(
                              dispenser.id,
                              _authService.getCurrentUserUid(),
                              int.parse(_currentQnt),
                              _currentAnimal.collarId);

                              Navigator.of(context).pop();
                          showDialog(
                              context: context,
                              barrierDismissible:
                                  false, // disables popup to close if tapped outside popup (need a button to close)
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Hai erogato correttamente",
                                  ),

                                  //buttons METTIAMO LA POSSIBILIà DI DARGLI PIU CIBO?????
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Ok, close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }, //closes popup
                                    ),
                                  ],
                                );
                              });
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible:
                                  false, // disables popup to close if tapped outside popup (need a button to close)
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "La quantità selezionata supera la razione giornaliera disponibile",
                                  ),
                                  content: Text("Erogare comunque?"),
                                  //buttons METTIAMO LA POSSIBILIà DI DARGLI PIU CIBO?????
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Indietro"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }, //closes popup
                                    ),
                                    FlatButton(
                                      child: Text("Eroga"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        //cambio qntRation cosi bridge se ne accorge
                                        _dbService.updateDispenser(
                                            dispenser.id,
                                            _authService.getCurrentUserUid(),
                                            int.parse(_currentQnt),
                                            _currentAnimal.collarId);

                                            Navigator.of(context).pop();
                                      }, //closes popup
                                    ),
                                  ],
                                );
                              });
                        }
                      }
                    }),
                SizedBox(height: 20.0),
                RaisedButton(
                    color: Colors.pink[400],
                    child: Text('Programma Erogazione',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Scaffold(
                              appBar: AppBar(
                                title: Text('Date Time Picker'),
                              ),
                              body: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                          "Date: ${pickedDate.year}, ${pickedDate.month}, ${pickedDate.day}"),
                                      trailing: Icon(Icons.keyboard_arrow_down),
                                      onTap: _pickDate,
                                    ),
                                    ListTile(
                                      title: Text(
                                          "Time: ${time.hour}:${time.minute}"),
                                      trailing: Icon(Icons.keyboard_arrow_down),
                                      onTap: _pickTime,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
              ],
            ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
