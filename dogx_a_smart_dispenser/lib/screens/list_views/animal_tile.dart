import 'package:dogx_a_smart_dispenser/screens/forms/update_form.dart';
import 'package:flutter/material.dart';
import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: GestureDetector(
        onTap: () {
          _showUpdatePanel(animal);
        },
        child: Card(
            color: Colors.black12,
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      " " + animal.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: 140.0,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 20.0,
                    leading: new Text("Rimangono " +
                        ((1 - animal.availableRation).abs()).toString()),
                    trailing: new Text(animal.dailyRation.toString()),
                    percent: (1 - animal.availableRation / animal.dailyRation),
                    center: Text(
                        ((1 - animal.availableRation / animal.dailyRation) *
                                    100)
                                .toString() +
                            "%", style: TextStyle(color: Colors.white)),
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.grey[900],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
