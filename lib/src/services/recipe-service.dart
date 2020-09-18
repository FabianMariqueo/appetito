import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeService {
  addRecipe() async {
    //var firebaseUser = await FirebaseAuth.instance.currentUser;

    final firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("users").add({
      "name": "john",
      "age": 50,
      "email": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    }).then((value) {
      print(value.path);
    });
    
  }

  fetchAll() {}

  getById() {}
}
