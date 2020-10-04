import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/authentication/authentication.dart';
import 'package:appetito/src/pages/authentication/welcome.dart';
import 'package:appetito/src/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppPage extends StatelessWidget {
  static String tag = '/';

  @override
  Widget build(BuildContext context) {
    // Datos del usuario logeado
    final user = Provider.of<UserAppetito>(context);

    if (user == null) {
      return Authentication();
    } else {
      return HomePage();
    }
  }
}
