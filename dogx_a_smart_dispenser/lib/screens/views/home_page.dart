import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

    print('REBUILDDD');

    return StreamBuilder(
        stream: DatabaseService().dispensers,
        builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            if (widget.dispensers.isNotEmpty) {
              for (int i = 0; i < widget.dispensers.length; i++) {
                print(widget.dispensers[i].id);
                print(widget.dispensers[i].foodState);
                print('+++++++++++++++++++++++++++++++++++++++++');
              }

              //_currentDispenser = dispensers[0];
              if (widget._currentDispenser == null) {
                widget._currentDispenser = widget.dispensers[0];
              }
              print('provo accessooooo');
              print(widget._currentDispenser.id);
              return Container(
                  child: Column(
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Text(
                    'Ottieni informazioni aggiornate in tempo reale sui tuoi dispenser!',
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
                  child: Text(
                      'Nessun dispenser disponibile aggiungine uno nuovo!'),
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
