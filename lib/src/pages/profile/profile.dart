import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/add-recipe/add_recipe.dart';
import 'package:appetito/src/pages/recipes/recipe.dart';
import 'package:appetito/src/pages/profile/edit_profile.dart';
import 'package:appetito/src/pages/home/drawer.dart';

class ProfilePage extends StatelessWidget {
  static String tag = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Perfil',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      drawer: DrawerPage(),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            _infoUsuario(context),
            _listaRecetas(context),
            _listaRecetas(context),
            _listaRecetas(context),
          ],
        ),
      ),
      floatingActionButton: _addButton(context),
    );
  }

  Widget _addButton(BuildContext context) {
    return FloatingActionButton(
      splashColor: Colors.amberAccent,
      onPressed: () {
        Navigator.pushNamed(context, AddRecipePage.tag);
      },
      child: Icon(Icons.add),
    );
  }

  Widget _listaRecetas(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, RecipePage.tag);
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage("assets/img/drawer_img.jpg"),
                fit: BoxFit.cover,
                width: Width,
                height: 100,
              ),
              ListTile(
                //leading: Icon(Icons.edit),
                title: _titulo("Nombre de la receta"),
                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.timer),
                    SizedBox(
                      width: 5,
                    ),
                    _descripcion("Minutos"),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.local_dining),
                    SizedBox(
                      width: 5,
                    ),
                    _descripcion("Porciones")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editarPerfil(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, EditProfilePage.tag);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.amber,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.edit),
            SizedBox(width: 5),
            const Text('Editar perfil', style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }

  Widget _infoUsuario(BuildContext context) {
    final user = Provider.of<UserAppetito>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.blue,
            child: Text(
              "${user.email.substring(0, 1)}".toUpperCase(),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _estilonombre(user.email.substring(0, user.email.indexOf('@'))),
              _estilodescripcion("usuario de appetito"),
              _editarPerfil(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _estilonombre(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        titulo,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _estilodescripcion(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        titulo,
        style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _titulo(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        titulo,
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _descripcion(String descripcion) {
    return Text(
      descripcion,
      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
    );
  }
}
