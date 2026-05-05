import 'package:flutter/material.dart';
import 'package:self_code/components/bottom_nav_bar.dart';
import 'package:self_code/screens/home_screen.dart';
import 'package:self_code/screens/profile_page.dart';
import 'package:self_code/screens/search_page.dart';
import 'package:self_code/screens/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Page controller to control the jump between pages
  final PageController _pageController = PageController();

  // Selected index for the bottom navigation bar
  int _selectedIndex = 0;

  // Handle navigation bar tab changes
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Animate to the selected page
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Screens to display
  final List<Widget> _pages = [
    const HomeContentPage(),
    const SearchPage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
        onTabChange: (index) => _navigateBottomBar(index),
        selectedIndex: _selectedIndex,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
