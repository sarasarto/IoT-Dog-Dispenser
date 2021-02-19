import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/views/eroga_view.dart';
import 'package:flutter/material.dart';

class DispenserTile extends StatelessWidget {
  final Dispenser dispenser;
  final List<Animal> animals;
  DispenserTile({this.dispenser, this.animals});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(dispenser.id),
          subtitle: Text(dispenser.userId),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ErogaView(dispenser: dispenser, animals:animals)));
          },
        ),
      ),
    );
  }
}