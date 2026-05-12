import 'package:flutter/material.dart';

//In this page,flutter (conditions methods like method properties will logic writing will be implemented)
class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rewards'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildRewardTile('Sign-up Bonus', '500 Points', true),
          _buildRewardTile('First Purchase', '200 Points', true),
          _buildRewardTile('Referral Bonus', '1000 Points', false),
          _buildRewardTile('Weekly Streak', '150 Points', false),
        ],
      ),
    );
  }

  Widget _buildRewardTile(String title, String points, bool claimed) {
    return ListTile(
      leading: const Icon(Icons.stars_rounded, color: Colors.amber),
      title: Text(title),
      subtitle: Text(points),
      trailing: claimed 
        ? const Text('Claimed', style: TextStyle(color: Colors.green))
        : ElevatedButton(onPressed: () {}, child: const Text('Claim')),
    );
  }
}
