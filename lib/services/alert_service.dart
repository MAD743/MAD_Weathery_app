import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/alert_model.dart';

class AlertService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveAlert(WeatherAlert alert) async {
    await _db.collection('alerts').add(alert.toMap());
  }

  Future<List<WeatherAlert>> fetchAlerts(String userId) async {
    final snapshot =
        await _db.collection('alerts').where('userId', isEqualTo: userId).get();
    return snapshot.docs
        .map((doc) => WeatherAlert.fromMap(doc.data()))
        .toList();
  }
}
