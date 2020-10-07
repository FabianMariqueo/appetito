import 'package:appetito/src/models/recipe.dart';
import 'package:appetito/src/models/user-appetito.dart';
import 'package:appetito/src/pages/add-recipe/add_recipe.dart';
import 'package:appetito/src/pages/home/drawer.dart';
import 'package:appetito/src/pages/recipes/recipe.dart';
import 'package:appetito/src/pages/recipes/recipes_category.dart';
import 'package:appetito/src/services/recipe-service.dart';
import 'package:appetito/src/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  static String tag = '/home';

  /// Servicio para hacer consiultas a firebase
  final RecipeService _recipeService = new RecipeService();

  @override
  Widget build(BuildContext context) {
    /// Datos del usuario logeado
    final user = Provider.of<UserAppetito>(context);

    return Scaffold(
      appBar: AppBar(
        title: _titulohome(),
      ),
      drawer: DrawerPage(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: ListView(
              children: <Widget>[
                _titulo('Última receta publicada'),
                _ultimaReceta(context),
                _titulo('Categorías'),
                _categoriasRecetas(context),
              ],
            ),
          ),
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

  Widget _titulohome() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: Image.asset(
              'assets/img/logo titulo.png',
              height: 120,
              width: 120,
            ),
          ),
        ),
        Icon(Icons.search),
      ],
    );
  }

  Widget _ultimaReceta(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: this._recipeService.getLastPosted(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Recipe recipe = snapshot.data as Recipe;
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipePage(
                          title: recipe.name,
                        ),
                      ));
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
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            //print(recipe.name);
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
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
                        title: _tituloreceta(recipe.name),
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
            );
          }

          return Loading();
        });
  }

  Widget _titulo(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        titulo,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _categoriasRecetas(BuildContext context) {
    return new GridView.count(
      primary: false,
      //padding: const EdgeInsets.all(0),
      crossAxisCount: 2, //cantidad de columnas
      childAspectRatio: 1, //proporcion de tamaño del item
      mainAxisSpacing: 5, //espaciado horizontal
      crossAxisSpacing: 5, //espaciado vertical
      children: <Widget>[
        _categoria(context, 'Sopas y caldos', 'assets/img/caldos.jpg'),
        _categoria(context, 'Aves y carnes', 'assets/img/carnes.jpg'),
        _categoria(context, 'Repostería', 'assets/img/reposteria.jpg'),
        _categoria(context, 'Panes y masas', 'assets/img/pan.jpg'),
      ], //new Cards()
      shrinkWrap: true,
    );
  }

  Widget _categoria(
      BuildContext context, String nombrecategoria, String fotocategoria) {
    double Width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Image(
            image: AssetImage(fotocategoria),
            fit: BoxFit.cover,
            width: Width / 2,
            height: Width / 2,
            color: Colors.black38,
            colorBlendMode: BlendMode.multiply,
            //Text(nombrecategoria),
          ),
        ),
        InkWell(
          //para poder hacer tap en la categoria
          onTap: () {
            print(nombrecategoria);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipesCategory(
                    title: nombrecategoria,
                    category: nombrecategoria,
                  ),
                ));
          },
          child: Container(
              alignment: Alignment.center,
              child: Text(
                nombrecategoria,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              )),
        ),
      ],
    );
  }

  Widget _descripcion(String descripcion) {
    return Text(
      descripcion,
      style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
    );
  }

  Widget _tituloreceta(String titulo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Text(
        titulo,
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
