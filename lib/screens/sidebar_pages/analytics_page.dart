import 'package:flutter/material.dart';


///In this page,how small animations lik eesewa (animation on icons,>) will be done.
///animations inside icons like in more icon,there will be 4 small icons inside icons
///and that icons move in circular way.
///
class AnalyticsPage extends StatelessWidget {
  /// The line `const AnalyticsPage({super.key});` in the code snippet is defining a constructor for the
  /// `AnalyticsPage` class. In Dart, constructors are special methods used for creating instances of a
  /// class.
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart_rounded, size: 100, color: Colors.pinkAccent[100]),
            const SizedBox(height: 20),
            const Text(
              "Analytics Data Coming Soon",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "We are currently processing your activity data. Please check back later.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
