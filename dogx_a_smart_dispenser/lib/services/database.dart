import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('User');

  Future updateUserData(String name, String surname, String email) async {
    return await userCollection
        .document(uid)
        .setData({'name': name, 'surname': surname, 'email': email});
  }

  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }
}


