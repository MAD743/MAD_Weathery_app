// lib/screens/community_report_screen.dart

import 'package:flutter/material.dart';
import '../services/report_service.dart';

class CommunityReportScreen extends StatefulWidget {
  @override
  _CommunityReportScreenState createState() => _CommunityReportScreenState();
}

class _CommunityReportScreenState extends State<CommunityReportScreen> {
  final TextEditingController _controller = TextEditingController();
  final ReportService _reportService = ReportService();

  void _submitReport() async {
    if (_controller.text.trim().isNotEmpty) {
      await _reportService.submitReport('demo_user', _controller.text.trim());

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Report submitted!')));
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Community Reports')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Describe the weather...',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitReport,
              child: Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}
