import 'package:flutter/material.dart';
import 'package:product_app/Provider/auth/login_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/profile/edit_profile.dart';
import 'package:product_app/views/auth/login_screen.dart';
import 'package:product_app/views/deleteaccount/delete_account.dart';
import 'package:product_app/views/home/navbar_screen.dart';
import 'package:product_app/views/location/location_screen.dart';
import 'package:product_app/views/posting/posting_details.dart';
import 'package:product_app/views/widgets/app_back_control.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: AppBackControl(
        child: SafeArea(
          child: Column(
            children: [
                          _buildHeader(),
        
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  children: [
                    // ── Personal Info (highlighted) ──
                    _ProfileTile(
                      icon: Icons.person_outline,
                      title: "Personal information",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditProfile()),
                        );
                      },
                      isHighlighted: true,
                    ),
                
                    const SizedBox(height: 12),
                
                    // ── Change Address ──
                    _ProfileTile(
                      icon: Icons.location_on_outlined,
                      title: "Change Address",
                      onTap: () {
                        final userId = SharedPrefHelper.getUserId();
                        if (userId == null || userId.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User ID not found')),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationFetchScreen(userId: userId),
                          ),
                        );
                      },
                    ),
                
                    const SizedBox(height: 12),
                
                    // ── My Postings ──
                    _ProfileTile(
                      icon: Icons.grid_view_outlined,
                      title: "My Postings",
                      onTap: () {
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const NavbarScreen(initialIndex: 3),
  ),
);
                      },
                    ),
                    const SizedBox(height: 12),
        
                                      // ── Help section label ──
                    Text(
                      "Support",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
        
                                  const SizedBox(height: 12),
                
                    // ── About Us ──
                    _ProfileTile(
                      icon: Icons.info_outline,
                      title: "About Us",
                      onTap: () => _launchURL(
                          'https://product-web-rho-tan.vercel.app/home',
                          context),
                    ),
                
                    const SizedBox(height: 12),
                
                    // ── Contact Us ──
                    _ProfileTile(
                      icon: Icons.phone_outlined,
                      title: "Contact Us",
                      onTap: () => _launchURL(
                          'https://estatehouz.onrender.com/contact',
                          context),
                    ),
                
            
                
                    const SizedBox(height: 24),
                
                
                    const SizedBox(height: 24),
                
                    // ── Account section label ──
                    Text(
                      "Account & Terms",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                
                    const SizedBox(height: 12),
                
                    // ── Privacy Policy ──
                    _ProfileTile(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy Policy",
                      onTap: () => _launchURL(
                          'https://estatehouz.onrender.com/privacy-policy',
                          context),
                    ),
                
                    const SizedBox(height: 12),
                
                    // ── Terms & Conditions ──
                    _ProfileTile(
                      icon: Icons.description_outlined,
                      title: "Terms & Conditions",
                      onTap: () => _launchURL(
                          'https://estatehouz.onrender.com/terms-and-conditions',
                          context),
                    ),
                
                    const SizedBox(height: 22),
                
                    // ── Delete Account ──
                    _ProfileTile(
                      icon: Icons.delete_outline,
                      title: "Delete Account",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DeleteAccount()),
                        );
                      },
                      isDelete: true,
                    ),
                
                    const SizedBox(height: 24),
                
                    // ── Logout ──
                    _ProfileTile(
                      icon: Icons.logout_rounded,
                      title: "Logout",
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            title: const Text('Confirm Logout'),
                            content: const Text('Are you sure you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final authProvider =
                                      Provider.of<AuthProvider>(context, listen: false);
                                  await authProvider.logout();
                                  if (context.mounted) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                                      (route) => false,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Color(0xFFE33629)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      isLogout: true,
                    ),
                
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}


  Widget _buildHeader() {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height:20),
            Divider(),
          ],
        ),
      ),
    );
  }

// ── Profile Tile (exact same as first UI) ────────────────────────────────────

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isHighlighted;
  final bool isLogout;
  final bool isDelete;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isHighlighted = false,
    this.isLogout = false,
    this.isDelete = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color contentColor = isHighlighted || isLogout || isDelete
        ? (isDelete ? Colors.red : const Color(0xFFE33629))
        : Colors.black87;

    final Border border = isHighlighted
        ? Border.all(color: const Color(0xFFE33629), width: 1.2)
        : isLogout
            ? Border.all(color: const Color(0xFFE33629).withOpacity(0.4), width: 1.2)
            : isDelete
                ? Border.all(color: Colors.red.withOpacity(0.4), width: 1.2)
                : Border.all(color: Colors.grey.shade200);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: border,
        ),
        child: Row(
          children: [
            // Icon
            Icon(icon, size: 20, color: contentColor),

            const SizedBox(width: 12),

            // Title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isHighlighted || isLogout || isDelete
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: contentColor,
                ),
              ),
            ),

            // Arrow
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: contentColor,
            ),
          ],
        ),
      ),
    );
  }
}