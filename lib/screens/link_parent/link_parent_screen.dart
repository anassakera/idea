import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'provider/link_parent_provider.dart';

class LinkParentScreen extends StatelessWidget {
  const LinkParentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LinkParentProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Link Parent Account'),
        body: Consumer<LinkParentProvider>(
          builder: (context, provider, child) {
            return const Center(child: Text('Link Parent Screen Content'));
          },
        ),
      ),
    );
  }
}
