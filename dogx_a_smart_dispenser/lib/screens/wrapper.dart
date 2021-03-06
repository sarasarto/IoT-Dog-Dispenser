import 'package:dogx_a_smart_dispenser/models/CustomUser.dart';
import 'package:dogx_a_smart_dispenser/screens/authenticate/sign_in.dart';
import 'package:dogx_a_smart_dispenser/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    //return either home or authenticate widget
    if (user == null) {
      return SignIn();
    } else {
      return Home();
    }
  }
}
