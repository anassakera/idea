import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea/routes/app_routes.dart';
import 'package:idea/screens/account_type/widgets/account_type_card.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({super.key});

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8EDFF), // Magnolia
              Color(0xFFBFCFE7), // Periwinkle
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xFF3D3B40),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF525CEB), Color(0xFF3D3B40)],
                          ).createShader(bounds),
                          child: Text(
                            'Who are you?',
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Choose your account type to continue.',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(
                              0xFF3D3B40,
                            ).withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 40),
                        AccountTypeCard(
                          title: 'Student',
                          description: 'I want to study and take quizzes.',
                          icon: Icons.school_rounded,
                          color: const Color(0xFF525CEB),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                        ),
                        AccountTypeCard(
                          title: 'Parent',
                          description:
                              'I want to monitor my child\'s progress.',
                          icon: Icons.family_restroom_rounded,
                          color: const Color(0xFF525CEB),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.login);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
