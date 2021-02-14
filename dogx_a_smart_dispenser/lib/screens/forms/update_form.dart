import 'package:flutter/material.dart';

class UpdateForm extends StatefulWidget {
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formkey = GlobalKey<FormState>();

  String name;
  int dailyRation;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          Text('modifica i dati del tuo animale'),
          SizedBox(height: 20),
          TextFormField(
            validator: (value) => value.isEmpty ? 'Inserisci un nome' : null,
            onChanged: (value) => setState(() => name = value),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField(
            items: [],
          ),

          RaisedButton(
            color: Colors.pink[400],
            child: Text('Modifica'),
            onPressed: () async {
              //comunicazione con firebase per aggiornare i dati
              //per ora facciamo semplici print
              print(name);
              print(dailyRation);
            },
          )
        ],
      ),
    );
  }
}
