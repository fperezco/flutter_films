import 'package:flutter/material.dart';
import 'package:flutter_films/src/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Films app',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
      },
    );
  }
}