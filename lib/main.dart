import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home_screen.dart';
import 'screens/alert_settings_screen.dart';
import 'screens/radar_map_screen.dart';
import 'screens/community_report_screen.dart';
import 'services/report_service.dart';

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
        '/alerts': (context) => AlertSettingsScreen(),
        '/radar': (context) => RadarMapScreen(),
        '/reports': (context) => CommunityReportScreen(),
      },
    );
  }
}
