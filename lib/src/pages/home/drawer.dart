import 'package:appetito/src/models/user-appetito.dart';
import 'package:flutter/material.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:appetito/src/pages/profile/profile.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/pages/home/home.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAppetito>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Nombre'),
            accountEmail: Text('email@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                "N",
                style: TextStyle(fontSize: 30),
              ),
            ),
          ),
          ListTile(
            title: Text('Inicio'),
            leading: Icon(Icons.person),
            onTap: () => Navigator.pushNamed(context, HomePage.tag),
          ),
          ListTile(
            title: Text('Mi perfil'),
            leading: Icon(Icons.person),
            onTap: () => Navigator.pushNamed(context, ProfilePage.tag),
          ),
          ListTile(
            title: Text('Mis Recetas'),
            leading: Icon(Icons.content_paste),
            onTap: () => Navigator.pushNamed(context, ProfilePage.tag),
          ),
          ListTile(
            title: Text('Recetas Guardadas'),
            leading: Icon(Icons.save),
            onTap: () => Navigator.pushNamed(context, ProfilePage.tag),
          ),
          ListTile(
            title: Text('Lista Compra'),
            leading: Icon(Icons.list),
            onTap: () => Navigator.pushNamed(context, ProfilePage.tag),
          ),
          Divider(
            thickness: 5.0,
          ),
          ListTile(
            title: Text('Cerrar Sesión'),
            leading: Icon(Icons.power_settings_new),
            onTap: () => this._authService.signOut(),
          ),
        ],
      ),
    );
  }
}
