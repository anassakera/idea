// ignore_for_file: unused_import

// Flutter imports
import 'package:flutter/material.dart';

// Routes
import 'package:idea/routes/app_routes.dart';

// App Flow Screens
import 'package:idea/screens/splash/splash_screen.dart';
import 'package:idea/screens/onboarding/onboarding_screen.dart';
import 'package:idea/screens/account_type/account_type_screen.dart';

// Authentication Screens
import 'package:idea/screens/login/login_screen.dart';
import 'package:idea/screens/register_student/register_student_screen.dart';
import 'package:idea/screens/register_parent/register_parent_screen.dart';
import 'package:idea/screens/forgot_password/forgot_password_screen.dart';

// Main App Screens
import 'package:idea/screens/dashboard/dashboard_screen.dart';
import 'package:idea/screens/library/library_screen.dart';

// Document Flow Screens
import 'package:idea/screens/upload_document/upload_document_screen.dart';
import 'package:idea/screens/analysis_loading/analysis_loading_screen.dart';
import 'package:idea/screens/document_details/document_details_screen.dart';
import 'package:idea/screens/learning_resources/learning_resources_screen.dart';

// Quiz Flow Screens
import 'package:idea/screens/quiz_preview/quiz_preview_screen.dart';
import 'package:idea/screens/quiz_interface/quiz_interface_screen.dart';
import 'package:idea/screens/quiz_review/quiz_review_screen.dart';
import 'package:idea/screens/quiz_result/quiz_result_screen.dart';
import 'package:idea/screens/error_review/error_review_screen.dart';

// Statistics & Reports Screens
import 'package:idea/screens/statistics/statistics_screen.dart';
import 'package:idea/screens/subject_details/subject_details_screen.dart';

// Goals & Gamification Screens
import 'package:idea/screens/goals/goals_screen.dart';
import 'package:idea/screens/achievements/achievements_screen.dart';

// Profile & Settings Screens
import 'package:idea/screens/profile/profile_screen.dart';
import 'package:idea/screens/settings/settings_screen.dart';
import 'package:idea/screens/link_parent/link_parent_screen.dart';

// Parent Screens
import 'package:idea/screens/parent_dashboard/parent_dashboard_screen.dart';

// Models
import 'package:idea/screens/quiz_preview/model/quiz_preview_model.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(elevation: 0, centerTitle: true),
      ),
      // Start with splash screen for proper app flow
      initialRoute: AppRoutes.splash,
      routes: {
        // ========================================
        // App Flow Routes
        // ========================================
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.accountType: (context) => const AccountTypeScreen(),

        // ========================================
        // Authentication Routes
        // ========================================
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.registerStudent: (context) => const RegisterStudentScreen(),
        AppRoutes.registerParent: (context) => const RegisterParentScreen(),
        AppRoutes.forgotPassword: (context) => const ForgotPasswordScreen(),

        // ========================================
        // Main App Routes
        // ========================================
        AppRoutes.dashboard: (context) => const DashboardScreen(),
        AppRoutes.library: (context) => const LibraryScreen(),

        // ========================================
        // Document Flow Routes
        // ========================================
        AppRoutes.uploadDocument: (context) => const UploadDocumentScreen(),
        AppRoutes.analysisLoading: (context) => const AnalysisLoadingScreen(),
        AppRoutes.documentDetails: (context) => const DocumentDetailsScreen(),
        AppRoutes.learningResources: (context) =>
            const LearningResourcesScreen(),

        // ========================================
        // Quiz Flow Routes
        // ========================================
        // Note: These routes use dummy data for demo purposes
        // In production, pass actual data via route arguments
        AppRoutes.quizPreview: (context) =>
            const QuizPreviewScreen(quizId: "dummy_id"),
        AppRoutes.quizInterface: (context) => QuizInterfaceScreen(
          quiz: QuizPreviewModel(
            id: "dummy",
            title: "Demo Quiz",
            subject: "General",
            questionCount: 2,
            estimatedTimeMinutes: 5,
            difficulty: "Easy",
            questions: [
              QuestionPreview(
                number: 1,
                text: "Question 1",
                type: "Multiple Choice",
              ),
              QuestionPreview(
                number: 2,
                text: "Question 2",
                type: "True/False",
              ),
            ],
          ),
        ),
        AppRoutes.quizReview: (context) => const QuizReviewScreen(
          totalQuestions: 5,
          answers: {0: "A", 1: "True"},
          flaggedQuestions: {2},
        ),
        AppRoutes.quizResult: (context) => const QuizResultScreen(
          score: 85,
          totalQuestions: 10,
          correctAnswers: 8,
          wrongAnswers: 1,
          skippedAnswers: 1,
          timeTaken: "05:30",
        ),
        AppRoutes.errorReview: (context) => const ErrorReviewScreen(),

        // ========================================
        // Statistics & Reports Routes
        // ========================================
        AppRoutes.statistics: (context) => const StatisticsScreen(),
        AppRoutes.subjectDetails: (context) => const SubjectDetailsScreen(),

        // ========================================
        // Goals & Gamification Routes
        // ========================================
        AppRoutes.goals: (context) => const GoalsScreen(),
        AppRoutes.achievements: (context) => const AchievementsScreen(),

        // ========================================
        // Profile & Settings Routes
        // ========================================
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.settings: (context) => const SettingsScreen(),
        AppRoutes.linkParent: (context) => const LinkParentScreen(),

        // ========================================
        // Parent Routes
        // ========================================
        AppRoutes.parentDashboard: (context) => const ParentDashboardScreen(),
      },
    );
  }
}
