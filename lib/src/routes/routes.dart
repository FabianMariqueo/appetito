import 'package:flutter/material.dart';

import 'package:appetito/src/pages/app.dart';
import 'package:appetito/src/pages/profile/profile.dart';
import 'package:appetito/src/pages/sign_in/sign_in.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    AppPage.tag: (context) => AppPage(),
    SignInPage.tag: (context) => SignInPage(),
    ProfilePage.tag: (context) => ProfilePage(),
  };
}
