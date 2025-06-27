import 'package:flutter/material.dart';
import 'package:phonebook_api/screens/home_screen.dart';
import 'package:phonebook_api/utils/network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Network.checkInternet();
    super.initState();
  }

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
