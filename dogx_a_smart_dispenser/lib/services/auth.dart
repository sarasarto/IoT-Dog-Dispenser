import 'package:dogx_a_smart_dispenser/models/CustomUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<CustomUser> get user {
    //return _auth.onAuthStateChanged.map(_convertToCustomUser);
    return _auth.authStateChanges().map(_convertToCustomUser);
  }

  CustomUser _convertToCustomUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  //sign in with email & pwd.
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _convertToCustomUser(user);
      //return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  String getCurrentUserUid() {
    User user = FirebaseAuth.instance.currentUser;
    return user != null ? user.uid : null;
  }

  //register with email & pwd
  Future registerWithEmailAndPassword(
      String name, String surname, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseService().updateUser(user.uid, name, surname, email);
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
