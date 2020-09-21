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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15.0),
              elevation: 3.0,
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: RecipeImages(listaImagenes: listaImagenes)),
                  Container(
                    child: this._createInput(
                        "Titulo",
                        "Ingrese titulo de la receta",
                        currentRecipe.name,
                        Icons.local_dining),
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Ingrese una descripcion para su receta',
                          labelText: "Descripción"),
                      onChanged: (value) => print(value),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                  Container(
                    child: this._createInput(
                        "Porciones",
                        "Cantidad de porciones",
                        currentRecipe.portions,
                        Icons.person_add),
                  ),
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
              margin: EdgeInsets.all(15.0),
              elevation: 3.0,
              child: Container(
                child: RecipeIngredients(
                  ingredientsList: currentRecipe.ingredients,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(15.0),
              elevation: 3.0,
              child: Container(
                child: RecipeProcedures(
                  proceduresList: currentRecipe.procedures,
                ),
              ),
            ),
            Container(
              child: FlatButton(
                child: Text("Send"),
                onPressed: () => {
                  this.currentRecipe.imagesFiles = this.listaImagenes,
                  //this._recipeService.addRecipe(currentRecipe)
                  this.currentRecipe.ingredients.forEach((element) {
                    print(element);
                  })
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createInput(String title, String hintText, bindData, icon) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: title,
          hintText: hintText,
          icon: Icon(icon),
        ),
        onChanged: (value) {
          setState(() {
            bindData = value;
          });
        },
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
}
