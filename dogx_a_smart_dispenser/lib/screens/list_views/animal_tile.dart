import 'package:dogx_a_smart_dispenser/screens/forms/update_form.dart';
import 'package:flutter/material.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';

class AnimalTile extends StatelessWidget {
  final Animal animal;
  final int index;
  AnimalTile({this.animal, this.index});

  @override
  Widget build(BuildContext context) {
    void _showUpdatePanel(Animal animal) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: UpdateForm(animal: animal),
            );
          });
    }

    /* return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          onTap: () {
            //apro il bottom sheet
            _showUpdatePanel(animal);
          },
          title: Text(animal.name),
          subtitle: Text(animal.availableRation.toString()),
        ),
      ),
    );*/

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () {
          _showUpdatePanel(animal);
        },
        child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[Text("Nome: " + animal.name)],
                ),
                Row(
                  children: <Widget>[
                    Text(
                        "Razione giornaliera: " + animal.dailyRation.toString())
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Razione disponibile: " +
                        animal.availableRation.toString())
                  ],
                )
              ],
            )),
      ),
    );
  }
}
