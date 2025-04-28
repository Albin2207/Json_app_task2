import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;
  
  const BottomNavbar({
    super.key, 
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomNavItem(0, 'assets/bottom_navigation/Group (2).png', 'assets/bottom_navigation/Group (2).png', 'Home'),
          _buildBottomNavItem(1, 'assets/bottom_navigation/Group 196.png', 'assets/bottom_navigation/Group 196.png', 'Cart'),
          _buildBottomNavItem(2, 'assets/bottom_navigation/Group 197.png', 'assets/bottom_navigation/Group 197.png', 'My Order'),
          _buildBottomNavItem(3, 'assets/bottom_navigation/Group 201.png', 'assets/bottom_navigation/Group 201.png', 'Profile'),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(int index, String iconPath, String activeIconPath, String label) {
    final bool isSelected = index == currentIndex;
    
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            isSelected ? activeIconPath : iconPath,
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.green : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}