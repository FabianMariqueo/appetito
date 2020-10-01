import 'dart:io';

import 'package:appetito/src/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class RecipeService {
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseStorageInstance = FirebaseStorage.instance;

  addRecipe(Recipe recipe) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    recipe.userId = firebaseUser.uid;
    if (recipe.imagesFiles != null) {
      recipe.imagesURL = await saveImages(recipe.imagesFiles, recipe.userId);
    }

    return firestoreInstance.collection("recipe").add(recipe.toJson());
  }

  /**
   * Guardar solamente las imágenes en firebas storage
   * @return Rutas de las imágenes guardadas
   */
  Future<List<String>> saveImages(
      List<Future<PickedFile>> images, String userId) async {
    FirebaseStorage storageReference = FirebaseStorage.instance;
    List<String> imagesPath = [];
    for (var imgFuture in images) {
      var img = (await imgFuture);
      var storagePath = storageReference
          .ref()
          .child("recipeImages/$userId/${Path.basename(img.path)}");
      StorageUploadTask uploadTask = storagePath.putFile(File(img.path));
      await uploadTask.onComplete;
      print("Imagen subida");
      imagesPath.add("recipeImages/$userId/${Path.basename(img.path)}");
    }
    return imagesPath;
  }

  /**
   * Obtiene todas las recetas desde firestore (sin paginación por ahora)
   */
  Future<List<Recipe>> fetchAll() async {
    List<Recipe> recipes = [];
    // Snapchot de todas las recetas registradas
    QuerySnapshot snapRecipes =
        await firestoreInstance.collection("recipe").get();

    // Iterar cada documento de firebase para construir los objetos locales
    for (QueryDocumentSnapshot recipeDoc in snapRecipes.docs) {
      // Transformar los datos desde json a obj Recipe
      Recipe auxRecipe = Recipe.fromJson(recipeDoc.data());
      // Asignar el id del documento para poder referenciar en el futuro
      auxRecipe.id = recipeDoc.id;
      // Agregar a la lista para retornar el valor
      recipes.add(auxRecipe);
    }

    return recipes;
  }

  /**
   * Obtiene todas las recetas desde firestore (sin paginación por ahora)
   */
  Future<List<Recipe>> myRecipes() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    List<Recipe> recipes = [];
    // Snapchot de todas las recetas registradas
    QuerySnapshot snapRecipes = await firestoreInstance
        .collection("recipe")
        .where("userId", isEqualTo: firebaseUser.uid)
        .get();

    // Iterar cada documento de firebase para construir los objetos locales
    for (QueryDocumentSnapshot recipeDoc in snapRecipes.docs) {
      // Transformar los datos desde json a obj Recipe
      Recipe auxRecipe = Recipe.fromJson(recipeDoc.data());
      // Asignar el id del documento para poder referenciar en el futuro
      auxRecipe.id = recipeDoc.id;
      // Agregar a la lista para retornar el valor
      recipes.add(auxRecipe);
    }

    return recipes;
  }

  getById(String recipeId) async {
    // Snapchot de todas las recetas registradas
    DocumentSnapshot snapRecipe =
        await firestoreInstance.doc("recipe/$recipeId").get();
    return Recipe.fromJson(snapRecipe.data());
  }

  Future<String> getImageUrl(String storageUrl) async {
    var storageRef = this.firebaseStorageInstance.ref().child(storageUrl);
    try {
      var url = await storageRef.getDownloadURL();
      return url as String;
    } catch (_) {
      return null;
    }
  }
}
