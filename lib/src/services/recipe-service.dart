import 'dart:io';

import 'package:appetito/src/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class RecipeService {
  addRecipe(Recipe recipe) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    recipe.userId = firebaseUser.uid;
    if (recipe.imagesFiles != null) {
      recipe.imagesURL = await saveImages(recipe.imagesFiles, recipe.userId);
    }

    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("recipe").add(recipe.toJson()).then((value) {
      print(value.path);
    });
  }

  saveImages(List<Future<PickedFile>> images, String userId) async {
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

  fetchAll() {}

  getById() {}
}
