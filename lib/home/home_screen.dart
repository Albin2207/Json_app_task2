import 'package:flutter/material.dart';
import 'package:json_app/home/widgets/category_section.dart';
import 'package:json_app/home/widgets/crazydeals_section.dart';
import 'package:json_app/home/widgets/nearby_stores.dart';
import 'package:json_app/home/widgets/refer_earn.dart';
import 'package:json_app/home/widgets/top_picks.dart';
import 'package:json_app/home/widgets/trending_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with location and search bar
            _buildHeader(),

            // Main content with scrollable items
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      InteractiveCategorySection(),
                      const SizedBox(height: 20),
                      TopPicksWidget(),
                      const SizedBox(height: 20),
                      TrendingList(),
                      const SizedBox(height: 20),
                      CrazydealsSection(),
                      const SizedBox(height: 20),
                      ReferEarn(),
                      const SizedBox(height: 20),
                      NearbyStores(),
                      const SizedBox(height: 20),
                      _buildViewAllStoresButton(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          // Location row
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: const Color.fromARGB(255, 69, 218, 74),
                size: 28,
              ),
              const SizedBox(width: 4),
              Text(
                'ABCD, New Delhi',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.green, size: 25),
              Spacer(),
            ],
          ),
          const SizedBox(height: 12),

          // Search bar
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Search for products/stores',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.search,
                        color: const Color.fromARGB(255, 77, 228, 82),
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      size: 28,
                      color: Colors.orange,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.local_offer_outlined, size: 24, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllStoresButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          'View all stores',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
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
          _buildBottomNavItem(Icons.home, 'Home', true),
          _buildBottomNavItem(Icons.shopping_cart_outlined, 'Cart', false),
          _buildBottomNavItem(Icons.shopping_bag_outlined, 'My Order', false),
          _buildBottomNavItem(Icons.person_outline, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isSelected ? Colors.green : Colors.grey, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.green : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
