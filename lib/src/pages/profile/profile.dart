import 'package:appetito/src/models/recipe.dart';
import 'package:appetito/src/services/recipe-service.dart';
import 'package:appetito/src/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/add-recipe/add_recipe.dart';
import 'package:appetito/src/pages/recipes/recipe.dart';
import 'package:appetito/src/pages/profile/edit_profile.dart';
import 'package:appetito/src/pages/home/drawer.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  static String tag = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  RecipeService _recipeService = RecipeService();

  ///  Recetas guardadas
  List<Recipe> _recipes = [];

  /// Indicador para notificar cuando se terminaron de cargar las recetas
  bool _loadingRecipes = false;
  @override
  void initState() {
    this._loadingRecipes = true;
    super.initState();
    this._recipeService.myRecipes().then((response) => {
          this._recipes = response,
          this._loadingRecipes = false,
          setState(() {})
        });
  }

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
      body: RefreshIndicator(
        child: ListView(
          children: <Widget>[_infoUsuario(context), ..._listaRecetas(context)],
        ),
        onRefresh: () => onRefreshList(),
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

  List<Widget> _listaRecetas(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Widget> listWidget = [];
    if (this._loadingRecipes) {
      return [Loading()];
    }
    for (Recipe recipe in this._recipes) {
      listWidget.add(Padding(
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
                FutureBuilder<String>(
                    future: this._recipeService.getImageUrl(
                        recipe.imagesURL.length > 0
                            ? recipe.imagesURL[0]
                            : null),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null) {
                        return Image(
                          image: NetworkImage(snapshot.data),
                          fit: BoxFit.cover,
                          width: width,
                          height: 100,
                        );
                      }

                      return Image(
                        image: AssetImage("assets/img/image_default.png"),
                        fit: BoxFit.cover,
                        width: width,
                        height: 100,
                      );
                    }),
                ListTile(
                  //leading: Icon(Icons.edit),
                  title: _titulo(recipe.name),
                  subtitle: Row(
                    children: <Widget>[
                      Icon(Icons.timer),
                      SizedBox(
                        width: 5,
                      ),
                      _descripcion(
                          "${DateFormat("HH:mm:ss").format(recipe.preparationTime)} Minutos"),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.local_dining),
                      SizedBox(
                        width: 5,
                      ),
                      _descripcion("${recipe.portions} Porciones")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ));
    }
    return listWidget;
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
              user != null ? "${user.email.substring(0, 1)}".toUpperCase() : "",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              user != null
                  ? _estilonombre(
                      user.email.substring(0, user.email.indexOf('@')))
                  : Text(""),
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

/**
 * Refrescar los datos de las recetas
 */
  Future<void> onRefreshList() async {
    this._recipes = await this._recipeService.myRecipes();
    setState(() {});
  }
}
