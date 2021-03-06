import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:flutter/material.dart';


class DispenserTile extends StatelessWidget {
  final Dispenser dispenser;
  //final List<Animal> animals;
  DispenserTile({this.dispenser /*, this.animals*/});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.black)),
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(dispenser.id,
          style: TextStyle(fontSize: 22),),
          //subtitle: Text(dispenser.userId),
          onTap: () {
            print(dispenser.id);
            print("collare: " + dispenser.collarId.toString());
            print("qnt : " + dispenser.qtnRation.toString());
            print(dispenser.userId);
           
          },
        ),
      ),
    );
  }
}