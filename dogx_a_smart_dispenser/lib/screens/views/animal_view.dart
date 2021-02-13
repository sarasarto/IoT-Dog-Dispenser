import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Animal>>.value(
      value: DatabaseService().animals,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('I tuoi animali'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        body: AnimalList(),
      ),
    );
  }
}
