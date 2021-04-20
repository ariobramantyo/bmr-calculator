import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xfff9f9fa),
          primaryColor: Colors.amber,
          accentColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
