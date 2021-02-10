import 'package:dogx_a_smart_dispenser/models/User.dart';
import 'package:dogx_a_smart_dispenser/screens/authenticate/authenticate.dart';
import 'package:dogx_a_smart_dispenser/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
