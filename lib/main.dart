import 'package:first_app/layout/todo_app/todo_layout.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Myapp());//
}
//  StatelessWidget
// StatefulWidget
class Myapp extends StatelessWidget//this come  from library 'package:flutter/material.dart' calling from (important)
    {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }
}