//in questa schermata mostreremo la lista di animali
//associati a quell utente
//in cui si può settare la quantità giornaliera ecc.

import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'animal_tile.dart';

class AnimalList extends StatefulWidget {
  @override
  _AnimalListState createState() => _AnimalListState();
}

class _AnimalListState extends State<AnimalList> {
  @override
  Widget build(BuildContext context) {
    final animals = Provider.of<List<Animal>>(context);

    return ListView.builder(
    itemCount: animals != null ? animals.length : 0,
    itemBuilder: (context, index) {
        return AnimalTile(animal: animals[index]);
      },
    ); 
  }
}
