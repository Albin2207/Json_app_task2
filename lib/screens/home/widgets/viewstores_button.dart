import 'package:flutter/material.dart';

/// A button widget for viewing all stores
///
/// Creates a centered button that spans about half the screen width with
/// a green background and rounded corners
class ViewstoresButton extends StatelessWidget {
  const ViewstoresButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 230,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF22C55E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 5),
          ),
          child: Text(
            'View all stores',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
