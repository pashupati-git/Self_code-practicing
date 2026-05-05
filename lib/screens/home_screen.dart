import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:self_code/screens/details_page.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
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
        
              const Icon(Icons.home_rounded, size: 100, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                "Home Screen",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Text(
                  "Tap on any slider image above to see the new details page transition!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
