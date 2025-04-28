import 'package:flutter/material.dart';
import 'package:json_app/screens/home/widgets/category_section.dart';
import 'package:json_app/screens/home/widgets/crazydeals_section.dart';
import 'package:json_app/screens/home/widgets/header_section.dart';
import 'package:json_app/screens/home/widgets/nearby_stores.dart';
import 'package:json_app/screens/home/widgets/refer_earn.dart';
import 'package:json_app/screens/home/widgets/top_picks.dart';
import 'package:json_app/screens/home/widgets/trending_list.dart';
import 'package:json_app/screens/home/widgets/viewstores_button.dart';
import 'package:json_app/widgets/bottom_navbar.dart';

/// Main HomeScreen widget that composes the entire home page of the application
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Current index for bottom navigation bar
  int _currentIndex = 0;

  /// Handles bottom navigation bar item taps
  ///
  /// Updates the current index and could handle navigation to other screens
  /// @param index The index of the tapped navigation item
  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;

      // Add navigation logic here if needed
      // For example, if index is not 0 (Home), you might want to navigate to other screens
      if (index != 0) {
        // Navigate to other screens based on index
        // You could use Navigator to push new routes here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with location and search bar
            HeaderSection(),
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
                      ViewstoresButton(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            BottomNavbar(
              currentIndex: _currentIndex,
              onItemTapped: _onNavItemTapped,
            ),
          ],
        ),
      ),
    );
  }
}
