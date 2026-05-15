import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:self_code/screens/bottom_navbar_pages/details_page.dart';
import 'package:self_code/screens/sidebar_pages/dashboard_page.dart';
import 'package:self_code/screens/sidebar_pages/animation_page.dart';
import 'package:self_code/screens/sidebar_pages/rewards_page.dart';
import 'package:self_code/screens/sidebar_pages/security_page.dart';
import 'package:self_code/screens/sidebar_pages/subscription_page.dart';
import 'package:self_code/screens/sidebar_pages/support_page.dart';

///In this screen, beautiful slider is used and each slider is linked with inner details page.
class HomeContentPage extends StatelessWidget {
  const HomeContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of map to hold image and title
    final List<Map<String, String>> sliderItems = [
      {
        'image': 'assets/images/banner_1.png',
        'title': 'Premium Design',
      },
      {
        'image': 'assets/images/banner_2.png',
        'title': 'Tech Innovation',
      },
      {
        'image': 'assets/images/banner_3.png',
        'title': 'Organic Growth',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "MYSELF APP",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
            onPressed: () {
              // Keeping original notifications logic or linking to a new notification center if needed
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.deepPurpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Colors.blueAccent),
              ),
              accountName: const Text(
                "MySelf App User",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: const Text("user@myselfapp.ai"),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(
                    icon: Icons.dashboard_rounded,
                    title: "Dashboard",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DashboardPage()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.analytics_rounded,
                    title: "Analytics",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AnimationPage()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.stars_rounded,
                    title: "My Rewards",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RewardsPage()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.security_rounded,
                    title: "Security & Privacy",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SecurityPage()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.card_membership_rounded,
                    title: "Subscription",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SubscriptionPage()),
                      );
                    },
                  ),
                  const Divider(),
                  _buildDrawerItem(
                    icon: Icons.help_outline_rounded,
                    title: "Support",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SupportPage()),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    icon: Icons.info_outline_rounded,
                    title: "About",
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: "MySelf App",
                        applicationVersion: "1.0.0",
                        applicationIcon: const Icon(Icons.auto_awesome, color: Colors.blueAccent),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Version 1.0.0",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: sliderItems.map((item) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsPage(
                        title: item['title']!,
                        imagePath: item['image']!,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    child: Hero(
                      tag: item['image']!,
                      child: Image.asset(
                        item['image']!,
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                  ),
                ),
              )).toList(),
            ),
      
            const SizedBox(height: 40),
      
            const Icon(Icons.auto_awesome_rounded, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 20),
            const Text(
              "Welcome to MySelf App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Text(
                "Explore our premium 3D experiences and modern design interface.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text("Get Started"),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    );
  }
}
