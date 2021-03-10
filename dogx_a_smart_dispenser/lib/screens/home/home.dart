import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:dogx_a_smart_dispenser/screens/tab_navigation_dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/views/animal_view.dart';
import 'package:dogx_a_smart_dispenser/screens/views/home_view.dart';
import 'package:dogx_a_smart_dispenser/screens/views/profile_view.dart';
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
//3: profilo
//4: notifiche
List tabs = [0, 1, 2, 3, 4];
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
        //return DispenserView();
        return TabNavigatorDispenser(
          navigatorKey: navigatorKey,
          tabItem: currentTab,
        );
      } else {
        if (currentTab == 2) {
          return AnimalView();
        } else {
          if (currentTab == 3) {
            return ProfileView();
          } else {
            return NotificationView();
          }
        }
      }
    }
    /*return Container(
        color: TabHelper.color(TabItem.home),
        alignment: Alignment.center,
        child: FlatButton(
          child: Text(
            'PUSH',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
          onPressed: _push,
        ));*/
  }

  /*void _push() {
    Navigator.of(context).push(MaterialPageRoute(
      // we'll look at ColorDetailPage later
      builder: (context) => ColorDetailPage(
        color: TabHelper.color(TabItem.red),
        title: TabHelper.description(TabItem.red),
      ),
    ));
  }*/

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[currentTab].currentState.maybePop(),
      child: Scaffold(
          /*backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('DogX', style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),*/

          /*
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Dashboard()
          ],
        ),
      );*/

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
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: Text('Account'),
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
            ],
          ),
          body: _buildBody()),
    );
  }

  Widget _buildOffstageNavigator(int tabItem) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: TabNavigatorDispenser(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
