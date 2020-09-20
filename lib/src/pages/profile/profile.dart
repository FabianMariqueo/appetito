import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/models/user-appetito.dart';

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
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: ListView(
          children: <Widget>[
            _infoUsuario(context),
            Divider(),
            _listaRecetas(context),
            _listaRecetas(context),
            _listaRecetas(context),
          ],
        ),
      ),
    );
  }

  Widget _listaRecetas(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
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
              title: Text('Nombre receta 1'),
              subtitle: Text('Tiempo | Porciones'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editarPerfil() {
    return RaisedButton(
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.amber,
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
        child: const Text('Editar perfil', style: TextStyle(fontSize: 15)),
      ),
    );
  }

  Widget _infoUsuario(BuildContext context) {
    final user = Provider.of<UserAppetito>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blue,
          child: Text(
            "${user.email.substring(0, 1)}".toUpperCase(),
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              user.email.substring(0, user.email.indexOf('@')),
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              'Usuario de appetito',
              style: TextStyle(fontSize: 15.0),
            ),
            _editarPerfil(),
          ],
        ),
      ],
    );
  }
}
