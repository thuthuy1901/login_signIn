import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/screen/splash_screen.dart';

void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: colorApp.Primary.color,
        body: SplashScreen(),
      ),
    );
  }
}
