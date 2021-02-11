import 'package:dogx_a_smart_dispenser/models/User.dart';
import 'package:dogx_a_smart_dispenser/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_convertToCustomUser);
  }

  User _convertToCustomUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //sign in with email & pwd.
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _convertToCustomUser(user);
      //return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCurrentUser() async {
    return await _auth.currentUser();
  }

  //register with email & pwd
  Future registerWithEmailAndPassword(
      String name, String surname, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(name, surname, email);
      return _convertToCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
