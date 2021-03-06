import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:dogx_a_smart_dispenser/screens/views/animal_view.dart';
import 'package:dogx_a_smart_dispenser/screens/views/dispenser_view.dart';
import 'package:dogx_a_smart_dispenser/screens/views/home_view.dart';
import 'package:dogx_a_smart_dispenser/screens/views/notification_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

//0: home
//1: dispenser
//2: animali
//3: notifiche
List tabs = [0, 1, 2, 3];
Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
  tabs[1]: GlobalKey<NavigatorState>(),
};

class HomeState extends State<Home> {
  int currentTab = tabs[0];

  void _selectTab(int tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  Widget _buildBody() {
    if (currentTab == 0) {
      return HomeView();
    } else {
      if (currentTab == 1) {
        return DispenserView();
      } else {
        if (currentTab == 2) {
          return AnimalView();
        } else {
          if (currentTab == 3) {
            return NotificationView();
          }
        }
      }
    }
  }

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[currentTab].currentState.maybePop(),
      child: Scaffold(
          bottomNavigationBar: BubbleBottomBar(
            opacity: 0.0,
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
            currentIndex: currentTab,
            hasInk: false,
            inkColor: Colors.black,
            hasNotch: true,
            onTap: _selectTab,
            items: [
              BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title: Text('Home'),
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.dock,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.dock,
                  color: Colors.black,
                ),
                title: Text('Dispenser'),
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.pets,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.pets,
                  color: Colors.black,
                ),
                title: Text('Animali'),
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(Icons.notifications, color: Colors.black),
                activeIcon: Icon(
                  Icons.notifications,
                  color: Colors.black,
                ),
                title: Text('Notifiche'),
              ),
              /* BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text('Account'),
              ),*/
            ],
          ),
          body: _buildBody()),
    );
  }
}
