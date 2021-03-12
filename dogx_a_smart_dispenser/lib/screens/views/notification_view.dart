import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';

class NotificationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authService = AuthService();

    final CollectionReference notificheCollection =
        FirebaseFirestore.instance.collection('Notifiche');
    print("QUI");
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
              child: ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
            print(document.data());
            if (document.data().isNotEmpty) {
              return Container(
                  child: Column(children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                    ),
                    child: new ListTile(
                      title: new Text(document.data()['dispenserId'],
                          style:
                              TextStyle(color: Colors.black, fontSize: 20.0)),
                      subtitle: new Text(
                          "ATTENZIONE! STAI FINENDO I CROCCANTINI NEL DISPENSER",
                          style: TextStyle(fontSize: 15.0)),
                    ))
              ]));
            } else {
              return Text("non hai notifiche");
            }
          }).toList()));
        },
      ),
    );
  }
}
