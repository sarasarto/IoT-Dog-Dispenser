import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/forms/add_form.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/dispenser_tile.dart';

class ErogaView extends StatefulWidget {
  final Dispenser dispenser;
  final List<Animal> animals;
  ErogaView({this.dispenser, this.animals});
  @override
  _ErogaViewState createState() => _ErogaViewState();
}

class _ErogaViewState extends State<ErogaView> {
  final _formKey = GlobalKey<FormState>();

  String _currentQnt;
  Animal _currentAnimal;
  int _currentStrenght;

  @override
  Widget build(BuildContext context) {
    List<Animal> animals = widget.animals;
    //print('siamo qua');
    //print(animals);
    Dispenser dispenser = widget.dispenser;
    final AuthService _authService = AuthService();
    final DatabaseService _dbService = DatabaseService();
    print('*************prima-->' + dispenser.qtnRation.toString());
    
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text(dispenser.id),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              'Eroga dal dispenser',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 40.0),
            Text(
              'Seleziona il tuo animale',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            //dropdown
            DropdownButtonFormField(
                //value: _currentAnimal ?? animals[0],
                items: animals.map((animal) {
                  print("quaaaa");
                  //print(animal.name);
                  return DropdownMenuItem(
                    value:
                        animal, //questo è il corrente che devo mettere nel db
                    child: Text(animal.name, style: TextStyle(fontSize: 18.0)),
                  );
                }).toList(),
                onChanged: (Animal value) {
                  setState(() {
                    _currentAnimal = value;
                  });
                }),
            SizedBox(height: 20.0),
            TextFormField(
              decoration: InputDecoration(hintText: 'Quantità da erogare'),
              validator: (val) => val.isEmpty ? 'Quantità da erogare' : null,
              onChanged: (val) => setState(() => _currentQnt = val),
            ),
            //button
            RaisedButton(
                color: Colors.pink[400],
                child: Text('Eroga', style: TextStyle(color: Colors.white)),
                onPressed: () async {

                  // DA METTERE CONTROLLO CHE UTENTE SELEZIONI SIA ANIMALE CHE QUANITTA
                  // ALTRIMENTI DIALOG CHE DICE DI METTERLI

                  // QUANITA NEGATIVA (?) 
                  print(_currentQnt);
                  print(_currentAnimal.name);
                  if (_currentAnimal.availableRation >=
                      int.parse(_currentQnt)) {
                    _dbService.updateDispenser(
                        dispenser.id,
                        _authService.getCurrentUserUid(),
                        int.parse(_currentQnt),
                        _currentAnimal.collarId);
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
                            content: Text("Eroga comunque?"),
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
                                }, //closes popup
                              ),
                            ],
                          );
                        });
                  }
                })
          ],
        ),
      ),
    );
  }
}

/*child: Column(
            children: [for (var a in animals) Text(a.name)],
          ),*/
/*child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Select an animal"),
              SizedBox(
                height: 20.0,
              ),
              DropdownButton(
                value: _selectedAnimal,
                items: _dropDown,
                onChanged: onChangeDropdownItem,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text('Selected: ${_selectedAnimal.name}'),
            ],
          ),
        ),*/
