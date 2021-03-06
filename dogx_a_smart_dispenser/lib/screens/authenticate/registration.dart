import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  //final Function toggleView;
  //Registration({this.toggleView});

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String surname = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('DogX'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Nome'),
                  validator: (val) => val.isEmpty ? 'Enter a name' : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Cognome'),
                  validator: (val) => val.isEmpty ? 'Enter a surname' : null,
                  onChanged: (val) {
                    setState(() => surname = val);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) =>
                      val.length < 6 ? 'Enter a password 6+ chars' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _authService
                          .registerWithEmailAndPassword(name, surname, email, password);
                      if (result == null) {
                        setState(() => error = 'please supply a valid email');
                      } else {
                        Navigator.pop(context);
                      }     
                    }
                  },
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }
}
