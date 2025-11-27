/// Application route constants organized by feature area
class AppRoutes {
  // ============================================================================
  // App Flow Routes - Initial app flow screens
  // ============================================================================

  /// Splash screen - Initial loading screen
  static const String splash = '/';

  /// Onboarding screen - First-time user experience
  static const String onboarding = '/onboarding';

  /// Account type selection screen - Choose between student/parent account
  static const String accountType = '/account_type';

  // ============================================================================
  // Authentication Routes - Login, registration, and password recovery
  // ============================================================================

  /// Login screen - User authentication
  static const String login = '/login';

  /// Student registration screen
  static const String registerStudent = '/register_student';

  /// Parent registration screen
  static const String registerParent = '/register_parent';

  /// Forgot password screen - Password recovery flow
  static const String forgotPassword = '/forgot_password';

  // ============================================================================
  // Main App Routes - Core application screens
  // ============================================================================

  /// Dashboard screen - Main hub after login
  static const String dashboard = '/dashboard';

  /// Library screen - Saved documents and resources
  static const String library = '/library';

  // ============================================================================
  // Document Flow Routes - Document upload and processing
  // ============================================================================

  /// Upload document screen - Upload new documents for analysis
  static const String uploadDocument = '/upload_document';

  /// Analysis loading screen - Shows progress while analyzing document
  static const String analysisLoading = '/analysis_loading';

  /// Document details screen - View detailed document information
  static const String documentDetails = '/document_details';

  /// Learning resources screen - Additional learning materials
  static const String learningResources = '/learning_resources';

  // ============================================================================
  // Quiz Flow Routes - Quiz taking and review experience
  // ============================================================================

  /// Quiz preview screen - Overview before starting quiz
  static const String quizPreview = '/quiz_preview';

  /// Quiz interface screen - Active quiz taking interface
  static const String quizInterface = '/quiz_interface';

  /// Quiz review screen - Review answers before submission
  static const String quizReview = '/quiz_review';

  /// Quiz result screen - Final quiz score and statistics
  static const String quizResult = '/quiz_result';

  /// Error review screen - Review incorrect answers
  static const String errorReview = '/error_review';

  // ============================================================================
  // Statistics & Reports Routes
  // ============================================================================

  /// Statistics screen - Student performance analysis
  static const String statistics = '/statistics';

  /// Subject details screen - Detailed view of a specific subject
  static const String subjectDetails = '/subject_details';

  // ============================================================================
  // Goals & Gamification Routes
  // ============================================================================

  /// Goals screen - View and manage study goals
  static const String goals = '/goals';

  /// Add/Edit Goal screen
  static const String addEditGoal = '/add_edit_goal';

  /// Achievements screen - Badges, certificates, and rewards
  static const String achievements = '/achievements';

  // ============================================================================
  // Profile & Settings Routes
  // ============================================================================

  /// Profile screen - Student profile and personal info
  static const String profile = '/profile';

  /// Settings screen - App configuration
  static const String settings = '/settings';

  /// Link Parent Account screen
  static const String linkParent = '/link_parent';

  // ============================================================================
  // Parent Routes
  // ============================================================================

  /// Parent Dashboard screen
  static const String parentDashboard = '/parent_dashboard';
}
