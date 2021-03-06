import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';

class AddForm extends StatefulWidget {
  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formkey = GlobalKey<FormState>();
  final DatabaseService _dbService = DatabaseService();
  final AuthService _authService = AuthService();

  String name;
  String dailyRation;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(hintText: 'Nome'),
            validator: (val) => val.isEmpty ? 'Inserisci un nome' : null,
            onChanged: (val) {
              setState(() => name = val);
            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: 'Razione'),
            keyboardType: TextInputType.number,
            validator: (val) => val.isEmpty ? 'Inserisci una razione' : null,
            onChanged: (val) {
              setState(() => dailyRation = val);
            },
          ),
          SizedBox(height: 20),
          RaisedButton(
            color: Colors.black,
            child: Text(
              'Aggiungi',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_formkey.currentState.validate()) {
                _dbService.addAnimal(
                    name,
                    int.parse(dailyRation),
                    int.parse(dailyRation), //all'inizio è uguale alla dailyRation
                    _authService.getCurrentUserUid());
                Navigator.pop(context);
              }
            },
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
