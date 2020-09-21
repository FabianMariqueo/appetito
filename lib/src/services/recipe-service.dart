import 'package:appetito/src/models/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  addRecipe(Recipe recipe) async {
    //var firebaseUser = await FirebaseAuth.instance.currentUser;

    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("recipe").add(recipe.toJson()).then((value) {
      print(value.path);
    });
  }

  fetchAll() {}

  getById() {}
}
