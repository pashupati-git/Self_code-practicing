import 'package:flutter/material.dart';


///in this page.App related terms like system behaviour, how code and anfroid systems are 
///interacting with each other, how native performance can be made peak for both android and ios 
///will be studied and disacussed.
///
class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_rounded, size: 100, color: Colors.orange[300]),
            const SizedBox(height: 20),
            const Text(
              "Your history is empty",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
