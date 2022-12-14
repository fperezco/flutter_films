import 'package:flutter/material.dart';
import 'package:flutter_films/src/pages/film_details.dart';
import 'package:flutter_films/src/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Films app',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'details' : (BuildContext context) => FilmDetails(),
      },
    );
  }
}