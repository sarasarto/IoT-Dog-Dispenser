import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/screens/forms/add_form.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimalView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showAddPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: AddForm(),
            );
          });
    }

    return StreamProvider<List<Animal>>.value(
      value: DatabaseService().animals,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('I tuoi animali', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: AnimalList(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.black,
            onPressed: () => _showAddPanel()),
      ),
    );
  }
}
