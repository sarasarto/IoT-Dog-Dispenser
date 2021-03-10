import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:dogx_a_smart_dispenser/screens/forms/add_form.dart';
import 'package:dogx_a_smart_dispenser/screens/list_views/animal_list.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authService = AuthService();

    final CollectionReference notificheCollection =
        FirebaseFirestore.instance.collection('Notifiche');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notifiche', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: notificheCollection
            .where('user_id', isEqualTo: _authService.getCurrentUserUid())
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Container(
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Card(
                    color: Colors.black12,
                    margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                    child: ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return new ListTile(
                          title: new Text(document.data()['dispenserId']),
                          subtitle: new Text(
                              "Attenzione!! stai finendo i croccantini"),
                        );
                      }).toList(),
                    ))),
          );
        },
      ),
    );
  }
}
