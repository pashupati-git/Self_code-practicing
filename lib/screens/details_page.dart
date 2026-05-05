import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final String imagePath;

  const DetailsPage({
    super.key,
    required this.title,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Hero(
            tag: imagePath,
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Detailed information about this specific banner. This page is reached by clicking on the slider items on the Home screen. You can add more interactive elements, descriptions, and call-to-action buttons here.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Go Back"),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
