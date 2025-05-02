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

class _ForecastScreenState extends State<ForecastScreen>
    with SingleTickerProviderStateMixin {
  late Future<WeatherModel> _weatherFuture;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _weatherFuture = WeatherService().fetchWeather(city: widget.city);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'Hourly Forecast'), Tab(text: '7-Day Forecast')],
        ),
      ),
      body: FutureBuilder<WeatherModel>(
        future: _weatherFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Failed to fetch weather: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final data = snapshot.data!;
          return TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: data.hourly.length,
                itemBuilder: (context, index) {
                  final hour = data.hourly[index];
                  return ListTile(
                    leading: Text(DateFormat.Hm().format(hour.time)),
                    title: Text('${hour.temp}°F'),
                    subtitle: Text(hour.description),
                  );
                },
              ),
              ListView.builder(
                itemCount: data.daily.length,
                itemBuilder: (context, index) {
                  final day = data.daily[index];
                  return ListTile(
                    leading: Text(DateFormat.EEEE().format(day.date)),
                    title: Text('${day.tempMin}°F ~ ${day.tempMax}°F'),
                    subtitle: Text(day.description),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
