import 'package:flutter/material.dart';

import 'package:appetito/src/pages/home/drawer.dart';

class HomePage extends StatelessWidget {
  static String tag = '/home';

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
