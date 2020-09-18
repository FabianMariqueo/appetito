import 'package:appetito/src/models/user-appetito.dart';
import 'package:flutter/material.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:appetito/src/pages/profile/profile.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAppetito>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue[300],
              image: DecorationImage(
                  image: AssetImage('assets/img/drawer_img.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Text(
              user.nombre,
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.black,
              ),
            ),
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
