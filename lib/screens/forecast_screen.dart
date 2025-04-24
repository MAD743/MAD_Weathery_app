import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather_model.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';


class ForecastScreen extends StatefulWidget {
  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}


class _ForecastScreenState extends State<ForecastScreen> {
  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();


  Weather? _weather;


  @override
  void initState() {
    super.initState();
    _loadForecast();
  }


  Future<void> _loadForecast() async {
    final position = await _locationService.getCurrentLocation();
    final weather = await _weatherService.getWeatherByLocation(
      position.latitude,
      position.longitude,
    );
    setState(() {
      _weather = weather;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_weather == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Forecast")),
        body: Center(child: CircularProgressIndicator()),
      );
    }


    return Scaffold(
      appBar: AppBar(title: Text("Forecast - ${_weather!.city}")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Text("Hourly Forecast", style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _weather!.hourly.length,
                itemBuilder: (context, index) {
                  final hour = _weather!.hourly[index];
                  final time = DateFormat.Hm().format(
                    DateTime.fromMillisecondsSinceEpoch(hour.timestamp * 1000),
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Text(time),
                        Image.network('https://openweathermap.org/img/wn/${hour.icon}@2x.png', width: 50),
                        Text('${hour.temp}°C'),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Text("7-Day Forecast", style: TextStyle(fontSize: 20)),
            ListView.builder(
              itemCount: _weather!.daily.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final day = _weather!.daily[index];
                final date = DateFormat.E().format(
                  DateTime.fromMillisecondsSinceEpoch(day.timestamp * 1000),
                );
                return ListTile(
                  leading: Image.network('https://openweathermap.org/img/wn/${day.icon}@2x.png'),
                  title: Text(date),
                  trailing: Text('${day.min.toStringAsFixed(0)}° / ${day.max.toStringAsFixed(0)}°'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
