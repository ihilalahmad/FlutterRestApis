import 'package:flutter/material.dart';
import 'package:flutter_rest_apis/screens/home_screen.dart';
import 'package:flutter_rest_apis/screens/photos_screen.dart';
import 'package:flutter_rest_apis/screens/user_screen.dart';
import 'package:flutter_rest_apis/screens/user_screen_without_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserScreenWithoutModel(),
    );
  }
}
