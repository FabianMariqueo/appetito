import 'package:appetito/src/models/recipe.dart';
import 'package:appetito/src/pages/add-recipe/add_recipe.dart';
import 'package:appetito/src/services/recipe-service.dart';
import 'package:appetito/src/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecipesCategory extends StatefulWidget {
  final String category;
  final String title;

  RecipesCategory({this.category, this.title});
  @override
  _RecipesCategory createState() => _RecipesCategory();
}

class _RecipesCategory extends State<RecipesCategory> {
  /// Servicio para obtener las recetas
  RecipeService _recipeService = new RecipeService();

  /// Lista de recetas
  List<Recipe> _recipes = [];

  /// Indicador cuando se encuentran cargando las recetas
  bool _loading = false;
  @override
  void initState() {
    this._loading = true;
    super.initState();
    this
        ._recipeService
        .fetchByAttribute("category", widget.category)
        .then((recipes) {
      this._recipes = recipes;
      this._loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            ..._listRecipesWidget(context),
          ],
        ),
      ),
      floatingActionButton: _addButton(context),
    );
  }

  List<Widget> _listRecipesWidget(BuildContext context) {
    if (this._loading) {
      return [Loading()];
    }

    if (this._recipes.length == 0) {
      return [
        Container(
          padding: EdgeInsets.only(top: 25),
          alignment: Alignment.center,
          child: Text('No hay recetas en la categoría "${widget.title}"'),
        )
      ];
    }
    double width = MediaQuery.of(context).size.width;
    List<Widget> listWidget = [];
    for (var recipe in this._recipes) {
      listWidget.add(Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            print(recipe.name);
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
      ));
    }

    return listWidget;
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

  Widget _tituloreceta(String titulo) {
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
