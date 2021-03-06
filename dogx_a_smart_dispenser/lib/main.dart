import 'package:dogx_a_smart_dispenser/models/CustomUser.dart';
import 'package:dogx_a_smart_dispenser/screens/wrapper.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
        value: AuthService().user,
        child: MaterialApp(
          theme: ThemeData(errorColor: Colors.black),
          home: Wrapper(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
