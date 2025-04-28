import 'package:flutter/material.dart';

class TopPicksWidget extends StatelessWidget {
  const TopPicksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top picks for you',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
        const SizedBox(height: 12),
        // Horizontally scrollable row of promo containers
        SizedBox(
          height: 190,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // First promo container
                _buildPromoContainer(
                  color: Colors.green,
                  imagePath: 'assets/Figma_Resources_2-removebg-preview 1.png',
                  buttonColor: Colors.orange,
                  titles: ['DISCOUNT', '25% ALL', 'FRUITS'],
                ),
                const SizedBox(width: 17),
                // Second promo container
                _buildPromoContainer(
                  color: const Color.fromARGB(255, 66, 51, 179),
                  imagePath: 'assets/This Produce Delivery Service Wants You to Start Eating the _Ugly_ Vegetables Too 1.png',
                  buttonColor: Colors.green,
                  titles: ['FRESH', 'VEGETABLES', 'OFFER'],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoContainer({
    required Color color,
    required String imagePath,
    required Color buttonColor,
    required List<String> titles,
  }) {
    return Container(
      width: 340, // Fixed width for each container
      height: 190,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          // Image positioned to the right
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          // Text and button
          Positioned(
            top: 38,
            left: 18,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...titles.map((title) => Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 1,
                    ),
                  ),
                  child: Text(
                    'CHECK NOW',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}