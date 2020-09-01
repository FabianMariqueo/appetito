
import 'package:appetito/src/pages/add-recipe/add_recipe.dart';
import 'package:flutter/material.dart';

import 'package:appetito/src/pages/app.dart';
import 'package:appetito/src/pages/profile/profile.dart';
import 'package:appetito/src/pages/authentication/sign_in.dart';
import 'package:appetito/src/pages/authentication/sign_up.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    AppPage.tag: (context) => AppPage(),
    SignInPage.tag: (context) => SignInPage(),
    SignUpPage.tag: (context) => SignUpPage(),
    ProfilePage.tag: (context) => ProfilePage(),
    AddRecipePage.tag: (context) => AddRecipePage()
  };
}
