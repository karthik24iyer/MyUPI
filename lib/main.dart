import 'package:flutter/material.dart';

import 'page/qr_page.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My UPI App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: Colors.black,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        canvasColor: Colors.black,
        cardColor: Colors.black,
        appBarTheme: const AppBarTheme(color: Colors.black),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: Colors.black),
      ),
      home: const QrPage(),
      //home: const LoginHome(),
    );
  }
}
