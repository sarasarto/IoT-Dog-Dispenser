import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  @override
  Widget build(BuildContext context) {
    widget.dispensers = Provider.of<List<Dispenser>>(context);
    return StreamBuilder(
        stream: DatabaseService().dispensers,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          widget._currentDispenser = null;
          if (asyncSnapshot.hasData) {
            if (widget.dispensers.isNotEmpty) {
              if (widget._currentDispenser == null) {
                widget._currentDispenser = widget.dispensers[0];
              }
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
                        });
                      }),
                  Container(
                    child: Center(
                      child:
                          Text(widget._currentDispenser.foodState.toString()),
                    ),
                  )
                ],
              ));
            } else {
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
