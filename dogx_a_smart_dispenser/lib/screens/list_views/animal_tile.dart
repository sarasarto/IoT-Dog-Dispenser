import 'package:flutter/material.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';

class AnimalTile extends StatelessWidget {
  final Animal animal;
  AnimalTile({this.animal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(animal.name),
          subtitle: Text(animal.dailyRation.toString()),
        ),
      ),
    );
  }
}
