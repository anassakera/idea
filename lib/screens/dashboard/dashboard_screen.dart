import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idea/screens/dashboard/provider/dashboard_provider.dart';
import 'package:idea/screens/dashboard/widgets/dashboard_header.dart';
import 'package:idea/screens/dashboard/widgets/welcome_card.dart';
import 'package:idea/screens/dashboard/widgets/quick_stats_card.dart';
import 'package:idea/screens/dashboard/widgets/subjects_grid.dart';
import 'package:idea/screens/dashboard/widgets/recent_activity_list.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const DashboardHeader(),
                    const SizedBox(height: 24),
                    const WelcomeCard(),
                    const SizedBox(height: 24),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuickStatsCard(
                          title: 'Quizzes',
                          value: '12',
                          icon: Icons.quiz,
                          color: Colors.purple,
                        ),
                        QuickStatsCard(
                          title: 'Average',
                          value: '78%',
                          icon: Icons.analytics,
                          color: Colors.blue,
                        ),
                        QuickStatsCard(
                          title: 'Streak',
                          value: '5 Days',
                          icon: Icons.local_fire_department,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'My Subjects',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const SubjectsGrid(),
                    const SizedBox(height: 24),
                    Text(
                      'Recent Activity',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const RecentActivityList(),
                    const SizedBox(height: 80), // Space for FAB
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: Consumer<DashboardProvider>(
          builder: (context, provider, child) {
            return FloatingActionButton.extended(
              onPressed: () => provider.navigateToUpload(context),
              backgroundColor: Colors.blueAccent,
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                'New Quiz',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
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
              onDestinationSelected: provider.setIndex,
              backgroundColor: Colors.white,
              elevation: 5,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.library_books_outlined),
                  selectedIcon: Icon(Icons.library_books),
                  label: 'Library',
                ),
                NavigationDestination(
                  icon: Icon(Icons.bar_chart_outlined),
                  selectedIcon: Icon(Icons.bar_chart),
                  label: 'Stats',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
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
