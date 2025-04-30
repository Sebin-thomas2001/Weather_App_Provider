import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_provider/screens/home_page.dart';
import 'package:weather_app_provider/services/location_Provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>LocationProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent
        ),
        iconTheme: const IconThemeData(
          color: Colors.white
        )
        ),
        home: const HomePage(),
      ),
    );
  }
}

