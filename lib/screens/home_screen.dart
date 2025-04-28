import 'package:flutter/material.dart';
import 'forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cityController = TextEditingController();

  void _navigateToForecast(String city) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForecastScreen(city: city)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weatherly')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_cityController.text.isNotEmpty) {
                      _navigateToForecast(_cityController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.my_location),
              label: Text("Use Current Location"),
              onPressed: () {
                _navigateToForecast(''); // empty string triggers auto location
              },
            ),
          ],
        ),
      ),
    );
  }
}
