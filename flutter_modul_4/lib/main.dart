import 'package:flutter/material.dart';
import 'package:flutter_modul_4/pages/home_page.dart';
import 'package:flutter_modul_4/pages/item_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/item': (context) => const ItemPage(),
    },
  ));
}
