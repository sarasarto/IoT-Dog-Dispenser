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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      " " + animal.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Spuntini mangiati: " + (animal.foodCounter).toString(),
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 13.0,
                    animation: true,
                    percent: (1 - animal.availableRation / animal.dailyRation),
                    center: Text(
                        ((1 - animal.availableRation / animal.dailyRation) *
                                    100)
                                .round()
                                .toString() +
                            "%",
                        style: TextStyle(color: Colors.white)),
                    footer: new Text(
                      "Cibo rimasto",
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17.0),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.black,
                  ), /*LinearPercentIndicator(
                    width: 140.0,
                    animation: true,
                    animationDuration: 1000,
                    lineHeight: 20.0,
                    leading: new Text("Rimangono " +
                        ((animal.dailyRation - animal.availableRation).abs())
                            .toString()),
                    trailing: new Text(animal.dailyRation.toString()),
                    percent: (1 - animal.availableRation / animal.dailyRation),
                    center: Text(
                        ((1 - animal.availableRation / animal.dailyRation) *
                                    100)
                                .round()
                                .toString() +
                            "%",
                        style: TextStyle(color: Colors.white)),
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.grey[900],
                  ),*/
                ),
              ],
            )),
      ),
    );
  }
}
