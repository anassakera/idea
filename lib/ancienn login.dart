// import 'package:flutter/material.dart';
// import 'package:idea/routes/app_routes.dart';
// import 'package:provider/provider.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:idea/screens/login/provider/auth_provider.dart';
// import 'package:idea/screens/login/widgets/social_login_button.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => AuthProvider(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Consumer<AuthProvider>(
//           builder: (context, provider, child) {
//             return SafeArea(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 20),
//                     Center(
//                       child: Container(
//                         height: 80,
//                         width: 80,
//                         decoration: BoxDecoration(
//                           color: Colors.blueAccent.withValues(alpha: 0.1),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.school_rounded,
//                           size: 40,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     Text(
//                       'Welcome Back!',
//                       style: GoogleFonts.poppins(
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       'Login to continue your learning journey.',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 40),
//                     TextField(
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         prefixIcon: const Icon(Icons.email_outlined),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       obscureText: !provider.isPasswordVisible,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         prefixIcon: const Icon(Icons.lock_outline),
//                         suffixIcon: IconButton(
//                           icon: Icon(
//                             provider.isPasswordVisible
//                                 ? Icons.visibility
//                                 : Icons.visibility_off,
//                           ),
//                           onPressed: provider.togglePasswordVisibility,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () => Navigator.pushNamed(
//                           context,
//                           AppRoutes.forgotPassword,
//                         ),
//                         child: Text(
//                           'Forgot Password?',
//                           style: GoogleFonts.poppins(
//                             color: Colors.blueAccent,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 55,
//                       child: ElevatedButton(
//                         onPressed: provider.isLoading
//                             ? null
//                             : () => provider.login(
//                                 'test@test.com',
//                                 'password',
//                                 context,
//                               ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blueAccent,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: provider.isLoading
//                             ? const CircularProgressIndicator(
//                                 color: Colors.white,
//                               )
//                             : Text(
//                                 'Login',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     Row(
//                       children: [
//                         Expanded(child: Divider(color: Colors.grey[300])),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: Text(
//                             'OR',
//                             style: GoogleFonts.poppins(color: Colors.grey[500]),
//                           ),
//                         ),
//                         Expanded(child: Divider(color: Colors.grey[300])),
//                       ],
//                     ),
//                     const SizedBox(height: 30),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SocialLoginButton(
//                           text: 'Google',
//                           icon: Icons.g_mobiledata,
//                           color: Colors.red,
//                           onPressed: () {},
//                         ),
//                         SocialLoginButton(
//                           text: 'Facebook',
//                           icon: Icons.facebook,
//                           color: Colors.blue,
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 40),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Don\'t have an account?',
//                           style: GoogleFonts.poppins(color: Colors.grey[600]),
//                         ),
//                         TextButton(
//                           onPressed: () => provider.navigateToRegister(context),
//                           child: Text(
//                             'Sign Up',
//                             style: GoogleFonts.poppins(
//                               color: Colors.blueAccent,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
