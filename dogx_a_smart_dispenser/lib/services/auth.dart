import 'package:dogx_a_smart_dispenser/models/User.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_convertToCustomUser);
  }

  User _convertToCustomUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //sign in anonim
  //NB: bisogna aver attivato il login anonimo dalla console firebase
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _convertToCustomUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & pwd.

  //register with email & pwd

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
