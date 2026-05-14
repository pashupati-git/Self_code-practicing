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
      /// The `appBar: AppBar` in the `Scaffold` widget is specifying the app bar that will be displayed
      /// at the top of the screen in the `AnalyticsPage`. The `AppBar` widget allows you to create a
      /// material design app bar with various customization options such as title, background color,
      /// foreground color, actions, etc. In this case, the app bar will have a title of 'Analytics'
      /// with a pink accent background color and white foreground color.
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// The line `Icon(Icons.bar_chart_rounded, size: 100, color: Colors.pinkAccent[100])` in
            /// the code snippet is creating an `Icon` widget that displays a bar chart icon with
            /// specific size and color.
            Icon(Icons.bar_chart_rounded, size: 100, color: Colors.pinkAccent[100]),
            const SizedBox(height: 20),
            const Text(
              "Analytics Data Coming Soon",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
           /// The `const Padding` widget in the code snippet is used to create padding around its child
           /// widget, which in this case is a `Text` widget displaying a message.
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
