import 'package:flutter/material.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription Plan'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Card(
              color: Colors.deepPurpleAccent,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("PRO PLAN", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text(r"$9.99 / month", style: TextStyle(color: Colors.white70, fontSize: 18)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildFeatureRow("Ad-free experience"),
            _buildFeatureRow("Unlimited 3D exports"),
            _buildFeatureRow("Priority Support"),
            _buildFeatureRow("Early access to new models"),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Upgrade Now"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 10),
          Text(feature, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
