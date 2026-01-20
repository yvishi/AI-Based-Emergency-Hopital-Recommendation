import 'package:flutter/material.dart';
import 'emergency_map_screen.dart';

class EmergencyChoiceScreen extends StatelessWidget {
  const EmergencyChoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Who needs help?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              _choiceButton(context, label: "For Me", isSelf: true),

              const SizedBox(height: 16),

              _choiceButton(context, label: "For Someone Else", isSelf: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _choiceButton(
    BuildContext context, {
    required String label,
    required bool isSelf,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EmergencyMapScreen(isSelf: isSelf),
            ),
          );
        },
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
