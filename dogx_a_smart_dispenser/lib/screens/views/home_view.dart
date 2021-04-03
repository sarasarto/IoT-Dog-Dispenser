import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/views/home_page.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return MultiProvider(
        providers: [
          StreamProvider<List<Dispenser>>.value(
              value: DatabaseService().dispensers),
          StreamProvider<List<Animal>>.value(value: DatabaseService().animals)
        ],
        child: Builder(builder: (BuildContext context) {
          //final animals = Provider.of<List<Animal>>(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              actions: <Widget>[
                Container(
                  child: Center(
                      child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () async {
                      await _authService.signOut();
                    },
                    child: Text("LOG OUT"),
                  )),
                ),
              ],
              title: Text('Feed-X', style: TextStyle(color: Colors.black)),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: HomePage(),
          );
        }));
  }
}
