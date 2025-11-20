import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea/routes/app_routes.dart';
import 'package:idea/screens/account_type/widgets/account_type_card.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Who are you?',
              style: GoogleFonts.poppins(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Choose your account type to continue.',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 40),
            AccountTypeCard(
              title: 'Student',
              description: 'I want to study and take quizzes.',
              icon: Icons.school_rounded,
              color: Colors.blueAccent,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
            ),
            AccountTypeCard(
              title: 'Parent',
              description: 'I want to monitor my child\'s progress.',
              icon: Icons.family_restroom_rounded,
              color: Colors.orangeAccent,
              onTap: () {
                // For now, both go to login, but logic can differ later
                Navigator.pushNamed(context, AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
