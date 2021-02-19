import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/forms/add_form.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/dispenser_tile.dart';

class ErogaView extends StatefulWidget {
  final Dispenser dispenser;
  final List<Animal> animals;
  ErogaView({this.dispenser, this.animals});
  @override
  _ErogaViewState createState() => _ErogaViewState();
}

class _ErogaViewState extends State<ErogaView> {
  @override
  Widget build(BuildContext context) {
    List<Animal> animals = widget.animals;
    print('siamo qua');
    print(animals);

    return Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Eroga dal dispenser'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        body: /*Text(animals[0].name))*/
            Container(
          child: Column(
            children: [for (var a in animals) Text(a.name)],
          ),
        )
        );
  }
}
