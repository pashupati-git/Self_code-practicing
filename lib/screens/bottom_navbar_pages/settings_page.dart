import 'dart:isolate';
import 'package:flutter/foundation.dart'; // For compute function
import 'package:flutter/material.dart';

///This file teaches about isolate,how big background tasks are handled -
///     -without freezing the ui and other process.
/// Flutter runs on a single UI thread, isolates doesnot share memory but communicates through message passing.

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with SingleTickerProviderStateMixin {
  bool _isLoading = false;
  String _result = "No task running";
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Animation to show UI responsiveness
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// HEAVY TASK: A simple heavy computation that takes a few seconds.
  /// This simulates a task like parsing a huge JSON or complex image processing.
  static int heavyComputation(int iterations) {
    int sum = 0;
    for (int i = 0; i < iterations; i++) {
      sum += i;
    }
    return sum;
  }

  /// 1. RUNNING ON MAIN THREAD
  /// This will freeze the UI because Flutter's main thread (UI thread)
  /// is occupied with the loop and cannot handle animations or touches.
  void runOnMainThread() {
    setState(() {
      _isLoading = true;
      _result = "Running on Main Thread...";
    });

    // We use a small delay just to let the UI update the text before freezing
    Future.delayed(const Duration(milliseconds: 100), () {
      final start = DateTime.now();
      final sum = heavyComputation(1000000000); // 1 Billion iterations
      final end = DateTime.now();

      setState(() {
        _isLoading = false;
        _result =
            "Main Thread Result: $sum\nTime: ${end.difference(start).inMilliseconds}ms";
      });
    });
  }

  /// 2. RUNNING ON ISOLATE (using compute)
  /// 'compute' is a convenience wrapper for Isolate.spawn.
  /// It runs the function in a separate isolate and returns the result.
  /// The UI remains responsive because the heavy work is offloaded.
  void runOnIsolate() async {
    setState(() {
      _isLoading = true;
      _result = "Running on Isolate...";
    });

    final start = DateTime.now();
    // compute(function, argument)
    // Note: The function must be a top-level or static function.
    final sum = await compute(heavyComputation, 1000000000);
    final end = DateTime.now();

    setState(() {
      _isLoading = false;
      _result =
          "Isolate Result: $sum\nTime: ${end.difference(start).inMilliseconds}ms";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Section ---
            const Text(
              "Explore Isolates",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Learn how Flutter handles multi-threading and heavy tasks.",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 30),

            // --- Animation Section (Responsiveness Indicator) ---
            Center(
              child: Column(
                children: [
                  RotationTransition(
                    turns: _animationController,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.indigo, Colors.purple],
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.indigo.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.sync,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Watch this icon. If it stops, the UI is frozen!",
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // --- Explanation Card ---
            _buildInfoCard(
              "What is an Isolate?",
              "Unlike other languages that use shared-memory threads, Dart uses Isolates. Each isolate has its own memory heap and event loop. They communicate only via messages.",
              Icons.info_outline,
            ),
            const SizedBox(height: 15),

            // --- Main Thread Section ---
            _buildTaskCard(
              title: "Main Thread Task",
              description:
                  "Runs on the UI thread. Will block the event loop and freeze animations.",
              buttonLabel: "Run on Main Thread",
              buttonColor: Colors.redAccent,
              onPressed: _isLoading ? null : runOnMainThread,
            ),
            const SizedBox(height: 15),

            // --- Isolate Section ---
            _buildTaskCard(
              title: "Isolate Task (Worker)",
              description:
                  "Runs on a separate Isolate. UI stays smooth and interactive.",
              buttonLabel: "Run on Isolate",
              buttonColor: Colors.green,
              onPressed: _isLoading ? null : runOnIsolate,
            ),
            const SizedBox(height: 30),

            // --- Result Container ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.indigo.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Output Log",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const Divider(),
                  Text(
                    _result,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String content, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.indigo),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 5),
                Text(content, style: const TextStyle(color: Colors.indigo)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String description,
    required String buttonLabel,
    required Color buttonColor,
    required VoidCallback? onPressed,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(description, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(buttonLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
