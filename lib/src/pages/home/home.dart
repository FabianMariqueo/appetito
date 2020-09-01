import 'package:appetito/src/services/auth.dart';
import 'package:flutter/material.dart';

import 'package:appetito/src/pages/home/drawer.dart';

class HomePage extends StatelessWidget {
  static String tag = '/home';

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appettito'),
      ),
      drawer: DrawerPage(),
      body: Text("Pataata"),
    );
  }
}
