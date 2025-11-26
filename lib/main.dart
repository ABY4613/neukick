import 'package:flutter/material.dart';
import 'package:shoe_store/view/home_screen/bottomnavigation/home_page.dart';
import 'package:shoe_store/view/home_screen/homescreen.dart';
import 'package:shoe_store/view/auth/welcome_screen/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Homescreen(),
      ),
    );
  }
}