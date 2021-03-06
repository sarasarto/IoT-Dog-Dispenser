import 'package:dogx_a_smart_dispenser/screens/authenticate/registration.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Benvenuto su DogX', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Inserisci un\' email valida' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (val) =>
                      val.length < 6 ? 'Inserisci una password di almeno 6 caratteri' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.black,
                  child: Text(
                    'Accedi',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _authService
                          .signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() => error = 'Email o password errati');
                      }
                    }
                  },
                ),
                RaisedButton(
                  color: Colors.black,
                  child: Text(
                    'Registrati',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registration())
                    );
                  },
                ),
                SizedBox(height: 12),
                Text(
                  error,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }
}
