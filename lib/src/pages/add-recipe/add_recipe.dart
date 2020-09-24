import 'package:appetito/src/models/recipe.dart';
import 'package:appetito/src/pages/add-recipe/recipe_images.dart';
import 'package:appetito/src/pages/add-recipe/recipe_ingredients.dart';
import 'package:appetito/src/pages/add-recipe/recipe_procedures.dart';
import 'package:appetito/src/services/recipe-service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class AddRecipePage extends StatefulWidget {
  static String tag = "add_recipe";

  @override
  _AddRecipePage createState() => _AddRecipePage();
}

class _AddRecipePage extends State<AddRecipePage> {
  Recipe currentRecipe = Recipe(ingredients: [""], procedures: [""]);
  Future<PickedFile> file;
  String status = '';
  String base64Image;
  PickedFile tmpFile;
  String errMessage = 'Error Uploading Image';
  // Lista de images de la receta
  List<Future<PickedFile>> listaImagenes = [];
  RecipeService _recipeService = RecipeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Receta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.all(20.0),
              elevation: 3.0,
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: RecipeImages(listaImagenes: listaImagenes)),
                  Container(child: this._recipeTitleInput()),
                  Container(child: this._recipeDescription()),
                  //_recipeDetails(),
                  Container(child: this._recipePortionsInput()),
                  Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Tiempo de preparación:',
                            style: TextStyle(color: Colors.black87),
                          ),
                          _timeInput(),
                        ],
                      )),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.all(20.0),
              elevation: 3.0,
              child: Container(
                child: RecipeIngredients(
                  ingredientsList: currentRecipe.ingredients,
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.all(20.0),
              elevation: 3.0,
              child: Container(
                child: RecipeProcedures(
                  proceduresList: currentRecipe.procedures,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 20.0, left: 20.0, right: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                color: Colors.amber[600],
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: 250,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.send),
                      SizedBox(width: 5),
                      const Text('Guardar Receta',
                          style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ),
                onPressed: () => {
                  this.currentRecipe.imagesFiles = this.listaImagenes,
                  this._recipeService.addRecipe(currentRecipe)
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recipeTitleInput() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          autofocus: false,
          style: TextStyle(fontSize: 15.0, color: Colors.grey),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: "Nombre de la receta",
            //hintText: "Nombre de la receta",
            icon: Icon(Icons.local_dining),
            isDense: true,
          ),
          onChanged: (value) {
            setState(() {
              currentRecipe.name = value;
            });
          },
        ),
      ),
    );
  }

  Widget _recipePortionsInput() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: TextFormField(
          keyboardType: TextInputType.number,
          autofocus: false,
          style: TextStyle(fontSize: 15.0, color: Colors.grey),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: "Porciones",
            //hintText: "Cantidad de raciones",
            icon: Icon(Icons.person_add),
            isDense: true,
          ),
          onChanged: (value) {
            setState(() {
              currentRecipe.portions = int.parse(value);
            });
          },
        ),
      ),
    );
  }

  Widget _recipeDescription() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        child: TextFormField(
          autofocus: false,
          style: TextStyle(fontSize: 15.0, color: Colors.grey),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: 'Ingrese una descripcion para su receta',
            labelText: "Descripción de la receta",
            icon: Icon(Icons.chat),
            isDense: true,
          ),
          onChanged: (value) => {currentRecipe.description = value},
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ),
    );
  }

  Widget _timeInput() {
    return FlatButton(
        onPressed: () {
          DatePicker.showTimePicker(context, showTitleActions: true,
              onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            print('confirm $date');
            setState(() {
              currentRecipe.preparationTime = date;
            });
          },
              currentTime: DateTime.parse("0000-00-00 00:00:00"),
              locale: LocaleType.es);
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.amber[700]),
          child: currentRecipe.preparationTime != null
              ? Text(
                  DateFormat("HH:mm:ss").format(currentRecipe.preparationTime))
              : Icon(Icons.watch_later),
        ));
  }

  Widget _recipeDetails() {
    return Row(
      children: <Widget>[
        _timeInput(),
        SizedBox(
          width: 5,
        ),
        Text('|'),
        SizedBox(
          width: 5,
        ),
        _recipePortionsInput(),
      ],
    );
  }
}
