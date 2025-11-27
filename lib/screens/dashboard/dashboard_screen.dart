import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea/screens/dashboard/provider/dashboard_provider.dart';
import 'package:idea/screens/dashboard/widgets/dashboard_header.dart';
import 'package:idea/screens/dashboard/widgets/welcome_card.dart';
import 'package:idea/screens/dashboard/widgets/quick_stats_card.dart';
import 'package:idea/screens/dashboard/widgets/subjects_grid.dart';
import 'package:idea/screens/dashboard/widgets/recent_activity_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _showContent = true);
        _slideController.forward();
        _fadeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
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
          child: Consumer<DashboardProvider>(
            builder: (context, provider, child) {
              return SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 600),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 20 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: const DashboardHeader(),
                      ),
                      const SizedBox(height: 24),
                      AnimatedOpacity(
                        opacity: _showContent ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 800),
                        child: const WelcomeCard(),
                      ),
                      const SizedBox(height: 24),
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              QuickStatsCard(
                                title: 'Quizzes',
                                value: '12',
                                icon: Icons.quiz,
                                color: Color(0xFF525CEB),
                              ),
                              QuickStatsCard(
                                title: 'Average',
                                value: '78%',
                                icon: Icons.analytics,
                                color: Color(0xFF525CEB),
                              ),
                              QuickStatsCard(
                                title: 'Streak',
                                value: '5 Days',
                                icon: Icons.local_fire_department,
                                color: Color(0xFF525CEB),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(opacity: value, child: child);
                        },
                        child: Text(
                          'My Subjects',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3D3B40),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: const SubjectsGrid(),
                      ),
                      const SizedBox(height: 24),
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeOut,
                        builder: (context, value, child) {
                          return Opacity(opacity: value, child: child);
                        },
                        child: Text(
                          'Recent Activity',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF3D3B40),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SlideTransition(
                        position: _slideAnimation,
                        child: const RecentActivityList(),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            return TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(scale: value, child: child);
              },
              child: FloatingActionButton.extended(
                onPressed: () => provider.navigateToUpload(context),
                backgroundColor: const Color(0xFF525CEB),
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(
                  'New Quiz',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            return NavigationBar(
              selectedIndex: provider.currentIndex,
              onDestinationSelected: (index) =>
                  provider.handleNavigation(context, index),
              backgroundColor: Colors.white.withValues(alpha: 0.9),
              elevation: 5,
              indicatorColor: const Color(0xFF525CEB).withValues(alpha: 0.2),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home, color: Color(0xFF525CEB)),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.library_books_outlined),
                  selectedIcon: Icon(
                    Icons.library_books,
                    color: Color(0xFF525CEB),
                  ),
                  label: 'Library',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart, color: Color(0xFF525CEB)),
                  label: 'Stats',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person, color: Color(0xFF525CEB)),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
