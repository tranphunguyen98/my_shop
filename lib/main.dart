import 'package:flutter/material.dart';
import 'package:my_shop/module/signup/signup_page.dart';

import 'module/signin/signin_page.dart';
import 'shared/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => SignInPage(),
        kSignInRoute: (context) => SignInPage(),
        kSignUpRoute: (context) => SignUpPage(),
      },
    );
  }
}
