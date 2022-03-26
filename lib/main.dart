
import 'package:flutter/material.dart';
import 'package:todo/layout/TodoApp/TodoApp.dart';

void main(){

  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:TodoApp(),
    );

  }


}

