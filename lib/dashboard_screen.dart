import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/onboarding1.png'),
          Image.asset('assets/images/onboarding2.png'),
          Image.asset('assets/images/onboarding3.png'),
        ],
      ),
    );
  }
}
