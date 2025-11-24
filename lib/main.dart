import 'package:flutter/material.dart';
import 'package:idea/routes/app_routes.dart';
import 'package:idea/screens/login/login_screen.dart';
import 'package:idea/screens/splash/splash_screen.dart';
import 'package:idea/screens/onboarding/onboarding_screen.dart';
import 'package:idea/screens/account_type/account_type_screen.dart';
import 'package:idea/screens/register_student/register_student_screen.dart';
import 'package:idea/screens/register_parent/register_parent_screen.dart';
import 'package:idea/screens/forgot_password/forgot_password_screen.dart';
import 'package:idea/screens/dashboard/dashboard_screen.dart';
import 'package:idea/screens/upload_document/upload_document_screen.dart';
import 'package:idea/screens/analysis_loading/analysis_loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Edu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.accountType: (context) => const AccountTypeScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.registerStudent: (context) => const RegisterStudentScreen(),
        AppRoutes.registerParent: (context) => const RegisterParentScreen(),
        AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),
        AppRoutes.dashboard: (context) => const DashboardScreen(),
        AppRoutes.uploadDocument: (context) => const UploadDocumentScreen(),
        AppRoutes.analysisLoading: (context) => const AnalysisLoadingScreen(),
      },
    );
  }
}
