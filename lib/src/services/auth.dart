import 'package:appetito/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Authentication de firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to get user from firebase object
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn() async {}
}
