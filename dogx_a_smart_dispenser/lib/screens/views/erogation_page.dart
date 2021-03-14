import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ErogationPage extends StatefulWidget {
  final Dispenser dispenser;

  //Dispenser _currentDispenser;
  List<Animal> animals;
  Animal last_animal;
  int isButtonClicked;
  //bool isLoading = false;
  ErogationPage({this.dispenser});

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
    Animal _currentAnimal;
    //String _currentQnt;

    //print('dispenseeeeer');
    //print(widget.dispenser.qtnRation);
    //print('quaaaa');
    //print(widget.isButtonClicked);
    if (widget.dispenser.qtnRation == 0) {
      if (widget.isButtonClicked != null && widget.isButtonClicked != 0) {
        final snackBar =
            SnackBar(content: Text('Erogazione avvenuta con successo!'));
        Scaffold.of(context).showSnackBar(snackBar);
        widget.isButtonClicked = 0;
      }

      return StreamBuilder(
          stream: DatabaseService().animals,
          builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              if (widget.animals.isNotEmpty) {
                //print("SONO INIZIO");

                print("curr animale");
                print(_currentAnimal);
                print("last animale");
                print(widget.last_animal);
                if (widget.last_animal != null) {
                  //print(widget.last_animal.name);
                  for (Animal a in widget.animals) {
                    if (a.collarId == widget.last_animal.collarId) {
                      widget.last_animal = a;
                    }
                  }
                  _currentAnimal = widget.last_animal;
                  //print('****cur');
                  //print(_currentAnimal.name);
                } else {
                  _currentAnimal = widget.animals[0];
                }
                return Container(
                  child: Column(children: <Widget>[
                    SizedBox(height: 5.0),

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                          //color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(8)),
                      child: DropdownButtonFormField<Animal>(
                          hint: Text("Seleziona il tuo animale"),
                          value: _currentAnimal,
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
                              print('schiacciato pulsante');
                              _currentAnimal = value;
                              widget.last_animal = value;
                              print(widget.last_animal.name);
                            });
                          }),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                              print("quantita corrente");
                              print(_currentQnt);
                              // DA METTERE CONTROLLO CHE UTENTE SELEZIONI SIA ANIMALE CHE QUANITTA
                              // ALTRIMENTI DIALOG CHE DICE DI METTERLI
                              if (_currentAnimal == null ||
                                  _currentQnt == null) {
                                showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // disables popup to close if tapped outside popup (need a button to close)
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Selezionare sia l'animale che la quantità!",
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
                              }

                              // QUANITA NEGATIVA (?)
                              print(_currentQnt);
                              print('CLICCATO EROGAZIONE PER::::');
                              //print(_currentAnimal.name);
                              //print('ULTIMO ANIMALE:');
                             // print(widget.last_animal.name);
                              if (_currentAnimal != null) {
                                if (_currentAnimal.availableRation >=
                                    int.parse(_currentQnt)) {
                                  print(_currentAnimal.name);
                                  //print(_currentQnt);

                                  _currentAnimal.availableRation -=
                                      int.parse(_currentQnt);
                                  print('Valore dell available');
                                  print(_currentAnimal.availableRation);
                                  //print('ULTIMMO ANIMALE:');
                                  //print(widget.last_animal);
                                  _dbService.updateDispenser(
                                      //widget._currentDispenser.id,
                                      widget.dispenser.id,
                                      int.parse(_currentQnt),
                                      _currentAnimal.collarId);
                                  print(_currentAnimal.collarId);

                                  widget.last_animal = _currentAnimal;
                                  // _currentAnimal = null;
                                  //widget.dispenser = null;
                                  //print("QUIII");
                                  //print('ULTIMMO ANIMALE:');
                                  //print(widget.last_animal.name);

                                  widget.isButtonClicked = 1;
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
                                               
                                                //cambio qntRation cosi bridge se ne accorge
                                                _dbService.updateDispenser(
                                                    //dispenser.id,
                                                    widget.dispenser.id,
                                                    int.parse(_currentQnt),
                                                    _currentAnimal.collarId);
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
                              if (_currentAnimal == null ||
                                  _currentQnt == null) {
                                print('qua o animale o razione sono nulli');
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
                                _showDateTimePicker(_currentAnimal);
                              }
                            })
                      ],
                    ),
                    //SizedBox(height: 20.0),
                  ]),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
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
    } else {
      return Center(
        child: Container(
            child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.black))),
      );
    }
  }

  Future<void> _showDateTimePicker(_currentAnimal) async {
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
          DateTime timePicked = DateFormat("hh:mma").parse("6:45PM");
          selectedDate = "${DateFormat("yyyy-MM-dd").format(datePicked)}";
          selectedTime =
              (timePicked.hour.toString() + ":" + timePicked.minute.toString());

          if (_currentAnimal == null || _currentQnt == null) {
            print('o animale o razione sono nulli');
          } else {
            _dbService.addProgrammedErogation(
                widget.dispenser.id,
                //widget.dispenser.id,
                _currentAnimal.collarId,
                int.parse(_currentQnt),
                selectedDate,
                selectedTime);
          }
        });
      }
    }
  }
}
