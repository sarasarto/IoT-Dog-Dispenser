import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //user collection reference

  //dispenser collection reference

  //animal dispenser reference

  //user collection reference
  //-------------GESTIONE UTENTI-----------------
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  final CollectionReference animalCollection =
      FirebaseFirestore.instance.collection('Animal');

  Future updateUserData(String name, String surname, String email) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'surname': surname, 'email': email});
  }
/*
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }*/

  //-------------GESTIONE ANIMALI-----------------

  Future updateAnimalData(String idCollar, String name, int dailyration,
      int availableRation, String userId) async {
    return await animalCollection.doc(uid).set({
      'idCollar': idCollar,
      'name': name,
      'dailyRation': dailyration,
      'availableRation': availableRation,
      'userId': userId
    });
  }

  List<Animal> _animalListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Animal(
          idCollar: doc.data()['idCollar'] ?? '',
          name: doc.data()['name'] ?? '',
          dailyRation: doc.data()['dailyRation'] ?? -1,
          availableRation: doc.data()['availableRation'] ?? -1,
          userId: doc.data()['userId'] ?? '');
    }).toList();
  }

  Stream<List<Animal>> get animals {
    return animalCollection.snapshots().map(_animalListFromSnapshot);
  }
}
