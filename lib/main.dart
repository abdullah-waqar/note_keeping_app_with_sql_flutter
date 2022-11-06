import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lecture_14/linker.dart';
import 'package:lecture_14/model/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note Keeper',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home:  SplashView(),
    );
  }
}

