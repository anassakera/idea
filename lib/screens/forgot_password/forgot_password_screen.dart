import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea/screens/forgot_password/provider/forgot_password_provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isIconScaled = false;

  // Controllers for all text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: const Color(0xFF3D3B40).withValues(alpha: 0.6),
      ),
      prefixIcon: Icon(prefixIcon, color: const Color(0xFF525CEB)),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF525CEB), width: 1.5),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback? onPressed,
    required bool isLoading,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF525CEB).withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF525CEB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildEmailEntryStep(ForgotPasswordProvider provider) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: _buildInputDecoration(
            labelText: 'Email',
            prefixIcon: Icons.email_outlined,
          ),
        ),
        const SizedBox(height: 30),
        _buildActionButton(
          text: 'Send Reset Code',
          isLoading: provider.isLoading,
          onPressed: provider.isLoading
              ? null
              : () => provider.sendResetLink(_emailController.text, context),
        ),
        const SizedBox(height: 20),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Back to Login',
            style: GoogleFonts.poppins(
              color: const Color(0xFF3D3B40),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCodeEntryStep(ForgotPasswordProvider provider) {
    return Column(
      children: [
        // Info text about the code
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF525CEB).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.info_outline, color: Color(0xFF525CEB)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'A 6-character code was sent to ${provider.userEmail}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF3D3B40),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Reset Code Field
        TextField(
          controller: _codeController,
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.characters,
          maxLength: 6,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
          textAlign: TextAlign.center,
          decoration: _buildInputDecoration(
            labelText: 'Reset Code',
            prefixIcon: Icons.lock_outline,
          ).copyWith(counterText: ''),
        ),
        const SizedBox(height: 16),

        // New Password Field
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: _buildInputDecoration(
            labelText: 'New Password',
            prefixIcon: Icons.lock_reset,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF525CEB),
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Confirm Password Field
        TextField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: _buildInputDecoration(
            labelText: 'Confirm Password',
            prefixIcon: Icons.lock_outline,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: const Color(0xFF525CEB),
              ),
              onPressed: () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Reset Password Button
        _buildActionButton(
          text: 'Reset Password',
          isLoading: provider.isLoading,
          onPressed: provider.isLoading
              ? null
              : () => provider.resetPassword(
                  _codeController.text,
                  _passwordController.text,
                  _confirmPasswordController.text,
                  context,
                ),
        ),
        const SizedBox(height: 16),

        // Resend code link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive the code? ",
              style: GoogleFonts.poppins(
                color: const Color(0xFF3D3B40).withValues(alpha: 0.7),
              ),
            ),
            TextButton(
              onPressed: provider.isLoading
                  ? null
                  : () {
                      provider.goBackToEmailStep();
                      _codeController.clear();
                      _passwordController.clear();
                      _confirmPasswordController.clear();
                    },
              child: Text(
                'Resend',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF525CEB),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordProvider(),
      child: Scaffold(
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
                  leading: Consumer<ForgotPasswordProvider>(
                    builder: (context, provider, child) {
                      return IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xFF3D3B40),
                        ),
                        onPressed: () {
                          if (provider.currentStep == ResetStep.codeEntry) {
                            provider.goBackToEmailStep();
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Consumer<ForgotPasswordProvider>(
                    builder: (context, provider, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              GestureDetector(
                                onTapDown: (_) =>
                                    setState(() => _isIconScaled = true),
                                onTapUp: (_) =>
                                    setState(() => _isIconScaled = false),
                                onTapCancel: () =>
                                    setState(() => _isIconScaled = false),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  padding: const EdgeInsets.all(20),
                                  transform: Matrix4.identity()
                                    ..setEntry(0, 0, _isIconScaled ? 0.9 : 1.0)
                                    ..setEntry(1, 1, _isIconScaled ? 0.9 : 1.0),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF525CEB,
                                    ).withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(
                                          0xFF525CEB,
                                        ).withValues(alpha: 0.2),
                                        blurRadius: 20,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    provider.currentStep == ResetStep.emailEntry
                                        ? Icons.lock_reset_rounded
                                        : Icons.mark_email_read_rounded,
                                    size: 60,
                                    color: const Color(0xFF525CEB),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFF525CEB),
                                        Color(0xFF3D3B40),
                                      ],
                                    ).createShader(bounds),
                                child: Text(
                                  provider.currentStep == ResetStep.emailEntry
                                      ? 'Forgot Password?'
                                      : 'Reset Password',
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                provider.currentStep == ResetStep.emailEntry
                                    ? 'Enter your email address to receive a password reset code.'
                                    : 'Enter the code from your email and set a new password.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: const Color(
                                    0xFF3D3B40,
                                  ).withValues(alpha: 0.7),
                                ),
                              ),
                              const SizedBox(height: 40),

                              // Step-based content
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child:
                                    provider.currentStep == ResetStep.emailEntry
                                    ? _buildEmailEntryStep(provider)
                                    : _buildCodeEntryStep(provider),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
