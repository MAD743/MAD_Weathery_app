import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = '05dfcb7065aa57ddb223b1c6482adae9';

  Future<WeatherModel> fetchWeather({String city = ''}) async {
    double lat;
    double lon;

    if (city.isEmpty) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      lat = position.latitude;
      lon = position.longitude;
    } else {
      final geoRes = await http.get(
        Uri.parse(
          'http://api.openweathermap.org/geo/1.0/direct?q=$city&limit=1&appid=$apiKey',
        ),
      );
      if (geoRes.statusCode != 200)
        throw Exception('Failed to fetch coordinates');
      final geoData = json.decode(geoRes.body);
      if (geoData.isEmpty) throw Exception('City not found');
      lat = geoData[0]['lat'];
      lon = geoData[0]['lon'];
    }

    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&units=imperial&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) throw Exception('Failed to fetch weather');
    final data = json.decode(response.body);
    final List forecasts = data['list'];

    return WeatherModel(
      currentTemp: forecasts[0]['main']['temp'].toDouble(),
      hourly:
          forecasts.take(8).map((e) {
            return HourlyForecast(
              time: DateTime.parse(e['dt_txt']),
              temp: e['main']['temp'].toDouble(),
              description: e['weather'][0]['main'],
            );
          }).toList(),
      daily: _extractDailyForecasts(forecasts),
    );
  }

  List<DailyForecast> _extractDailyForecasts(List<dynamic> forecastList) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var entry in forecastList) {
      String date = entry['dt_txt'].substring(0, 10);
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(entry);
    }

    List<DailyForecast> daily = [];
    for (var date in grouped.keys.toList()..sort()) {
      if (daily.length >= 7) break;
      final temps =
          grouped[date]!.map((e) => e['main']['temp'].toDouble()).toList();
      final description = grouped[date]![0]['weather'][0]['main'];
      daily.add(
        DailyForecast(
          date: DateTime.parse(date),
          tempMin: temps.reduce((a, b) => a < b ? a : b),
          tempMax: temps.reduce((a, b) => a > b ? a : b),
          description: description,
        ),
      );
    }

    return daily;
  }
}
