import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:json_app/models/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// ApiService handles all network requests for the application.
/// It provides methods to fetch notification data both synchronously and asynchronously using isolates.
/// The service includes error handling for common network issues, caching capabilities,
/// and connectivity checking.
class ApiService {
  static const String notificationEndpoint =
      'https://raw.githubusercontent.com/sayanp23/test-api/main/test-notifications.json';
  
  // Maximum time to wait for a response before timing out
  static const int _timeoutDuration = 15; // seconds
  
  // Cache expiration duration
  static const Duration _cacheExpiration = Duration(hours: 1);
  
  // Add http client as a class property for easier testing and customization
  final http.Client client;
  
  // Connectivity service to check network status
  final Connectivity connectivity;
  
  /// Constructor that allows dependency injection of the HTTP client and connectivity service
  /// This makes the class more testable as mocks can be injected
  ApiService({
    http.Client? client,
    Connectivity? connectivity,
  }) : 
    client = client ?? http.Client(),
    connectivity = connectivity ?? Connectivity();

  /// Checks if the device has an active internet connection
  /// Returns true if connected, false otherwise
  Future<bool> hasInternetConnection() async {
    try {
      var connectivityResult = await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }
      
      // Additional check by pinging a reliable endpoint
      // This confirms that we can actually reach the internet, not just that WiFi/data is on
      final response = await client
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      // If any error occurs during connectivity check, assume no connection
      return false;
    }
  }

  /// Fetches notifications from the API using the standard approach
  /// This method handles various error cases and implements timeout protection
  Future<NotificationResponse> fetchNotifications() async {
    try {
      // Check internet connection before making the request
      if (!await hasInternetConnection()) {
        // Try to retrieve cached data if available
        final cachedData = await getCachedNotifications();
        if (cachedData != null) {
          return cachedData;
        }
        throw const NoInternetException('No internet connection available. Also, no cached data found.');
      }

      // Make the API request with timeout protection
      final response = await client
          .get(Uri.parse(notificationEndpoint))
          .timeout(Duration(seconds: _timeoutDuration));
      
      // Handle different HTTP status codes
      if (response.statusCode == 200) {
        // Cache successful response
        await cacheNotifications(response.body);
        return NotificationResponse.fromJson(json.decode(response.body));
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        // Client errors (4xx)
        throw ClientErrorException('Client error: ${response.statusCode}. ${_getErrorMessage(response.statusCode)}');
      } else if (response.statusCode >= 500) {
        // Server errors (5xx)
        throw ServerErrorException('Server error: ${response.statusCode}. ${_getErrorMessage(response.statusCode)}');
      } else {
        // Other unexpected status codes
        throw ApiException('Unexpected status code: ${response.statusCode}');
      }
    } on SocketException {
      // Handle socket exceptions (usually connection refused, network unreachable, etc.)
      final cachedData = await getCachedNotifications();
      if (cachedData != null) {
        return cachedData;
      }
      throw const ConnectionException('Unable to connect to server. Please check your network settings.');
    } on TimeoutException {
      // Handle timeout exceptions
      final cachedData = await getCachedNotifications();
      if (cachedData != null) {
        return cachedData;
      }
      throw const TimeoutException('Request timed out. The server is taking too long to respond.');
    } on FormatException {
      // Handle JSON parsing errors
      throw const DataParsingException('Failed to parse response data. Invalid format received.');
    } catch (e) {
      // Handle any other unexpected errors
      throw ApiException('An unexpected error occurred: ${e.toString()}');
    }
  }

  /// Fetches notifications using an isolate for better performance with large JSON data
  /// This offloads JSON parsing to a separate thread to avoid UI jank
  Future<NotificationResponse> fetchNotificationsWithIsolate() async {
    try {
      // Check internet connection before making the request
      if (!await hasInternetConnection()) {
        // Try to retrieve cached data if available
        final cachedData = await getCachedNotifications();
        if (cachedData != null) {
          return cachedData;
        }
        throw const NoInternetException('No internet connection available. Also, no cached data found.');
      }

      final response = await client
          .get(Uri.parse(notificationEndpoint))
          .timeout(Duration(seconds: _timeoutDuration));
      
      if (response.statusCode == 200) {
        // Cache successful response
        await cacheNotifications(response.body);
        
        // Use compute to run parsing in separate isolate
        // This prevents blocking the UI thread during parsing of large JSON
        return compute(_parseNotifications, response.body);
      } else {
        // Handle error status codes the same way as in fetchNotifications
        if (response.statusCode >= 400 && response.statusCode < 500) {
          throw ClientErrorException('Client error: ${response.statusCode}. ${_getErrorMessage(response.statusCode)}');
        } else if (response.statusCode >= 500) {
          throw ServerErrorException('Server error: ${response.statusCode}. ${_getErrorMessage(response.statusCode)}');
        } else {
          throw ApiException('Unexpected status code: ${response.statusCode}');
        }
      }
    } on SocketException {
      final cachedData = await getCachedNotifications();
      if (cachedData != null) {
        return cachedData;
      }
      throw const ConnectionException('Unable to connect to server. Please check your network settings.');
    } on TimeoutException {
      final cachedData = await getCachedNotifications();
      if (cachedData != null) {
        return cachedData;
      }
      throw const TimeoutException('Request timed out. The server is taking too long to respond.');
    } on FormatException {
      throw const DataParsingException('Failed to parse response data. Invalid format received.');
    } catch (e) {
      throw ApiException('An unexpected error occurred: ${e.toString()}');
    }
  }

  /// Static method for isolate to parse JSON
  /// This runs in a separate isolate to avoid blocking the UI thread
  static NotificationResponse _parseNotifications(String responseBody) {
    try {
      return NotificationResponse.fromJson(json.decode(responseBody));
    } catch (e) {
      throw const DataParsingException('Failed to parse notification data');
    }
  }

  /// Caches the notification data for offline access
  /// Stores both the data and a timestamp for expiration checking
  Future<void> cacheNotifications(String data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('cached_notifications', data);
      await prefs.setString('cache_timestamp', DateTime.now().toIso8601String());
    } catch (e) {
      // Cache failures should not block the app flow, just log the error
      debugPrint('Failed to cache notifications: $e');
    }
  }

  /// Retrieves cached notification data if available and not expired
  /// Returns null if no cache exists or if the cache has expired
  Future<NotificationResponse?> getCachedNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('cached_notifications');
      final timestampStr = prefs.getString('cache_timestamp');
      
      if (cachedData != null && timestampStr != null) {
        final timestamp = DateTime.parse(timestampStr);
        final now = DateTime.now();
        
        // Check if cache has expired
        if (now.difference(timestamp) < _cacheExpiration) {
          return NotificationResponse.fromJson(json.decode(cachedData));
        } else {
          // Clear expired cache
          await prefs.remove('cached_notifications');
          await prefs.remove('cache_timestamp');
        }
      }
      return null;
    } catch (e) {
      debugPrint('Failed to retrieve cached notifications: $e');
      return null;
    }
  }

  /// Helper method to get descriptive error messages for common HTTP status codes
  String _getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your request parameters.';
      case 401:
        return 'Unauthorized. Authentication required.';
      case 403:
        return 'Forbidden. You do not have permission to access this resource.';
      case 404:
        return 'Not found. The requested resource does not exist.';
      case 408:
        return 'Request timeout. Please try again later.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 502:
        return 'Bad gateway. The server received an invalid response.';
      case 503:
        return 'Service unavailable. The server is currently unavailable.';
      case 504:
        return 'Gateway timeout. The server is taking too long to respond.';
      default:
        return 'An error occurred with the request.';
    }
  }

  /// Closes the HTTP client when done
  /// Important to prevent memory leaks and resource exhaustion
  void dispose() {
    client.close();
  }
}

/// Custom exception classes for more descriptive error handling

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);
  @override
  String toString() => message;
}

class NoInternetException extends ApiException {
  const NoInternetException(String message) : super(message);
}

class ConnectionException extends ApiException {
  const ConnectionException(String message) : super(message);
}

class TimeoutException extends ApiException {
  const TimeoutException(String message) : super(message);
}

class ServerErrorException extends ApiException {
  const ServerErrorException(String message) : super(message);
}

class ClientErrorException extends ApiException {
  const ClientErrorException(String message) : super(message);
}

class DataParsingException extends ApiException {
  const DataParsingException(String message) : super(message);
}