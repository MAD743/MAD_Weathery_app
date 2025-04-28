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

  HourlyForecast({required this.time, required this.temp});
}

class DailyForecast {
  final DateTime date;
  final double tempMin;
  final double tempMax;

  DailyForecast({
    required this.date,
    required this.tempMin,
    required this.tempMax,
  });
}
