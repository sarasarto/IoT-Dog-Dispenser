import 'package:dogx_a_smart_dispenser/models/Animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dogx_a_smart_dispenser/models/Dispenser.dart';
import 'package:dogx_a_smart_dispenser/services/auth.dart';

class DatabaseService {
  final _authService = AuthService();

  //user collection reference

  //dispenser collection reference

  //animal dispenser reference

  //user collection reference
  //-------------GESTIONE UTENTI-----------------
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  final CollectionReference animalCollection =
      FirebaseFirestore.instance.collection('Animal');

  final CollectionReference dispenserCollection =
      FirebaseFirestore.instance.collection('Dispenser');

  final CollectionReference programmedErogationCollection =
      FirebaseFirestore.instance.collection('Programmed Erogation');

  Future updateUser(
      String uid, String name, String surname, String email) async {
    return await userCollection
        .doc(uid)
        .set({'name': name, 'surname': surname, 'email': email});
  }

  //-------------GESTIONE ANIMALI-----------------
  Future addAnimal(
      String name, int dailyRation, int availableRation, String userId) async {
    DocumentReference docRef = await animalCollection.add({
      'collarId': null,
      'name': name,
      'dailyRation': dailyRation,
      'availableRation': availableRation,
      'userId': userId,
      'foodCounter': 0
    });

    await docRef.update({'collarId': docRef.id});
  }

  Future updateAnimal(String collarId, String name, int dailyRation,
      int availableRation, String userId, int foodCounter) async {
    return await animalCollection.doc(collarId).set({
      'collarId': collarId,
      'name': name,
      'dailyRation': dailyRation,
      'availableRation': availableRation,
      'userId': userId,
      'foodCounter': foodCounter
    });
  }

  Future deleteAnimal(String collarId) async {
    await animalCollection.doc(collarId).delete();
  }

  List<Animal> _animalListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Animal(
          collarId: doc.data()['collarId'] ?? '',
          name: doc.data()['name'] ?? '',
          dailyRation: doc.data()['dailyRation'] ?? -1,
          availableRation: doc.data()['availableRation'] ?? -1,
          userId: doc.data()['userId'] ?? '',
          foodCounter: doc.data()['foodCounter'] ?? 0);
    }).toList();
  }

  Stream<List<Animal>> get animals {
    String uid = _authService.getCurrentUserUid();
    return animalCollection
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map(_animalListFromSnapshot);
  }

  //--------------GESTIONE DISPENSER-----------------
  List<Dispenser> _dispenserListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Dispenser(
        id: doc.data()['Id'] ?? '',
        userId: doc.data()['userId'] ?? '',
        qtnRation: doc.data()['qtnRation'] ?? '',
        collarId: doc.data()['collarId'] ?? null,
        foodState: doc.data()['food_state'] ?? true,
        //foodState: doc.data()['food_state'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Dispenser>> get dispensers {
    String uid = _authService.getCurrentUserUid();
    return dispenserCollection
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map(_dispenserListFromSnapshot);
  }

  Stream<DocumentSnapshot> get animal {
    return animalCollection.doc().snapshots();
  }

  Future addDispenser(
      String id, String userId, int qtnRation, String collarId) async {
    //DocumentReference docRef = await dispenserCollection
    return await dispenserCollection.doc(id).set({
      'Id': id,
      'userId': userId,
      'qtnRation': qtnRation,
      'collarId': collarId,
      //'food_state': 0
      'food_state': true 
    });

    // await docRef.update({'Id': docRef.id});
  }

  Future deleteDispenser(String id) async {
    await dispenserCollection.doc(id).delete();
  }

  Future updateDispenser(String id, int qtnRation, String collarId) async {
    return await dispenserCollection.doc(id).update({
      'qtnRation': qtnRation,
      'collarId': collarId,
    });
  }

  Future addProgrammedErogation(String dispenserId, String collarId,
      int qtnRation, String date, String time) async {
    //DocumentReference docRef = await dispenserCollection
    return await programmedErogationCollection.doc().set({
      'dispenserId': dispenserId,
      'collarId': collarId,
      'qtnRation': qtnRation,
      'date': date,
      'time': time
    });
  }
}
