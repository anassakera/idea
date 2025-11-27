import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'provider/statistics_provider.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StatisticsProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Statistics',
        ), // Ensure CustomAppBar constructor matches
        body: Consumer<StatisticsProvider>(
          builder: (context, provider, child) {
            return const Center(child: Text('Statistics Screen Content'));
          },
        ),
      ),
    );
  }
}
