/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/User.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFormDispenser extends StatefulWidget {
  //final List<Animal> animals;
  //AddFormDispenser({this.animals});
  @override
  _AddFormDispenserState createState() => _AddFormDispenserState();
}

class _AddFormDispenserState extends State<AddFormDispenser> {
  final _formkey = GlobalKey<FormState>();
  final DatabaseService _dbService = DatabaseService();
  final AuthService _authService = AuthService();

  String id;
  String userId;
  int qtnRation;
  @override
  Widget build(BuildContext context) {
    int qnt = 0;

    //List<Animal> animals = widget.animals;
    //print(animals);
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(hintText: 'ID'),
            validator: (val) => val.isEmpty ? 'Inserisci un id' : null,
            onChanged: (val) {
              setState(() => id = val);
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Aggiungi',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              //print(animals2);
              if (_formkey.currentState.validate()) {
                _dbService.addDispenser(
                  id, //quello che inserisco --> QRCODE
                  _authService.getCurrentUserUid(),
                  qnt,
                  //widget.animals[0].availableRation, //razione
                );

                Navigator.pop(context);
              }
            },
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/CustomUser.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dogx_a_smart_dispenser/screens/forms/scanner.dart';

class AddFormDispenser extends StatefulWidget {
  //final List<Animal> animals;
  //AddFormDispenser({this.animals});
  @override
  _AddFormDispenserState createState() => _AddFormDispenserState();
}

class _AddFormDispenserState extends State<AddFormDispenser> {
  final _formkey = GlobalKey<FormState>();
  final DatabaseService _dbService = DatabaseService();
  final AuthService _authService = AuthService();

  String id;
  String userId;
  int qtnRation;
  String _result;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  @override
  Widget build(BuildContext context) {
    int qnt = 0;
    String qrCodeResult = "Not Yet Scanned";
    //List<Animal> animals = widget.animals;
    //print(animals);
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          // scanner qrcode
          Text(
            qrCodeResult,
            style: TextStyle(
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.0,
          ),
          FlatButton(
              child: Text(
                "Open Scanner",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                /*String codeSanner = await scanner.scan(); //barcode scnner
              setState(() {
                qrCodeResult = codeSanner;
                print(qrCodeResult);*/
                _openScanner(context);
              }),

          TextFormField(
            decoration: InputDecoration(hintText: 'ID'),
            validator: (val) => val.isEmpty ? 'Inserisci un id' : null,
            onChanged: (val) {
              setState(() => id = val);
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Aggiungi',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              //print(animals2);
              if (_formkey.currentState.validate()) {
                _dbService.addDispenser(
                  id, //quello che inserisco --> QRCODE
                  _authService.getCurrentUserUid(),
                  qnt,
                  //widget.animals[0].availableRation, //razione
                );

                Navigator.pop(context);
              }
            },
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }

  Future _openScanner(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (c) => Scanner()));
    _result = result;
    print(_result);
  }
}
