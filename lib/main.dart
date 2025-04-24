import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'screens/home_screen.dart';
import 'screens/forecast_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WeatherlyApp());
}


class WeatherlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weatherly',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
      routes: {
        '/forecast': (context) => ForecastScreen(),
      },
    );
  }
}
