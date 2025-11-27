import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'provider/achievements_provider.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AchievementsProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Achievements'),
        body: Consumer<AchievementsProvider>(
          builder: (context, provider, child) {
            return const Center(child: Text('Achievements Screen Content'));
          },
        ),
      ),
    );
  }
}
