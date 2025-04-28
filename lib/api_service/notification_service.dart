import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:json_app/models/notification_model.dart';

class ApiService {
  static const String notificationEndpoint =
      'https://raw.githubusercontent.com/sayanp23/test-api/main/test-notifications.json';
  
  // Add http client as a class property
  final http.Client client;
  
  // Modify constructor to accept an optional client
  ApiService({http.Client? client}) : client = client ?? http.Client();

  // Regular method to fetch notifications (using instance client)
  Future<NotificationResponse> fetchNotifications() async {
    try {
      final response = await client.get(Uri.parse(notificationEndpoint));
      
      if (response.statusCode == 200) {
        return NotificationResponse.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }

  // Method using isolate for better performance with large JSON data
  Future<NotificationResponse> fetchNotificationsWithIsolate() async {
    try {
      final response = await client.get(Uri.parse(notificationEndpoint));
      
      if (response.statusCode == 200) {
        // Using compute to run parsing in separate isolate
        return compute(_parseNotifications, response.body);
      } else {
        throw Exception('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch notifications: $e');
    }
  }

  // Static method for isolate to parse JSON
  static NotificationResponse _parseNotifications(String responseBody) {
    return NotificationResponse.fromJson(json.decode(responseBody));
  }
}