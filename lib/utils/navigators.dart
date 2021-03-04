import 'package:flutter/material.dart';

void pushName(BuildContext context, String route) {
  Navigator.of(context).pushNamed(route);
}