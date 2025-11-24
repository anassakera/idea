import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea/screens/login/provider/auth_provider.dart';
import 'package:idea/screens/login/widgets/social_login_button.dart';
import 'dart:ui';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _orbController;
  late Animation<double> _fadeAnimation;
  bool _isLogoExpanded = false;

  // Text controllers for form inputs
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Colors from colors.md
  static const Color kMagnolia = Color(0xFFF8EDFF);
  static const Color kPeriwinkle = Color(0xFFBFCFE7);
  static const Color kRoyalBlue = Color(0xFF525CEB);
  static const Color kCharcoal = Color(0xFF3D3B40);

  @override
  void initState() {
    super.initState();
    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);

    final fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: fadeController, curve: Curves.easeIn));

    fadeController.forward();
  }

  @override
  void dispose() {
    _orbController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleLogoScale() {
    setState(() {
      _isLogoExpanded = !_isLogoExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: Scaffold(
        backgroundColor: kMagnolia,
        body: Stack(
          children: [
            // Mesh Gradient Background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _orbController,
                builder: (context, child) {
                  return Stack(
                    children: [
                      // Orb 1
                      Positioned(
                        top: -100 + (_orbController.value * 50),
                        left: -100 + (_orbController.value * 30),
                        child: Container(
                          height: 400,
                          width: 400,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPeriwinkle.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                      // Orb 2
                      Positioned(
                        top: 200 - (_orbController.value * 100),
                        right: -150 + (_orbController.value * 50),
                        child: Container(
                          height: 350,
                          width: 350,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kRoyalBlue.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                      // Orb 3
                      Positioned(
                        bottom: -100 - (_orbController.value * 80),
                        left: 50 + (_orbController.value * 20),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kRoyalBlue.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                      // Blur Filter for Mesh Effect
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                        child: Container(color: Colors.transparent),
                      ),
                    ],
                  );
                },
              ),
            ),
            // Content
            Consumer<AuthProvider>(
              builder: (context, provider, child) {
                return SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              padding: const EdgeInsets.all(32),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: GestureDetector(
                                      onTap: _toggleLogoScale,
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        curve: Curves.easeInOut,
                                        height: _isLogoExpanded ? 100 : 80,
                                        width: _isLogoExpanded ? 100 : 80,
                                        decoration: BoxDecoration(
                                          color: _isLogoExpanded
                                              ? kRoyalBlue.withValues(
                                                  alpha: 0.2,
                                                )
                                              : kRoyalBlue.withValues(
                                                  alpha: 0.1,
                                                ),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: kRoyalBlue.withValues(
                                                alpha: 0.3,
                                              ),
                                              blurRadius: 20,
                                              spreadRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: Icon(
                                          Icons.school_rounded,
                                          size: _isLogoExpanded ? 50 : 40,
                                          color: kRoyalBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                          colors: [kRoyalBlue, kCharcoal],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds),
                                    child: Text(
                                      'Welcome Back!',
                                      style: GoogleFonts.poppins(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Login to continue your learning journey.',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: kCharcoal.withValues(alpha: 0.7),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  TextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(color: kCharcoal),
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: kRoyalBlue,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: kRoyalBlue,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: kRoyalBlue.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: kRoyalBlue,
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextField(
                                    controller: _passwordController,
                                    obscureText: !provider.isPasswordVisible,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(color: kCharcoal),
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: kRoyalBlue,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          provider.isPasswordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: kRoyalBlue,
                                        ),
                                        onPressed:
                                            provider.togglePasswordVisibility,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: kRoyalBlue,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: kRoyalBlue.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: kRoyalBlue,
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        AppRoutes.forgotPassword,
                                      ),
                                      child: Text(
                                        'Forgot Password?',
                                        style: GoogleFonts.poppins(
                                          color: kRoyalBlue,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    width: double.infinity,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: kRoyalBlue.withValues(
                                            alpha: 0.4,
                                          ),
                                          blurRadius: 15,
                                          offset: const Offset(0, 5),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: provider.isLoading
                                          ? null
                                          : () {
                                              // Validate inputs
                                              if (_emailController.text
                                                  .trim()
                                                  .isEmpty) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Please enter your email',
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                                return;
                                              }
                                              if (_passwordController
                                                  .text
                                                  .isEmpty) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Please enter your password',
                                                    ),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                                return;
                                              }

                                              // Call login with actual values
                                              provider.login(
                                                _emailController.text.trim(),
                                                _passwordController.text,
                                                context,
                                              );
                                            },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: kRoyalBlue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: provider.isLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'Login',
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: kCharcoal.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          'OR',
                                          style: GoogleFonts.poppins(
                                            color: kCharcoal.withValues(
                                              alpha: 0.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: kCharcoal.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SocialLoginButton(
                                        text: 'Google',
                                        icon: Icons.g_mobiledata,
                                        color: Colors.red,
                                        onPressed: () {},
                                      ),
                                      SocialLoginButton(
                                        text: 'Facebook',
                                        icon: Icons.facebook,
                                        color: Colors.blue,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Don\'t have an account?',
                                        style: GoogleFonts.poppins(
                                          color: kCharcoal.withValues(
                                            alpha: 0.7,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => provider
                                            .navigateToRegister(context),
                                        child: Text(
                                          'Sign Up',
                                          style: GoogleFonts.poppins(
                                            color: kRoyalBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
