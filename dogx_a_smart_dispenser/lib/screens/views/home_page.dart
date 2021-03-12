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

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _dbService = DatabaseService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    widget.animals = Provider.of<List<Animal>>(context);

    widget.dispensers = Provider.of<List<Dispenser>>(context);

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
                          percent:  _currentDispenser.qtnRation/100, 
                          center: new Text( _currentDispenser.qtnRation.toString() + "%",
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
                  ErogationPage(dispenser: _currentDispenser),
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
                    Text('Non hai ancora connesso alcun dispenser',
                    style: TextStyle(fontSize: 20.0),),
                    Text('Aggiungine uno nuovo!',style: TextStyle(fontSize: 16.0),)
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
