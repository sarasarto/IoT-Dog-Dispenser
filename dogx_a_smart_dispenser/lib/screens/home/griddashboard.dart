import 'package:flutter/material.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Animali",
      img: "assets/calendar.png");

  Items item2 = new Items(
    title: "Dispenser",
    img: "assets/food.png",
  );
  
  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2];
    var color = Colors.brown[200];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    data.img,
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    data.title,   
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            );
          }).toList()),
    );
  }
}

class Items {
  String title;
  String img;
  Items({this.title, this.img});
}
