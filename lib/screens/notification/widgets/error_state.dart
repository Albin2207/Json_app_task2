import 'package:flutter/material.dart';

/// Displays when notification fetching fails, showing:
/// - A red error icon
/// - Error message
/// - Retry button to attempt fetching notifications again
class ErrorState extends StatelessWidget {
  /// The specific error message to display
  final String errorMessage;

  /// Callback function for the retry button
  final VoidCallback onRetry;

  const ErrorState({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Error icon
          const Icon(Icons.error_outline, color: Colors.red, size: 60),
          const SizedBox(height: 16),

          // Main error message
          Text(
            'Failed to load notifications',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),

          // Detailed error message from the API or system
          Text(
            errorMessage,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Retry button
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
