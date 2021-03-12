
  
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/screens/forms/scanner.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/dispenser_list.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';

class DispenserView extends StatelessWidget {
  final DatabaseService _dbService = DatabaseService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Dispenser>>.value(
            value: DatabaseService().dispensers),
        //StreamProvider<List<Animal>>.value(value: DatabaseService().animals)
      ],
      child: Builder(
        builder: (BuildContext context) {
          //final animals = Provider.of<List<Animal>>(context);
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text('I tuoi dispenser',
                    style: TextStyle(color: Colors.black)),
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.qr_code_scanner),
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _scannerDispenser(context);
                  }),
              body: DispenserList());
        },
      ),
    );
  }

  Future _scannerDispenser(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (c) => Scanner()));
    if (result != null) {
      _dbService.addDispenser(
          result.code, _authService.getCurrentUserUid(), 0, null);
    }
  }
}

