import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/add-recipe/add_recipe.dart';
import 'package:appetito/src/pages/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String tag = '/home';  

  @override
  Widget build(BuildContext context) {
     // Datos del usuario logeado
    final user = Provider.of<UserAppetito>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Appettito'),
        ),
        drawer: DrawerPage(),
        body: Column(children: [
          Text(user.nombre),
          _addButton(context)]));
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
