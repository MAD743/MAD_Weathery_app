import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';


class WeatherService {
  final String apiKey = 'YOUR_API_KEY_HERE';


  Future<Weather> getWeatherByLocation(double lat, double lon) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&units=metric&appid=$apiKey',
    );


    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather');
    }
  }
}
