import 'package:appetito/src/pages/add-recipe/add_recipe.dart';
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
        body: _addButton(context));
  }

  Widget _addButton(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddRecipePage.tag);
                },
                child: Icon(Icons.add))));
  }
}
