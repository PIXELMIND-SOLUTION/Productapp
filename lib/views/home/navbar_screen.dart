import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_app/Provider/navbar_provider.dart';
import 'package:product_app/profile/profile_screen.dart';
import 'package:product_app/views/home/favourite_screen.dart';
import 'package:product_app/views/home/home_screen.dart';
import 'package:product_app/views/home/sell/sell.dart';
import 'package:product_app/views/posting/posting_details.dart';
import 'package:provider/provider.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    final bottomnavbarProvider =
        Provider.of<BottomNavbarProvider>(context, listen: false);

    // If NOT on home tab → go to home
    if (bottomnavbarProvider.currentIndex != 0) {
      bottomnavbarProvider.setIndex(0);
      return false;
    }

    // If already on home → show exit dialog
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Do you want to close the app?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );

    if (shouldExit == true) {
      SystemNavigator.pop(); // Close app
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bottomnavbarProvider = Provider.of<BottomNavbarProvider>(context);

    final pages = [
      const HomeScreen(),
      const FavouriteScreen(),
      const SellScreen(),
      const PostingDetails(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: pages[bottomnavbarProvider.currentIndex],
        bottomNavigationBar: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                icon: Icons.home_outlined,
                label: 'Home',
                isActive: bottomnavbarProvider.currentIndex == 0,
                onTap: () => bottomnavbarProvider.setIndex(0),
              ),
              _buildNavItem(
                icon: Icons.favorite_border,
                label: 'Fav',
                isActive: bottomnavbarProvider.currentIndex == 1,
                onTap: () => bottomnavbarProvider.setIndex(1),
              ),

              // Center Upload Button
              GestureDetector(
                onTap: () => bottomnavbarProvider.setIndex(2),
                child: Container(
                  width: 56,
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE33629), Color(0xFFB41B16)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color(0xFFE33629).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),

              _buildNavItem(
                icon: Icons.grid_view_outlined,
                label: 'Post',
                isActive: bottomnavbarProvider.currentIndex == 3,
                onTap: () => bottomnavbarProvider.setIndex(3),
              ),
              _buildNavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                isActive: bottomnavbarProvider.currentIndex == 4,
                onTap: () => bottomnavbarProvider.setIndex(4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive
                ? const Color(0xFFE33629)
                : Colors.grey.shade400,
            size: 22,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isActive
                  ? const Color(0xFFE33629)
                  : Colors.grey.shade400,
              fontWeight:
                  isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}