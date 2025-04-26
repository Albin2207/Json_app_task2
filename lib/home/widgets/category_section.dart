import 'package:flutter/material.dart';

class InteractiveCategorySection extends StatelessWidget {
  const InteractiveCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [  
        // Make the entire image interactive with GestureDetector
        GestureDetector(
          onTapUp: (details) {
            // Get the position where the user tapped
            final RenderBox box = context.findRenderObject() as RenderBox;
            final localPosition = box.globalToLocal(details.globalPosition);
            
            // Determine which category was tapped based on position
            _handleCategoryTap(context, localPosition);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/category_icons/Group 537.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }

  void _handleCategoryTap(BuildContext context, Offset localPosition) {
    // Get the width of the container
    final width = MediaQuery.of(context).size.width - 32; // Accounting for padding
    
    // Divide the width into 4 columns (4 categories per row)
    final columnWidth = width / 4;
    
    // Assuming 2 rows of categories
    final rowHeight = columnWidth; // Assuming square-ish cells
    
    // Determine which column and row was tapped
    final column = (localPosition.dx / columnWidth).floor();
    final row = (localPosition.dy / rowHeight).floor();
    
    // Calculate the index of the tapped category
    final index = row * 4 + column;
    
    // List of category names
    final categories = [
      'Food Delivery', 'Medicines', 'Pet Supplies', 'Gifts',
      'Meat', 'Cosmetic', 'Stationery', 'Stores'
    ];
    
    // Make sure index is within range
    if (index >= 0 && index < categories.length) {
      print('Tapped on ${categories[index]}');
      
      // You can navigate to the appropriate screen or show a dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${categories[index]} selected')),
      );
    }
  }
}