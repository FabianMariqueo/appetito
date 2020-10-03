import 'dart:io';

import 'package:appetito/src/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class RecipeService {
  final firestoreInstance = FirebaseFirestore.instance;
  final firebaseStorageInstance = FirebaseStorage.instance;

  ///Guardar la receta
  Future<Recipe> addRecipe(Recipe recipe) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    recipe.userId = firebaseUser.uid;
    recipe.createdAt = DateTime.now().millisecondsSinceEpoch;
    if (recipe.imagesFiles != null) {
      recipe.imagesURL = await saveImages(recipe.imagesFiles, recipe.userId);
    }

    try {
      // Guardar la receta en firestore
      var docRecipe =
          await firestoreInstance.collection("recipe").add(recipe.toJson());
      // Actualizar el id de la receta en firestore
      firestoreInstance
          .doc("recipe/${docRecipe.id}")
          .update({"id": docRecipe.id});
      // Actualizar el id de la receta en local
      recipe.id = docRecipe.id;
      // Retornar la receta guardada
      return recipe;
    } catch (_) {
      return null;
    }
  }

  /// Guardar solamente las imágenes en firebas storage
  /// @return Rutas de las imágenes guardadas
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

  /// Obtiene todas las recetas desde firestore (sin paginación por ahora)
  Future<List<Recipe>> fetchAll() async {
    List<Recipe> recipes = [];
    // Snapchot de todas las recetas registradas
    QuerySnapshot snapRecipes =
        await firestoreInstance.collection("recipe").get();

    // Iterar cada documento de firebase para construir los objetos locales
    for (QueryDocumentSnapshot recipeDoc in snapRecipes.docs) {
      // Transformar los datos desde json a obj Recipe y guardarlo en la lista de recetas
      recipes.add(Recipe.fromJson(recipeDoc.data()));
    }

    return recipes;
  }

  /// Obtiene todas las recetas del usuario actual desde firestore (sin paginación por ahora)
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
      // Transformar los datos desde json a obj Recipe y guardarlo en la lista de recetas
      recipes.add(Recipe.fromJson(recipeDoc.data()));
    }

    return recipes;
  }

  /// Obtiene todas las recetas según algun atributo
  /// Ejemplo: fetchByAttribute("category", "Sopas y caldos")
  Future<List<Recipe>> fetchByAttribute(String attr, String matchValue) async {
    List<Recipe> recipes = [];
    // Snapchot de todas las recetas registradas
    QuerySnapshot snapRecipes = await firestoreInstance
        .collection("recipe")
        .where(attr, isEqualTo: matchValue)
        .get();

    // Iterar cada documento de firebase para construir los objetos locales
    for (QueryDocumentSnapshot recipeDoc in snapRecipes.docs) {
      // Transformar los datos desde json a obj Recipe y guardarlo en la lista de recetas
      recipes.add(Recipe.fromJson(recipeDoc.data()));
    }

    return recipes;
  }

  /// Obtiene la receta especificando el id
  Future<Recipe> getById(String recipeId) async {
    // Snapchot de todas las recetas registradas
    DocumentSnapshot snapRecipe =
        await firestoreInstance.doc("recipe/$recipeId").get();
    return Recipe.fromJson(snapRecipe.data());
  }

  /// Obtiene la URL de descarga para la imagen especificada
  Future<String> getImageUrl(String storageUrl) async {
    var storageRef = this.firebaseStorageInstance.ref().child(storageUrl);
    try {
      var url = await storageRef.getDownloadURL();
      return url as String;
    } catch (_) {
      return null;
    }
  }

  /// Obtiene la URL de descarga para la imagen especificada
  Future<List<String>> getImagesUrls(List<String> storageUrls) async {
    List<String> downloadUrls = [];
    try {
      for (String url in storageUrls) {
        var storageRef = this.firebaseStorageInstance.ref().child(url);
        downloadUrls.add(await storageRef.getDownloadURL());
      }
      return downloadUrls;
    } catch (_) {
      return null;
    }
  }
}
