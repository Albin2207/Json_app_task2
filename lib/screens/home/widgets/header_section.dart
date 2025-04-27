import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                        style: TextStyle(color: Colors.grey, fontSize: 16.5),
                      ),
                      const SizedBox(width: 6),
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
                    IconButton(
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 28,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
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
}
