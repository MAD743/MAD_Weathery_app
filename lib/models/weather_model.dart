class Weather {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;
  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.hourly,
    required this.daily,
  });


  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json['timezone'],
      temperature: json['current']['temp'].toDouble(),
      description: json['current']['weather'][0]['description'],
      icon: json['current']['weather'][0]['icon'],
      hourly: (json['hourly'] as List).take(12).map((h) => HourlyWeather.fromJson(h)).toList(),
      daily: (json['daily'] as List).take(7).map((d) => DailyWeather.fromJson(d)).toList(),
    );
  }
}


class HourlyWeather {
  final double temp;
  final String icon;
  final int timestamp;


  HourlyWeather({
    required this.temp,
    required this.icon,
    required this.timestamp,
  });


  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      temp: json['temp'].toDouble(),
      icon: json['weather'][0]['icon'],
      timestamp: json['dt'],
    );
  }
}


class DailyWeather {
  final double min;
  final double max;
  final String icon;
  final int timestamp;


  DailyWeather({
    required this.min,
    required this.max,
    required this.icon,
    required this.timestamp,
  });


  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      min: json['temp']['min'].toDouble(),
      max: json['temp']['max'].toDouble(),
      icon: json['weather'][0]['icon'],
      timestamp: json['dt'],
    );
  }
}
