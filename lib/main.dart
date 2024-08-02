import 'package:basket_ball_api_app/Pages/homePage.dart';
import 'package:basket_ball_api_app/Pages/players.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        "/home": (context)=>HomePage(),
        "/players": (context)=>Players(),
      },
    );
  }
}
