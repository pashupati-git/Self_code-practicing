import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;
  final int selectedIndex;
  const BottomNavBar({
    super.key,
    required this.onTabChange,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: GNav(
          selectedIndex: selectedIndex,
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 8,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          onTabChange: (value) => onTabChange!(value),
          tabs: [
            const GButton(icon: LineIcons.home, text: 'Home'),
            const GButton(icon: LineIcons.search, text: 'Search'),
            const GButton(icon: LineIcons.user, text: 'Profile'),
            const GButton(icon: LineIcons.cog, text: 'Settings'),
          ],
        ),
      ),
    );
  }
}
