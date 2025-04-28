import 'package:cloud_firestore/cloud_firestore.dart';

class ReportService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> submitReport(String userId, String report) async {
    await _db.collection('reports').add({
      'userId': userId,
      'report': report,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> getReports() {
    return _db
        .collection('reports')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}
