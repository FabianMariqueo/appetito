import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/authentication/authentication.dart';
import 'package:appetito/src/pages/home/home.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppPage extends StatelessWidget {
  static String tag = '/';

  @override
  Widget build(BuildContext context) {
    // Datos del usuario logeado
    final authUser = Provider.of<User>(context);

    if (authUser == null) {
      return Authentication();
    } else {
      return StreamProvider<UserAppetito>.value(
          value: AuthService().user, child: HomePage());
    }
  }
}
