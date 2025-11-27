import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'provider/parent_dashboard_provider.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParentDashboardProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Parent Dashboard'),
        body: Consumer<ParentDashboardProvider>(
          builder: (context, provider, child) {
            return const Center(child: Text('Parent Dashboard Screen Content'));
          },
        ),
      ),
    );
  }
}
