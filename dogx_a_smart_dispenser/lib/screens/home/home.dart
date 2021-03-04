import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('DogX'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _authService.signOut();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Dashboard()
        ],
      ),
    );
  }
}
