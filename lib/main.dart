import 'package:flutter/material.dart';
import 'package:phonebook_api/screens/home_screen.dart';
import 'package:phonebook_api/utils/network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Network.getData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'دفترچه تلفن آنلاین',
      theme: ThemeData(fontFamily: 'iran'),
      home: HomeScreen(),
    );
  }
}
