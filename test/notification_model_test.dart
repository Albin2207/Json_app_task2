import 'package:flutter_test/flutter_test.dart';
import 'package:json_app/models/notification_model.dart';


void main() {
  group('NotificationModel', () {
    test('should correctly parse from JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'image': 'order_delivered.png',
        'title': 'Order Delivered',
        'body': 'Your order containing 2 items has been delivered.',
        'timestamp': '2023-01-10T11:06:54.754'
      };

      // Act
      final notification = NotificationModel.fromJson(json);

      // Assert
      expect(notification.image, 'order_delivered.png');
      expect(notification.title, 'Order Delivered');
      expect(notification.body, 'Your order containing 2 items has been delivered.');
      expect(notification.timestamp, DateTime.parse('2023-01-10T11:06:54.754'));
    });

    test('should handle missing values gracefully', () {
      // Arrange
      final Map<String, dynamic> json = {
        'title': 'Order Delivered',
      };

      // Act
      final notification = NotificationModel.fromJson(json);

      // Assert
      expect(notification.image, '');
      expect(notification.title, 'Order Delivered');
      expect(notification.body, '');
      // The timestamp should be set to a default value
      expect(notification.timestamp.year, isNotNull);
    });

    test('should correctly convert to JSON', () {
      // Arrange
      final notification = NotificationModel(
        image: 'order_delivered.png',
        title: 'Order Delivered',
        body: 'Your order containing 2 items has been delivered.',
        timestamp: DateTime.parse('2023-01-10T11:06:54.754'),
      );

      // Act
      final json = notification.toJson();

      // Assert
      expect(json['image'], 'order_delivered.png');
      expect(json['title'], 'Order Delivered');
      expect(json['body'], 'Your order containing 2 items has been delivered.');
      expect(json['timestamp'], '2023-01-10T11:06:54.754Z');
    });
  });

  group('NotificationResponse', () {
    test('should correctly parse from JSON', () {
      // Arrange
      final Map<String, dynamic> json = {
        'message': 'Notification listed successfully',
        'data': [
          {
            'image': 'order_delivered.png',
            'title': 'Order Delivered',
            'body': 'Your order containing 2 items has been delivered.',
            'timestamp': '2023-01-10T11:06:54.754'
          },
          {
            'image': 'order_cancelled.png',
            'title': 'Order Cancelled',
            'body': 'Your order containing 2 items has been cancelled.',
            'timestamp': '2023-01-10T11:01:54.754'
          }
        ]
      };

      // Act
      final response = NotificationResponse.fromJson(json);

      // Assert
      expect(response.message, 'Notification listed successfully');
      expect(response.data.length, 2);
      expect(response.data[0].title, 'Order Delivered');
      expect(response.data[1].title, 'Order Cancelled');
    });

    test('should handle empty data array', () {
      // Arrange
      final Map<String, dynamic> json = {
        'message': 'Notification listed successfully',
        'data': []
      };

      // Act
      final response = NotificationResponse.fromJson(json);

      // Assert
      expect(response.message, 'Notification listed successfully');
      expect(response.data.length, 0);
    });

    test('should handle missing data array', () {
      // Arrange
      final Map<String, dynamic> json = {
        'message': 'Notification listed successfully',
      };

      // Act
      final response = NotificationResponse.fromJson(json);

      // Assert
      expect(response.message, 'Notification listed successfully');
      expect(response.data.length, 0);
    });
  });
}