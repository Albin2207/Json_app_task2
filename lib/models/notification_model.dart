class NotificationModel {
  final String image;
  final String title;
  final String body;
  final DateTime timestamp;

  NotificationModel({
    required this.image,
    required this.title,
    required this.body,
    required this.timestamp,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      // Store the timestamp exactly as provided, without timezone conversion
      timestamp: _parseExactDateTime(json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'body': body,
      'timestamp': timestamp.toIso8601String() + (timestamp.isUtc ? '' : 'Z'),
    };
  }
  
  // Helper method to parse DateTime without timezone conversion
  static DateTime _parseExactDateTime(String dateTimeString) {
    final dt = DateTime.parse(dateTimeString);
    return DateTime(
      dt.year, dt.month, dt.day, 
      dt.hour, dt.minute, dt.second, 
      dt.millisecond, dt.microsecond
    );
  }
}

class NotificationResponse {
  final String message;
  final List<NotificationModel> data;

  NotificationResponse({
    required this.message,
    required this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => NotificationModel.fromJson(item))
              .toList() ??
          [],
    );
  }
}