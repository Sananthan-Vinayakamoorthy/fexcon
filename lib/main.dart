import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sananthan_task_fexcon/Screens/fetchalldata.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat API Integration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}



