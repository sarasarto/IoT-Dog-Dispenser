import 'package:dogx_a_smart_dispenser/screens/views/animal_view.dart';
import 'package:dogx_a_smart_dispenser/screens/views/dispenser_view.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Item animals = new Item(
      title: "Animali", img: "assets/calendar.png", onClickRoute: AnimalView());

  Item dispenser = new Item(
      title: "Dispenser", img: "assets/food.png", onClickRoute: DispenserView());

  @override
  Widget build(BuildContext context) {
    List<Item> myList = [animals, dispenser];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
                return Card(
                  color: Colors.brown[200],
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => data.onClickRoute));
                    },
                    child: Text(data.title),
                  ),
                );
          }).toList()),
    );
  }
}

class Item {
  String title;
  String img;
  Widget onClickRoute;
  Item({this.title, this.img, this.onClickRoute});
}

/*
return Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => data.onClickRoute));
                    },
                  ),
                
                ],
              ),
            );*/
