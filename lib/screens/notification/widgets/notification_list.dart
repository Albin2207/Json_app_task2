import 'package:flutter/material.dart';
import 'package:json_app/models/notification_model.dart';
import 'package:json_app/screens/notification/widgets/empty_notifications.dart';
import 'package:json_app/screens/notification/widgets/notifications_item.dart';

/// This widget is responsible for:
/// - Checking if the notifications list is empty and showing appropriate UI
/// - Rendering the list of notification items with proper spacing
/// - Handling list padding and separator styling
class NotificationList extends StatelessWidget {
  /// The list of notification models to display
  final List<NotificationModel> notifications;

  const NotificationList({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    // If there are no notifications, show the empty state
    if (notifications.isEmpty) {
      return const EmptyNotifications();
    }

    // Otherwise, display the scrollable list of notifications
    return ListView.separated(
      // Add padding around the entire list
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      // Add vertical spacing between list items
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationItem(notification: notification);
      },
    );
  }
}
