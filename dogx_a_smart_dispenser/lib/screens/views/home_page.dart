import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/views/erogation_page.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';

class HomePage extends StatefulWidget {
  Dispenser _currentDispenser;
  List<Dispenser> dispensers;
  List<Animal> animals;

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

    return StreamBuilder(
        stream: DatabaseService().dispensers,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          widget._currentDispenser = null;

          if (asyncSnapshot.hasData) {
            if (widget.dispensers.isNotEmpty) {
              if (widget._currentDispenser == null) {
                widget._currentDispenser = widget.dispensers[0];
                /* return Container(
                    child: Column(children: <Widget>[
                  //SizedBox(height: 40.0),
                  /*Text(
                    'Seleziona il tuo dispenser per informazioni in tempo reale!',
                    style: TextStyle(fontSize: 16.0),
                    //textAlign: TextAlign.left,
                  ),*/
                  SizedBox(height: 20.0),
                  DropdownButtonFormField<Dispenser>(
                    hint: Text("seleziona il dispenser"),
                      //value: widget._currentDispenser,
                      items: widget.dispensers.map((dispenser) {
                        return DropdownMenuItem(
                          value: dispenser,
                          child: Text(dispenser.id,
                              style: TextStyle(fontSize: 18.0)),
                        );
                      }).toList(),
                      onChanged: (Dispenser value) {
                        setState(() {
                          widget._currentDispenser = value;
                          print("SELEZIONATO");
                          print(widget._currentDispenser.id);
                          last_selected = value;
                        });
                      }),
                ]));*/
              } /*else {*/
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
                        value: widget._currentDispenser,
                        items: widget.dispensers.map((dispenser) {
                          return DropdownMenuItem(
                              value: dispenser,
                              child: Text(dispenser.id,
                                  style: TextStyle(fontSize: 18.0)));
                        }).toList(),
                        onChanged: (Dispenser value) {
                          setState(() {
                            widget._currentDispenser = value;
                          });
                        }),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                              widget._currentDispenser.foodState.toString()),
                        ),
                        SizedBox(height: 20.0),
                        CircularPercentIndicator(
                          radius: 120.0,
                          lineWidth: 13.0,
                          animation: true,
                          percent: 0.7, //(last_selected.qtnRation / 100),
                          center: new Text(
                            "70%",
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
                  ErogationPage(),
                ],
              ));
              //}
            } //if it is not empty
            else {
              // non ci sono dispenser
              return Container(
                child: Center(
                  child: Column(children: <Widget>[
                    Text('Non hai ancora connesso alcun dispenser'),
                    Text('Aggiungine uno nuovo!')
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
