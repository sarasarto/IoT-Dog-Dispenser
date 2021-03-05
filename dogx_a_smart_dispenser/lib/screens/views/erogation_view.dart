import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/views/erogation_page.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErogationView extends StatefulWidget {
  final Dispenser dispenser;
  
  final ValueChanged<int> onPush;
  ErogationView({this.dispenser, this.onPush});

  @override
  _ErogationViewState createState() => _ErogationViewState();
}

class _ErogationViewState extends State<ErogationView> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Animal>>.value(
      value: DatabaseService().animals,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Eroga dal tuo dispenser'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        body: ErogationPage(dispenser: widget.dispenser),
      ),
    );
  }
}
