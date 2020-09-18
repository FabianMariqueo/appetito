import 'package:appetito/src/models/ingredient.dart';
import 'package:appetito/src/models/procedure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class Recipe {
  String name;
  String description;
  int portions;
  Timestamp preparationTime;
  List<PickedFile> imagesFiles;
  List<String> imagesURL;
  List<Ingredient> ingredients;
  List<Procedure> procedures;
}
