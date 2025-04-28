import 'package:flutter/material.dart';

/// Widget displaying the "Refer & Earn" promotional banner
///
/// Shows a green banner with referral information and a gift image,
/// encouraging users to invite friends and earn discounts
class ReferEarn extends StatelessWidget {
  const ReferEarn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 340,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF22C55E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Left text section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 11),
                    child: Text(
                      'Refer & Earn',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Row with text and arrow button
                  Row(
                    // Make the Row take minimum horizontal space
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Wrap text with Flexible to allow it to shrink if needed
                      Flexible(
                        child: Text(
                          'Invite your friends & earn 15% off',
                          style: TextStyle(fontSize: 13, color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Circular arrow button
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: const Color(0xFF22C55E),
                          size: 12, // Reduced size slightly
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 3),

            // Gift image - keeping the original Image.asset
            Image.asset(
              'assets/gift.png',
              width: 80,
              height: 80,
              // Fallback if image can't be loaded - create a gift box icon
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Gift box base
                        Positioned(
                          bottom: 5,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // ignore: deprecated_member_use
                              border: Border.all(
                                // ignore: deprecated_member_use
                                color: Colors.grey.withOpacity(0.3),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        // Horizontal ribbon
                        Positioned(
                          bottom: 28,
                          child: Container(
                            width: 52,
                            height: 8,
                            color: Colors.orange,
                          ),
                        ),
                        // Vertical ribbon
                        Center(
                          child: Container(
                            width: 8,
                            height: 60,
                            color: Colors.orange,
                          ),
                        ),
                        // Person peeking
                        Positioned(
                          top: 10,
                          right: 16,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
