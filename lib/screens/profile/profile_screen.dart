import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:idea/routes/app_routes.dart';
import '../../shared/widgets/custom_app_bar.dart';
import 'provider/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Profile'),
        body: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // User Info Placeholder
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFF525CEB),
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "Student Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 32),

                // Menu Items
                _buildProfileItem(
                  context,
                  icon: Icons.flag_rounded,
                  title: "My Goals",
                  route: AppRoutes.goals,
                ),
                _buildProfileItem(
                  context,
                  icon: Icons.emoji_events_rounded,
                  title: "Achievements",
                  route: AppRoutes.achievements,
                ),
                _buildProfileItem(
                  context,
                  icon: Icons.settings_rounded,
                  title: "Settings",
                  route: AppRoutes.settings,
                ),
                _buildProfileItem(
                  context,
                  icon: Icons.family_restroom_rounded,
                  title: "Link Parent Account",
                  route: AppRoutes.linkParent,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.logout_rounded,
                    color: Colors.redAccent,
                  ),
                  title: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onTap: () {
                    // Handle logout
                    Navigator.pushReplacementNamed(context, AppRoutes.login);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF525CEB).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF525CEB)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
