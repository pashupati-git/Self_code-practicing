import 'package:flutter/material.dart';

//In this page, how security measures can be done while app making will be implemented.
class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security & Privacy'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Two-Factor Authentication'),
            subtitle: const Text('Secure your account with 2FA'),
            value: true,
            onChanged: (val) {},
          ),
          SwitchListTile(
            title: const Text('Biometric Login'),
            subtitle: const Text('Use fingerprint or FaceID'),
            value: false,
            onChanged: (val) {},
          ),
          ListTile(
            title: const Text('Change Password'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Privacy Settings'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
