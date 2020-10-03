import 'package:appetito/src/models/user-appetito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  /// Instancia de firestore
  final _firestoreInstance = FirebaseFirestore.instance;

  /// Agregar un nuevo usuario
  Future<User> addUser(UserAppetito user) async {
    try {
      await this._firestoreInstance.doc("user/${user.uid}").set(user.toJson());
    } catch (_) {
      return null;
    }
  }

  /// Verifica si el existe un registro para el usuario seleccionado
  Future<bool> existByUid(String uid) async {
    try {
      DocumentSnapshot userSnap =
          await this._firestoreInstance.doc("user/$uid").get();
      return userSnap.exists;
    } catch (_) {
      return null;
    }
  }

  /// Obtener los datos de un usuario por el uid
  Future<UserAppetito> getUser(String uid) async {
    try {
      DocumentSnapshot userSnap =
          await this._firestoreInstance.doc("user/$uid").get();
      return UserAppetito.fromJson(userSnap.data());
    } catch (_) {
      return null;
    }
  }
}
