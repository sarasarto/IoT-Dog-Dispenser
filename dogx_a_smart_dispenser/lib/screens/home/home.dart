import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:dogx_a_smart_dispenser/screens/tab_navigation_dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/views/animal_view.dart';
import 'package:dogx_a_smart_dispenser/screens/views/dispenser_view.dart';
import 'package:dogx_a_smart_dispenser/screens/views/profile_view.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:flutter/material.dart';
import 'dashboard.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

//0: home
//1: dispenser
//2: animali
//3: profilo
List tabs = [0, 1, 2, 3];
Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
  tabs[1]: GlobalKey<NavigatorState>(),
};

class HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  /*String currentPage;
  int currentIndex;

  List<String> pageKeys = ["Home", "Dispenser", "Animali", "Account"];



  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  final AuthService _authService = AuthService();

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void seelctTab(String tabItem, int index) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('DogX', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Logout'),
            onPressed: () async {
              await _authService.signOut();
            },
          )
        ],
      ),

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
        opacity: 0.2,
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
        currentIndex: currentIndex,
        hasInk: true,
        inkColor: Colors.black12,
        hasNotch: true,
        //fabLocation: BubbleBottomBarFabLocation.end,
        onTap: changePage,
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
        ],
      ),
      body: (currentIndex == 0)
          ? Icon(
              Icons.dashboard,
              size: 150.0,
              color: Colors.black,
            )
          : (currentIndex == 1)
              ? Icon(
                  Icons.folder_open,
                  size: 150.0,
                  color: Colors.indigo,
                )
              : Icon(
                  Icons.access_time,
                  size: 150.0,
                  color: Colors.deepPurple,
                ),
    );
  }*/

  int currentTab = tabs[0];

  void _selectTab(int tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  Widget _buildBody() {
    if (currentTab == 0) {
      return Icon(
        Icons.home,
        size: 150.0,
        color: Colors.black,
      );
    } else {
      if (currentTab == 1) {
        return DispenserView();
      } else {
        if (currentTab == 2) {
          return AnimalView();
        } else {
          return ProfileView();
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

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigation(
        currentTab: currentTab,
        onSelectTab: _selectTab,
      ),
    );*/

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('DogX', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),

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
          opacity: 0.2,
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
          ),
          currentIndex: currentTab,
          hasInk: true,
          inkColor: Colors.black12,
          hasNotch: true,
          //fabLocation: BubbleBottomBarFabLocation.end,
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
          ],
        ),
        body:
            /*(currentTab == 0)
          ? Icon(
              Icons.dashboard,
              size: 150.0,
              color: Colors.black,
            )
          : (currentTab == 1)
              ? Icon(
                  Icons.folder_open,
                  size: 150.0,
                  color: Colors.indigo,
                )
              : Icon(
                  Icons.access_time,
                  size: 150.0,
                  color: Colors.deepPurple,
                ),*/
            _buildBody());
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
