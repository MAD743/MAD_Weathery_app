// alert_settings_screen.dart
import 'package:flutter/material.dart';
import '../models/alert_model.dart';
import '../services/alert_service.dart';

class AlertSettingsScreen extends StatefulWidget {
  @override
  _AlertSettingsScreenState createState() => _AlertSettingsScreenState();
}

class _AlertSettingsScreenState extends State<AlertSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _thresholdController = TextEditingController();
  String _selectedType = 'Rain';
  final AlertService _alertService = AlertService();

  void _saveAlert() async {
    if (_formKey.currentState!.validate()) {
      final alert = WeatherAlert(
        type: _selectedType.toLowerCase(),
        threshold: double.parse(_thresholdController.text),
        userId: 'demo_user', // Placeholder for demo or test user
      );

      await _alertService.saveAlert(alert);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Alert saved!')));

      _thresholdController.clear();
    }
  }

  @override
  void dispose() {
    _thresholdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather Alert Settings')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                items:
                    ['Rain', 'Snow', 'Temperature'].map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: InputDecoration(labelText: 'Alert Type'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _thresholdController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Threshold'),
                validator:
                    (value) => value!.isEmpty ? 'Enter a threshold' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _saveAlert, child: Text('Save Alert')),
            ],
          ),
        ),
      ),
    );
  }
}
