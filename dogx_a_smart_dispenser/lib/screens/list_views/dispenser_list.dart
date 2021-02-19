//in questa schermata andremo a visualizzare tutti i dispenser
//associati ad un utente

import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dispenser_tile.dart';

class DispenserList extends StatefulWidget {
  @override
  _DispenserListState createState() => _DispenserListState();
}

class _DispenserListState extends State<DispenserList> {
  @override
  Widget build(BuildContext context) {
    final dispensers = Provider.of<List<Dispenser>>(context);
    //final animals = Provider.of<List<Animal>>(context);

    return ListView.builder(
      itemCount: dispensers != null ? dispensers.length : 0,
      itemBuilder: (context, index) {
        return DispenserTile(dispenser: dispensers[index]);
      },
    );
  }
}
