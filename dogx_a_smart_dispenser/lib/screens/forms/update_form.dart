import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';

class UpdateForm extends StatefulWidget {
  Animal animal;
  UpdateForm({this.animal});

  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final _formkey = GlobalKey<FormState>();
  final DatabaseService _dbService = DatabaseService();
  final AuthService _authService = AuthService();

  final nameController = TextEditingController();
  final rationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = widget.animal.name;
    rationController.text = widget.animal.dailyRation.toString();
  }

  @override
  Widget build(BuildContext context) {
    String name;
    int dailyRation;

    nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length));
    rationController.selection = TextSelection.fromPosition(
        TextPosition(offset: rationController.text.length));

    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(hintText: 'Nome'),
            validator: (val) => val.isEmpty ? 'Inserisci un nome' : null,
            onChanged: (text) {
              name = text;
            },
          ),
          TextFormField(
            controller: rationController,
            decoration: InputDecoration(hintText: 'Razione'),
            keyboardType: TextInputType.number,
            validator: (val) => val.isEmpty ? 'Inserisci una razione' : null,
          ),
          SizedBox(height: 20),
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              'Modifica',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_formkey.currentState.validate()) {
                name = nameController.text;
                dailyRation = int.parse(rationController.text);

                _dbService.updateAnimal(
                    widget.animal.collarId,
                    nameController.text,
                    int.parse(rationController.text),
                    int.parse(rationController.text),
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
