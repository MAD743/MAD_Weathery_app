import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';
import '../models/weather_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  Weather? _weather;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      final position = await _locationService.getCurrentLocation();
      final weather = await _weatherService.getWeatherByLocation(
        position.latitude,
        position.longitude,
      );
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weatherly")),
      body: Center(
        child:
            _weather != null
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "📍 ${_weather!.city}",
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${_weather!.temperature}°C",
                      style: TextStyle(fontSize: 32),
                    ),
                    Text(_weather!.description, style: TextStyle(fontSize: 18)),
                    Image.network(
                      'https://openweathermap.org/img/wn/${_weather!.icon}@2x.png',
                    ),
                  ],
                )
                : _error != null
                ? Text("Error: $_error")
                : CircularProgressIndicator(),
      ),
    );
  }
}
