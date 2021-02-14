import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/dispenser_list.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DispenserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Dispenser>>.value(
      value: DatabaseService().dispensers,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('I tuoi dispenser'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        body: DispenserList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.brown[400],
          onPressed: () {
            print('bottone premuto');
          },
        ),
      ),
    );
  }
}
