import 'package:flutter/material.dart';

import 'package:flutter_firebase/screens/HomePage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Baby Names',
      theme: ThemeData(primaryColor: Colors.white),
      home: const HomePage(title: 'Baby Name Votes'),
    );
  }
}