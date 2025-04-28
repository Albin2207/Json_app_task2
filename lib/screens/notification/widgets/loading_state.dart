import 'package:flutter/material.dart';

/// Displays a centered green circular progress indicator
/// to indicate that notifications are being fetched
class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Green circular progress indicator
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              // Use green color to match the app's theme
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }
}
