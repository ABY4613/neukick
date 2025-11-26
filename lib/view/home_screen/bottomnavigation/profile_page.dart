import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shoe_store/utilits/color_const.dart';
import 'package:shoe_store/view/auth/login_screen/login_screen.dart';
import 'package:shoe_store/view/profile_screen/personal_information_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String userName = "Hari"; // Replace with actual user data
  final String userEmail = "hari@example.com"; // Replace with actual user data

  Widget _buildProfileOption({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    bool showDivider = true,
    Color? iconColor,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: (iconColor ?? ColorConstants.PRIMARYCOLOR).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: iconColor ?? ColorConstants.PRIMARYCOLOR,
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
          onTap: onTap,
        ),
        if (showDivider)
          const Divider(
            height: 1,
            indent: 70,
          ),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.montserrat(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: Text(
                'Logout',
                style: GoogleFonts.montserrat(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PersonalInformationScreen(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: ColorConstants.PRIMARYCOLOR,
                            child: Text(
                              userName[0].toUpperCase(),
                              style: GoogleFonts.montserrat(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            userName,
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            userEmail,
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              const SizedBox(height: 16),
              _buildProfileOption(
                title: 'Personal Information',
                icon: Icons.person_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalInformationScreen(),
                    ),
                  );
                },
              ),
              _buildProfileOption(
                title: 'Privacy Policy',
                icon: Icons.privacy_tip_outlined,
                onTap: () {
                  // Navigate to Privacy Policy screen
                },
              ),
              _buildProfileOption(
                title: 'Terms & Conditions',
                icon: Icons.description_outlined,
                onTap: () {
                  // Navigate to Terms & Conditions screen
                },
              ),
              _buildProfileOption(
                title: 'FAQ & Help',
                icon: Icons.help_outline,
                onTap: () {
                  // Navigate to FAQ & Help screen
                },
              ),
              _buildProfileOption(
                title: 'Logout',
                icon: Icons.logout,
                iconColor: Colors.red,
                showDivider: false,
                onTap: _showLogoutDialog,
              ),
              const SizedBox(height: 24),
              Text(
                'Version 1.0.0',
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
