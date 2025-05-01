import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class ForecastScreen extends StatefulWidget {
  final String city;

  ForecastScreen({required this.city});

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  late Future<WeatherModel> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _weatherFuture = WeatherService().fetchWeather(city: widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forecast')),
      body: FutureBuilder<WeatherModel>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 40),
                  SizedBox(height: 10),
                  Text(
                    'Failed to fetch weather:\n${snapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _weatherFuture = WeatherService().fetchWeather(
                          city: widget.city,
                        );
                      });
                    },
                    child: Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          final data = snapshot.data!;
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                'Current Temp: ${data.currentTemp}°C',
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(height: 16),
              Text('Hourly Forecast:', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              ...data.hourly.map(
                (hour) => ListTile(
                  title: Text(
                    '${DateFormat.Hm().format(hour.time)}: ${hour.temp}°C',
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text('7-Day Forecast:', style: TextStyle(fontSize: 18)),
              SizedBox(height: 8),
              ...data.daily.map(
                (day) => ListTile(
                  title: Text(
                    '${DateFormat.E().format(day.date)}: ${day.tempMin}°F - ${day.tempMax}°C',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
