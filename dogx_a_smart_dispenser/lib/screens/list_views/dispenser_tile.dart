import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:flutter/material.dart';

class DispenserTile extends StatelessWidget {
  final Dispenser dispenser;
  DispenserTile({this.dispenser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(dispenser.id),
          subtitle: Text(dispenser.userId),
        ),
      ),
    );
  }
}
