import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'provider/subject_details_provider.dart';

class SubjectDetailsScreen extends StatelessWidget {
  const SubjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SubjectDetailsProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Subject Details'),
        body: Consumer<SubjectDetailsProvider>(
          builder: (context, provider, child) {
            return const Center(child: Text('Subject Details Screen Content'));
          },
        ),
      ),
    );
  }
}
