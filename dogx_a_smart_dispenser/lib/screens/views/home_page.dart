import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/screens/forms/add_form.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';

class HomePage extends StatefulWidget {
  Dispenser _currentDispenser;
  List<Dispenser> dispensers;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Dispenser last_selected;
  @override
  Widget build(BuildContext context) {
    widget.dispensers = Provider.of<List<Dispenser>>(context);

    return StreamBuilder(
        stream: DatabaseService().dispensers,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          widget._currentDispenser = null;
          print("LASTTTT");
          //last_selected = widget._currentDispenser;
          print(last_selected);

          if (asyncSnapshot.hasData) {
            if (widget.dispensers.isNotEmpty) {
              if (last_selected == null) {
                print("VUOTOOOOOOOOOO");
                widget._currentDispenser = widget.dispensers[0];
                return Container(
                    child: Column(children: <Widget>[
                  SizedBox(height: 40.0),
                  Text(
                    'Seleziona il tuo dispenser per informazioni in tempo reale!',
                    style: TextStyle(fontSize: 16.0),
                    //textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 20.0),
                  DropdownButtonFormField<Dispenser>(
                      value: widget._currentDispenser,
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
                      })
                ]));
              } else {
                print("corrente");
                print(last_selected.id);
                print(widget._currentDispenser);
                widget._currentDispenser = last_selected;
                 print(widget._currentDispenser);
                return Container(
                    child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Text(
                      'Seleziona il tuo dispenser per informazioni in tempo reale!',
                      style: TextStyle(fontSize: 16.0),
                      //textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20.0),
                    DropdownButtonFormField<Dispenser>(
                        value: last_selected,
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
                    Container(
                      child: Column(
                        children: <Widget>[
                          Center(
                            child: Text(last_selected.foodState.toString()),
                          ),
                          SizedBox(height: 20.0),
                          CircularPercentIndicator(
                            radius: 120.0,
                            lineWidth: 13.0,
                            animation: true,
                            percent: 0.7,
                            center: new Text(
                              "70.0%",
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
                    )
                  ],
                ));
              }
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
