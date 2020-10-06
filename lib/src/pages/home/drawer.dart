import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/app.dart';
import 'package:appetito/src/pages/home/home.dart';
import 'package:appetito/src/pages/profile/profile.dart';
import 'package:appetito/src/pages/recipes/my_recipes.dart';
import 'package:appetito/src/pages/recipes/saved_recipes.dart';
import 'package:appetito/src/services/auth.dart';
import 'package:appetito/src/services/user-service.dart';
import 'package:appetito/src/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAppetito>(context);
    return Drawer(
      child: ListView(
        children: <Widget>[
          user != null
              ? UserAccountsDrawerHeader(
                  accountName: Text(user.name ?? ""),
                  accountEmail: Text(user.email),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: user.photoURL != null
                        ? NetworkImage(user.photoURL)
                        : null,
                    child: user.photoURL == null
                        ? Text(
                            "${user.email.substring(0, 1)}".toUpperCase(),
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          )
                        : null,
                  ),
                )
              : Text(""),
          ListTile(
            title: Text('Inicio'),
            leading: Icon(Icons.home),
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
            onTap: () => Navigator.pushNamed(context, MyRecipesPage.tag),
          ),
          ListTile(
            title: Text('Recetas Guardadas'),
            leading: Icon(Icons.save),
            onTap: () => Navigator.pushNamed(context, SavedRecipesPage.tag),
          ),
          Divider(
            thickness: 5.0,
          ),
          ListTile(
            title: Text('Cerrar Sesión'),
            leading: Icon(Icons.power_settings_new),
            onTap: () => {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppPage.tag, (route) => false),
              this._authService.signOut()
            },
          ),
        ],
      ),
    );
  }

  Widget _userDetails(UserAppetito user) {
    return FutureBuilder(
        future: UserService().getUser(user.uid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return Text('usuario nulo');
            } else {
              UserAppetito userDetails = snapshot.data as UserAppetito;
              return UserAccountsDrawerHeader(
                accountName: Text(userDetails.name),
                accountEmail: Text(userDetails.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: userDetails.photoURL != null
                      ? NetworkImage(userDetails.photoURL)
                      : null,
                  child: userDetails.photoURL == null
                      ? Text(
                          "${user.email.substring(0, 1)}".toUpperCase(),
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        )
                      : null,
                ),
              );
            }
          }
          return UserAccountsDrawerHeader(
            accountName: Text(user.email.substring(0, user.email.indexOf('@'))),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                "${user.email.substring(0, 1)}".toUpperCase(),
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          );
        });
  }
}
