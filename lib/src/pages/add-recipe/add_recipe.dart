
import 'package:appetito/src/pages/add-recipe/recipe_images.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipePage extends StatefulWidget {
  static String tag = "add_recipe";

  @override
  _AddRecipePage createState() => _AddRecipePage();
}

class _AddRecipePage extends State<AddRecipePage> {
  Future<PickedFile> file;
  String status = '';
  String base64Image;
  PickedFile tmpFile;
  String errMessage = 'Error Uploading Image';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Receta'),
      ),
      body: Container(padding: EdgeInsets.all(30.0), child: RecipeImages()),
    );
  }
}
