import 'package:flutter/material.dart';
import 'package:json_app/provider/notification_provider.dart';
import 'package:json_app/screens/notification/widgets/error_state.dart';
import 'package:json_app/screens/notification/widgets/header_section.dart';
import 'package:json_app/screens/notification/widgets/loading_state.dart';
import 'package:json_app/screens/notification/widgets/notification_list.dart';

import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();

    // Schedule the fetch operation to happen after the first frame is rendered
    // This ensures the context is fully initialized before we use it
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch notifications using an isolate for better performance
      // This prevents UI freezing during data processing
      Provider.of<NotificationProvider>(
        context,
        listen: false,
      ).fetchNotificationsWithIsolate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header section with title and notification icon
            const NotificationHeader(),

            // Main content area - responds to the provider's state
            Expanded(
              child: Consumer<NotificationProvider>(
                builder: (context, provider, child) {
                  // Show different UI based on the current state
                  switch (provider.state) {
                    case NotificationState.loading:
                      // Show loading spinner while waiting for data
                      return const LoadingState();
                    case NotificationState.loaded:
                      // Show notification list when data is available
                      return NotificationList(
                        notifications: provider.notifications,
                      );
                    case NotificationState.error:
                      // Show error view with retry button when fetch fails
                      return ErrorState(
                        errorMessage: provider.errorMessage,
                        onRetry: () => provider.fetchNotificationsWithIsolate(),
                      );
                    case NotificationState.initial:
                      // Empty container for initial state
                      return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
