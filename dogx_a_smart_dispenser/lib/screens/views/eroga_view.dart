import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/forms/add_form.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';
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
  /*List<DropdownMenuItem<Animal>> _dropDown;
  Animal _selectedAnimal;
  List<Animal> animals = this.animals;
  @override
  void initState() {
    _dropDown = buildDropDown(this.animals);
    _selectedAnimal = _dropDown[0].value;
    super.initState();
  }

  onChangeDropdownItem(Animal selectedAnimal) {
    setState(() {
      _selectedAnimal = selectedAnimal;
    });
  }

  List<DropdownMenuItem<Animal>> buildDropDown(List animals) {
    List<DropdownMenuItem<Animal>> items = List();
    for (Animal animal in animals) {
      items.add(
        DropdownMenuItem(
          value: animal,
          child: Text(animal.name),
        ),
      );
    }
    return items;
  }*/

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
              'Scegli il tuo animale',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            //dropdown
            DropdownButtonFormField(
                value: _currentAnimal ?? animals[0],
                items: animals.map((animal) {
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
                  print(_currentQnt);
                  print(_currentAnimal.name);
                  if (_currentAnimal.availableRation >=
                      int.parse(_currentQnt)) {
                    print('prima-->' + dispenser.qtnRation.toString());
                    dispenser.setqtnRation(int.parse(_currentQnt));
                    print('dopo-->' + dispenser.qtnRation.toString());
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible:
                            false, // disables popup to close if tapped outside popup (need a button to close)
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              "La quantità super la razione disponibile",
                            ),
                            content: Text("Sei sicuro?"),
                            //buttons METTIAMO LA POSSIBILIà DI DARGLI PIU CIBO?????
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
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
