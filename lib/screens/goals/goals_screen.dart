import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'provider/goals_provider.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GoalsProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Goals'),
        body: Consumer<GoalsProvider>(
          builder: (context, provider, child) {
            return const Center(child: Text('Goals Screen Content'));
          },
        ),
      ),
    );
  }
}
