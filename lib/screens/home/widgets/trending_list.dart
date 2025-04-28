import 'package:flutter/material.dart';

class TrendingList extends StatelessWidget {
  const TrendingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      'Home location | 6.4 kms',
                      '4.1  |',
                      '45 mins',
                    ),
                    const SizedBox(height: 16),
                    _buildTrendingItem(
                      'Mithas Bhandar',
                      'Sweets, North Indian',
                      'Home location | 6.4 kms',
                      '4.1  |',
                      '45 mins',
                    ),
                  ],
                ),
               
                const SizedBox(width: 12),
                // Second Column of restaurants
                Column(
                  children: [
                    _buildTrendingItem(
                      'Mithas Bhandar',
                      'Sweets, North Indian',
                      'Home location | 6.4 kms',
                      '4.1  |',
                      '45 mins',
                    ),
                    const SizedBox(height: 16),
                    _buildTrendingItem(
                     'Mithas Bhandar',
                      'Sweets, North Indian',
                      'Home location | 6.4 kms',
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  cuisine,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                Text(
                  location,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                ),
                // Fixed Row that was overflowing
                Row(
                  // Make sure children fit within the available space
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: const Color.fromARGB(255, 133, 130, 130), size: 16),
                    Flexible(
                      child: Text(
                        ' $rating',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        ' $time',
                        style: TextStyle(
                          fontSize: 12,
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