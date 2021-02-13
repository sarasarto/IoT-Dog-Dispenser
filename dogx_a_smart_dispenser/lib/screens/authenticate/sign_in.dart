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
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to the App'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                TextFormField(
                  validator: (val) =>
                      val.length < 6 ? 'Enter a password 6+ chars' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _authService
                          .signInWithEmailAndPassword(email, password);
                      if (result == null) {
                        setState(() => error = 'Invalid email or password');
                      }
                    }
                  },
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'No Account?--> Register!',
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
                  style: TextStyle(color: Colors.red, fontSize: 14),
                )
              ],
            ),
          )),
    );
  }
}
