import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'provider/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Settings'),
        body: Consumer<SettingsProvider>(
          builder: (context, provider, child) {
            return const Center(child: Text('Settings Screen Content'));
          },
        ),
      ),
    );
  }
}
