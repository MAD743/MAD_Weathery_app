class WeatherModel {
  final double currentTemp;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;

  WeatherModel({
    required this.currentTemp,
    required this.hourly,
    required this.daily,
  });
}

class HourlyForecast {
  final DateTime time;
  final double temp;
  final String description;

  HourlyForecast({
    required this.time,
    required this.temp,
    required this.description,
  });
}

class DailyForecast {
  final DateTime date;
  final double tempMin;
  final double tempMax;
  final String description;

  DailyForecast({
    required this.date,
    required this.tempMin,
    required this.tempMax,
    required this.description,
  });
}
