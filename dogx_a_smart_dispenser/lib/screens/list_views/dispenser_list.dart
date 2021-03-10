//in questa schermata andremo a visualizzare tutti i dispenser
//associati ad un utente

import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dispenser_tile.dart';

class DispenserList extends StatefulWidget {
  final List<Animal> animals;
  DispenserList({this.animals});
  @override
  _DispenserListState createState() => _DispenserListState();
}

class _DispenserListState extends State<DispenserList> {
  @override
  Widget build(BuildContext context) {
    //print("arrivo qua listttttttttttttttt");
    final dispensers = Provider.of<List<Dispenser>>(context);
    //final animals = Provider.of<List<Animal>>(context);
    final DatabaseService _dbService = DatabaseService();

    return ListView.builder(
      itemCount: dispensers != null ? dispensers.length : 0,
      itemBuilder: (context, index) {
        return Dismissible(
            key: Key(dispensers[index].id),
            onDismissed: (direction) {
              _dbService.deleteDispenser(dispensers[index].id);
            },
            background: Container(color: Colors.red),
            child: DispenserTile(
                dispenser: dispensers[index] /*, animals:widget.animals*/));
      },
    );
  }
}
