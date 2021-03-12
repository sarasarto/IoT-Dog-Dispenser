import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/views/erogation_page.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';

class HomePage extends StatefulWidget {
  //Dispenser _currentDispenser;
  List<Dispenser> dispensers;
  List<Animal> animals;
  Dispenser last_selected;
  Animal last_animal;
  Animal _currentAnimal;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _dbService = DatabaseService();
  final AuthService _authService = AuthService();
  String _currentQnt;

  @override
  Widget build(BuildContext context) {
    widget.animals = Provider.of<List<Animal>>(context);

    widget.dispensers = Provider.of<List<Dispenser>>(context);
    print("torno home page");

    Dispenser _currentDispenser;
    return StreamBuilder(
        stream: DatabaseService().dispensers,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            if (widget.dispensers.isNotEmpty) {
              if (widget.last_selected != null) {
                for (Dispenser disp in widget.dispensers) {
                  if (disp.id == widget.last_selected.id) {
                    widget.last_selected = disp;
                  }
                }
                _currentDispenser = widget.last_selected;
              } else {
                _currentDispenser = widget.dispensers[0];
              }
              return Container(
                  child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                        //color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(8)),
                    child: DropdownButtonFormField<Dispenser>(
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 30,
                        value: _currentDispenser,
                        items: widget.dispensers.map((dispenser) {
                          return DropdownMenuItem(
                              value: dispenser,
                              child: Text(dispenser.id,
                                  style: TextStyle(fontSize: 18.0)));
                        }).toList(),
                        onChanged: (Dispenser value) {
                          setState(() {
                            _currentDispenser = value;
                            widget.last_selected = value;
                            print("selezionato");
                            print(widget.last_selected);
                            print(_currentDispenser.id);
                          });
                        }),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(_currentDispenser.foodState.toString()),
                        ),
                        SizedBox(height: 20.0),
                        CircularPercentIndicator(
                          radius: 120.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: _currentDispenser.qtnRation / 100,
                          center: new Text(
                            _currentDispenser.qtnRation.toString() + "%",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          footer: new Text(
                            "Cibo rimasto",
                            style: new TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: Colors.black,
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Fai una erogazione',
                    style: TextStyle(fontSize: 16.0),
                    //textAlign: TextAlign.left,
                  ),

                  /* StreamBuilder(
        stream: DatabaseService().animals,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            if (widget.animals.isNotEmpty) {
              print("SONO INIZIO");

              print("curr");
              print(widget._currentAnimal);
              print("last");
              print(widget.last_animal);
              if (widget.last_animal != null) {
                print(widget.last_animal.name);
                for (Animal a in widget.animals) {
                  if (a.collarId == widget.last_animal.collarId) {
                    widget.last_animal = a;
                  }
                }
                widget._currentAnimal = widget.last_animal;
              } else {
                widget._currentAnimal = widget.animals[0];
              }
              return Container(
                child: Column(children: <Widget>[
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
                            widget.last_animal = value;
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
                            print('ULTIMMO ANIMALE:');
                            print(widget.last_animal.name);
                            if (widget._currentAnimal != null) {
                              if (widget._currentAnimal.availableRation >=
                                  int.parse(_currentQnt)) {
                                print(widget._currentAnimal.name);
                                print(_currentQnt);

                                widget._currentAnimal.availableRation -=
                                    int.parse(_currentQnt);
                                print('Valore dell available');
                                print(widget._currentAnimal.availableRation);
                                print('ULTIMMO ANIMALE:');
                                print(widget.last_animal);
                                _dbService.updateDispenser(
                                    _currentDispenser.id,
                                    //widget.dispenser.id,
                                    int.parse(_currentQnt),
                                    widget._currentAnimal.collarId);
                                print(widget._currentAnimal.collarId);

                                widget.last_animal = widget._currentAnimal;
                                // _currentAnimal = null;
                                //widget.dispenser = null;
                                print("QUIII");
                                print('ULTIMMO ANIMALE:');
                                print(widget.last_animal.name);
                                final snackBar = SnackBar(
                                    content: Text(
                                        'Erogazione avvenuta con successo!'));

                                Scaffold.of(context).showSnackBar(snackBar);
                                setState(() {
                                  print("DOPO EROGAZIOME");
                                  widget.last_animal = widget._currentAnimal;
                                  print(widget.last_animal.name);
                                  
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
                                              //Navigator.of(context).pop();
                                              //cambio qntRation cosi bridge se ne accorge
                                              _dbService.updateDispenser(
                                                  _currentDispenser.id,
                                                  //widget.dispenser.id,
                                                  int.parse(_currentQnt),
                                                  widget._currentAnimal.collarId);


                                       //_currentAnimal = null;
                                              //widget.dispenser = null;
                                              //Navigator.of(context).pop();
                                              /*Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomePage()),
                                              );*/
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
                            if (widget._currentAnimal == null || _currentQnt == null) {
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
                              //_showDateTimePicker(_currentAnimal);
                            }
                          })
                    ],
                  ),
                  //SizedBox(height: 20.0),
                ]),
              );
            }else{
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
        })*/
                  ErogationPage(
                      dispenser: _currentDispenser,
                      currentAnimal: widget._currentAnimal),
                ],
              ));
              //}
            } //if it is not empty
            else {
              // non ci sono dispenser
              return Container(
                child: Center(
                  child: Column(children: <Widget>[
                    SizedBox(height: 70.0),
                    Text(
                      'Non hai ancora connesso alcun dispenser',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      'Aggiungine uno nuovo!',
                      style: TextStyle(fontSize: 16.0),
                    )
                  ]),
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
  }
}
