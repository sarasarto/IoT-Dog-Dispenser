import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ErogationPage extends StatefulWidget {
  //final Dispenser dispenser;

  Animal _currentAnimal;
  Dispenser _currentDispenser;
  List<Animal> animals;
  List<Dispenser> dispensers;

  ErogationPage({this.dispensers});

  @override
  _ErogationPageState createState() => _ErogationPageState();
}

class _ErogationPageState extends State<ErogationPage> {
  final DatabaseService _dbService = DatabaseService();

  String _currentQnt;
  String selectedDate;
  String selectedTime;

  @override
  Widget build(BuildContext context) {
    widget.animals = Provider.of<List<Animal>>(context);
    widget.dispensers = Provider.of<List<Dispenser>>(context);
    return StreamBuilder(
        stream: DatabaseService().animals,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          widget._currentAnimal = null;
          if (asyncSnapshot.hasData) {
            if (widget.animals.isNotEmpty) {
              if (widget._currentAnimal == null) {
                widget._currentAnimal = widget.animals[0];
                widget._currentDispenser = widget.dispensers[0];
              }
              return Container(
                child: Column(children: <Widget>[
                  //SizedBox(height: 40.0),
                  /*Text(
                    'Seleziona il tuo animale e il tuo dispenser',
                    style: TextStyle(fontSize: 16.0),
                    //textAlign: TextAlign.left,
                  ),*/
                  //SizedBox(height: 20.0),
                  /*DropdownButtonFormField<Dispenser>(
                      hint: Text("Seleziona il tuo dispenser"),
                      //value: widget._currentDispenser,
                      items: widget.dispensers.map((dispenser) {
                        return DropdownMenuItem(
                          value:
                              dispenser, //questo è il corrente che devo mettere nel db
                          child: Text(dispenser.id,
                              style: TextStyle(fontSize: 18.0)),
                        );
                      }).toList(),
                      onChanged: (Dispenser value) {
                        setState(() {
                          widget._currentDispenser = value;
                          print('SELEZIONATOOOO DISPENSER');
                          print(widget._currentDispenser.id);
                        });
                      }),*/
                  SizedBox(height: 5.0),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                        //color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButtonFormField<Animal>(
                        hint: Text("Seleziona il tuo animale"),
                        //value: widget._currentAnimal,
                        items: widget.animals.map((animal) {
                          return DropdownMenuItem(
                            value:
                                animal, //questo è il corrente che devo mettere nel db
                            child: Text(animal.name,
                                style: TextStyle(fontSize: 18.0)),
                          );
                        }).toList(),
                        onChanged: (Animal value) {
                          setState(() {
                            widget._currentAnimal = value;
                            print('SELEZIONATOOOO');
                            print(widget._currentAnimal.name);
                          });
                        }),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                        //color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8)),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration:
                          InputDecoration(hintText: 'Quantità da erogare'),
                      validator: (val) =>
                          val.isEmpty ? 'Quantità da erogare' : null,
                      onChanged: (val) => setState(() => _currentQnt = val),
                    ),
                  ),
                  //button
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      RaisedButton(
                          color: Colors.black,
                          child: Text('Eroga Ora',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center),
                          onPressed: () async {
                            // DA METTERE CONTROLLO CHE UTENTE SELEZIONI SIA ANIMALE CHE QUANITTA
                            // ALTRIMENTI DIALOG CHE DICE DI METTERLI

                            // QUANITA NEGATIVA (?)
                            print(_currentQnt);
                            print('CLICCATO EROGAZIONE PER::::');
                            print(widget._currentAnimal.name);
                            if (widget._currentAnimal != null) {
                              if (widget._currentAnimal.availableRation >=
                                  int.parse(_currentQnt)) {
                                print(widget._currentAnimal.name);
                                print(_currentQnt);

                                widget._currentAnimal.availableRation -=
                                    int.parse(_currentQnt);
                                print('Valore dell available');
                                print(widget._currentAnimal.availableRation);

                                _dbService.updateDispenser(
                                    widget._currentDispenser.id,
                                    //dispenser.id,
                                    int.parse(_currentQnt),
                                    widget._currentAnimal.collarId);

                                widget._currentAnimal = null;
                                widget._currentDispenser = null;

                                final snackBar = SnackBar(
                                    content: Text(
                                        'Erogazione avvenuta con successo!'));

                                Scaffold.of(context).showSnackBar(snackBar);
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
                                              //Navigator.of(context).pop();
                                              //cambio qntRation cosi bridge se ne accorge
                                              _dbService.updateDispenser(
                                                  //dispenser.id,
                                                  widget._currentDispenser.id,
                                                  int.parse(_currentQnt),
                                                  widget
                                                      ._currentAnimal.collarId);
                                              widget._currentAnimal = null;
                                              widget._currentDispenser = null;
                                              Navigator.of(context).pop();
                                            }, //closes popup
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      RaisedButton(
                          color: Colors.black,
                          child: Text('Programma Erogazione',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center),
                          onPressed: () {
                            if (widget._currentAnimal == null ||
                                _currentQnt == null) {
                              print('o animale o razione sono nulli');
                              showDialog(
                                  context: context,
                                  barrierDismissible:
                                      false, // disables popup to close if tapped outside popup (need a button to close)
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Prima devi selezionare l'animale e la quantità!",
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Ok, ho capito!"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }, //closes popup
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              _showDateTimePicker();
                            }
                          })
                    ],
                  ),
                  //SizedBox(height: 20.0),
                ]),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          }
        });
  }

  Future<void> _showDateTimePicker() async {
    final DateTime datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (datePicked != null) {
      final TimeOfDay timePicked = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
              hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute));
      if (timePicked != null) {
        setState(() {
          selectedDate = "${DateFormat("yyyy-MM-dd").format(datePicked)}";
          selectedTime = "${timePicked.format(context)}";

          if (widget._currentAnimal == null || _currentQnt == null) {
            print('o animale o razione sono nulli');
          } else {
            _dbService.addProgrammedErogation(
                widget._currentDispenser.id,
                //widget.dispenser.id,
                widget._currentAnimal.collarId,
                int.parse(_currentQnt),
                selectedDate,
                selectedTime);
          }
        });
      }
    }
  }
}
