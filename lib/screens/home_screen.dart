import 'package:flutter_app/style/colors.dart' as Style;
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.accentColor,
        centerTitle: true,
        title: Text(
          'Home Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
