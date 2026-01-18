import 'package:flutter/material.dart';
import 'screens/landing/landing_screen.dart';

void main() {
  runApp(const PulseAI());
}

class PulseAI extends StatelessWidget {
  const PulseAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pulse AI',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const LandingScreen(),
    );
  }
}
