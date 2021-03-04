import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/style/colors.dart' as Style;
import 'package:flutter_app/utils/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MegaTrust',
      initialRoute: LoginScreen.routeName,
      routes: routes,
      theme: ThemeData(
        primaryColor: Style.Colors.primaryColor,
        primaryColorDark: Style.Colors.primaryDarkColor,
        accentColor: Style.Colors.accentColor,
      ),
    );
  }
}
