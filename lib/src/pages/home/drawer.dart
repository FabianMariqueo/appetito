import 'package:flutter/material.dart';
import 'package:appetito/src/utils/hex_to_color_util.dart';
import 'package:appetito/src/pages/profile/profile.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              'Mi super usuario',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.black,
              ),
            ),
          ),
          ListTile(
            title: Text('Mis Recetas'),
            leading: Icon(Icons.perm_contact_calendar),
            onTap: () => Navigator.pushNamed(context, ProfilePage.tag),
          ),
          ListTile(
            title: Text('Recetas Guardadas'),
            leading: Icon(Icons.perm_contact_calendar),
            onTap: () => Navigator.pushNamed(context, ProfilePage.tag),
          ),
          ListTile(
            title: Text('Lista Compra'),
            leading: Icon(Icons.perm_contact_calendar),
            onTap: () => Navigator.pushNamed(context, ProfilePage.tag),
          ),
          ListTile(
            title: Text('Cerrar Sesión'),
            leading: Icon(Icons.perm_contact_calendar),
            onTap: () => Navigator.pushNamed(context, ProfilePage.tag),
          ),
        ],
      ),
    );
  }
}
