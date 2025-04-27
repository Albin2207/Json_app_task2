import 'package:flutter/material.dart';
import 'package:json_app/api_service/notification_service.dart';
import '../models/notification_model.dart';

enum NotificationState { initial, loading, loaded, error }

class NotificationProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  NotificationState _state = NotificationState.initial;
  NotificationState get state => _state;
  
  String _errorMessage = '';
  String get errorMessage => _errorMessage;
  
  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  // Method to fetch notifications using regular approach
  Future<void> fetchNotifications() async {
    _setState(NotificationState.loading);
    
    try {
      final response = await _apiService.fetchNotifications();
      _notifications = response.data;
      _setState(NotificationState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(NotificationState.error);
    }
  }

  // Method to fetch notifications using isolate for better performance
  Future<void> fetchNotificationsWithIsolate() async {
    _setState(NotificationState.loading);
    
    try {
      final response = await _apiService.fetchNotificationsWithIsolate();
      _notifications = response.data;
      _setState(NotificationState.loaded);
    } catch (e) {
      _errorMessage = e.toString();
      _setState(NotificationState.error);
    }
  }

  void _setState(NotificationState state) {
    _state = state;
    notifyListeners();
  }
}