import 'package:flutter/material.dart';

/// Widget that displays a horizontally scrollable list of trending stores or items
///
/// Contains a header with title and "See all" action, followed by
/// horizontally scrollable cards showing trending restaurants/stores
class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header row with "Trending" title and "See all" action
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Horizontally scrollable list of trending items
        SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                // First Column of restaurants
                Column(
                  children: [
                    _buildTrendingItem(
                      'Mithas Bhandar',
                      'Sweets, North Indian',
                      '(store location) | 6.4 kms',
                      '4.1  |',
                      '45 mins',
                    ),
                    const SizedBox(height: 16),
                    _buildTrendingItem(
                      'Mithas Bhandar',
                      'Sweets, North Indian',
                      '(store location) | 6.4 kms',
                      '4.1  |',
                      '45 mins',
                    ),
                  ],
                ),

                const SizedBox(width: 1),
                // Second Column of restaurants
                Column(
                  children: [
                    _buildTrendingItem(
                      'Mithas Bhandar',
                      'Sweets, North Indian',
                      '(store location) | 6.4 kms',
                      '4.1  |',
                      '45 mins',
                    ),
                    const SizedBox(height: 16),
                    _buildTrendingItem(
                      'Mithas Bhandar',
                      'Sweets, North Indian',
                      '(store location) | 6.4 kms',
                      '4.1  |',
                      '45 mins',
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                // Third Column of restaurants
                Column(
                  children: [
                    _buildTrendingItem(
                      'Burger Junction',
                      'American, Fast Food',
                      'West Mall | 4.0 kms',
                      '4.2  |',
                      '25 mins',
                    ),
                    const SizedBox(height: 12),
                    _buildTrendingItem(
                      'Green Leaves',
                      'Vegetarian, Healthy',
                      'Park Avenue | 2.9 kms',
                      '4.6  |',
                      '40 mins',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a single trending item card
  ///
  /// @param name Name of the restaurant or store
  /// @param cuisine Type of cuisine or category
  /// @param location Location and distance information
  /// @param rating Rating of the restaurant (typically displayed with a star)
  /// @param time Estimated delivery or preparation time
  /// @return A widget representing a trending item card
  Widget _buildTrendingItem(
    String name,
    String cuisine,
    String location,
    String rating,
    String time,
  ) {
    return SizedBox(
      width: 251,
      child: Row(
        children: [
          // Restaurant/store image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/Group 101.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade300,
                    child: Icon(Icons.image, color: Colors.grey),
                  ),
            ),
          ),
          const SizedBox(width: 12),
          // Restaurant/store details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  cuisine,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                Text(
                  location,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                // Rating and delivery time row
                Row(
                  // Make sure children fit within the available space
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: const Color.fromARGB(255, 133, 130, 130),
                      size: 16,
                    ),
                    Flexible(
                      child: Text(
                        ' $rating',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        ' $time',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
