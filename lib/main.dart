import 'package:flutter/material.dart';
import 'package:todo_app/views/splash_screen.dart';

void main() {
  runApp(const Initial());
}

class Initial extends StatelessWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Nunito Sans'
        ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
