class WeatherAlert {
  final String type; // 'rain', 'snow', etc.
  final double threshold;
  final String userId;

  WeatherAlert({
    required this.type,
    required this.threshold,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {'type': type, 'threshold': threshold, 'userId': userId};
  }

  static WeatherAlert fromMap(Map<String, dynamic> map) {
    return WeatherAlert(
      type: map['type'],
      threshold: map['threshold'],
      userId: map['userId'],
    );
  }
}
