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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            BottomNavbar(),
          ],
        ),
      ),
    );
  }
}
