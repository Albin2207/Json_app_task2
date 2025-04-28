import 'package:flutter/material.dart';

/// Contains static methods to:
/// - Map notification image names to appropriate icons
/// - Map notification types to appropriate colors
/// - Format timestamps into human-readable relative time strings
class NotificationUtils {
  /// Returns the appropriate icon for a notification based on its image name
  ///
  /// [imageName] The name of the notification image from the API
  /// Returns the corresponding [IconData] for the notification type
  static String getAssetForNotification(String imageName) {
    switch (imageName) {
      case 'order_assigned.png':
        return 'assets/notification_images/order_assigned.png';
      case 'order_delivered.png':
        return 'assets/notification_images/order_delivered.png';
      case 'order_cancelled.png':
        return 'assets/notification_images/order_cancelled.png';
      case 'item_unavailable.png':
        return '';
      case 'promotion_marketplace.png':
        return 'assets/notification_images/promotion_marketplace.png';
      case 'promotion_notify.png':
        return 'assets/notification_images/promotion_nootify.png';
      case 'support_ticket.png':
        return 'assets/notification_images/support_peersonnel.png';
      default:
        return 'assets/notification_images/support_peersonnel.png'; // fallback if needed
    }
  }


  /// Returns the appropriate color for a notification based on its image name
  ///
  /// [imageName] The name of the notification image from the API
  /// Returns the corresponding [Color] for the notification type
  static Color getColorForNotification(String imageName) {
    switch (imageName) {
      case 'order_assigned.png':
        return Colors.teal;
      case 'order_delivered.png':
        return Colors.green;
      case 'order_cancelled.png':
        return Colors.red;
      case 'item_unavailable.png':
        return Colors.amber;
      case 'promotion_marketplace.png':
        return Colors.purple;
      case 'promotion_notify.png':
        return Colors.blue;
      case 'support_ticket.png':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  /// Converts a DateTime to a human-readable relative time string
  ///
  /// [dateTime] The timestamp to convert
  /// Returns a string like "2 hours ago", "3 days ago", "Just now", etc.
  static String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    // Format the time difference into a human-readable string
    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} months ago';
    } else if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} mins ago';
    } else {
      return 'Just now';
    }
  }
}
