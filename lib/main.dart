import 'package:flutter/material.dart';
import 'package:weather_app_provider/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(
      
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent
      ),
      ),
      home: const HomePage(),
    );
  }
}

