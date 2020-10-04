import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/services/user-service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Authentication de firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = new GoogleSignIn(scopes: ['email']);

  // Function to get user from firebase object
  UserAppetito _userFromFirebase(User user) {
    return user != null
        ? UserAppetito(
            uid: user.uid,
            name: user.displayName,
            email: user.email,
            photoURL: user.photoURL)
        : null;
  }

  Stream<UserAppetito> get user {
    return UserService().getUser(this._auth.currentUser.uid).asStream();
  }

  Stream<User> get authState {
    return this._auth.authStateChanges();
  }

  /// Ingresar como usuario anonimo
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// Login With Email and Password
  Future signInWithEmailAndPassword(UserAppetito user) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      return _userFromFirebase(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      UserCredential result = await _auth.signInWithCredential(credential);
      if (!await UserService().existByUid(result.user.uid)) {
        return UserService().addUser(await _userFromFirebase(result.user));
      }
      return _userFromFirebase(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// Registrar con email y password
  Future registerWithEmailAndPassword(UserAppetito user) async {
    try {
      user.name = user.email.split("@")[0];
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      user.uid = result.user.uid;
      UserService().addUser(user);
      return _userFromFirebase(result.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// Cerrar la sesion
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
