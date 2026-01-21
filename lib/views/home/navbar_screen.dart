// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/navbar_provider.dart';
// import 'package:product_app/profile/profile_screen.dart';
// import 'package:product_app/views/home/chat_screen.dart';
// import 'package:product_app/views/home/favourite_screen.dart';
// import 'package:product_app/views/home/home_screen.dart';
// import 'package:provider/provider.dart';

// class NavbarScreen extends StatelessWidget {
//   const NavbarScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bottomnavbarProvider = Provider.of<BottomNavbarProvider>(context);

//     final pages = [
//       const HomeScreen(),
//       const ChatScreen(),
//       const FavouriteScreen(),
//       const ProfileScreen()
//     ];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: pages[bottomnavbarProvider.currentIndex],
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(bottom: 12.0),
//         child: PhysicalModel(
//           color: Colors.transparent,
//           elevation: 12,
//           shadowColor: const Color.fromARGB(66, 0, 0, 0),
//           borderRadius: BorderRadius.circular(30),
//           child: CurvedNavigationBar(
//             index: bottomnavbarProvider.currentIndex,
//             height: 60,
//             backgroundColor: Colors.transparent,
//             color: const Color.fromARGB(255, 40, 43, 46),
//             buttonBackgroundColor:
//                 Colors.transparent,
//             animationDuration: const Duration(milliseconds: 300),
//             animationCurve: Curves.easeInOut,
//             onTap: (index) {
//               bottomnavbarProvider.setIndex(index);
//             },
//             items: List.generate(4, (i) {
//               bool isActive = i == bottomnavbarProvider.currentIndex;
//               return Container(
//                 width: 50,
//                 height: 50,
//                 decoration: isActive
//                     ? const BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: LinearGradient(
//                           colors: [
//                             Color(0xFF00A8E8), // Bright Blue
//                             Color(0xFF2BBBAD), // Teal Green
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                       )
//                     : null,
//                 child: Icon(
//                   [
//                     Icons.home_outlined,
//                     Icons.chat,
//                     Icons.favorite_rounded,
//                     Icons.person_outline
//                   ][i],
//                   color: Colors.white,
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
// // class _NavBarItem extends StatelessWidget {
// //   final IconData icon;
// //   final String label;

// //   const _NavBarItem({required this.icon, required this.label});

// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       height: 30,
// //       child: Center(
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Icon(icon, size: 26, color: Colors.white),
// //             if (label.isNotEmpty) ...[
// //               const SizedBox(height: 2),
// //               Text(
// //                 label,
// //                 style: const TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 10,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //             ]
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:product_app/Provider/navbar_provider.dart';
import 'package:product_app/profile/profile_screen.dart';
import 'package:product_app/views/home/favourite_screen.dart';
import 'package:product_app/views/home/home_screen.dart';
import 'package:provider/provider.dart';

class NavbarScreen extends StatelessWidget {
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomnavbarProvider = Provider.of<BottomNavbarProvider>(context);

    final pages = [
      const HomeScreen(),
      const FavouriteScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[bottomnavbarProvider.currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: 12,
          shadowColor: const Color.fromARGB(66, 0, 0, 0),
          borderRadius: BorderRadius.circular(30),
          child: CurvedNavigationBar(
            index: bottomnavbarProvider.currentIndex,
            height: 60,
            backgroundColor: Colors.transparent,
            color: const Color.fromARGB(255, 40, 43, 46),
            buttonBackgroundColor: Colors.transparent,
            animationDuration: const Duration(milliseconds: 300),
            animationCurve: Curves.easeInOut,
            onTap: (index) {
              bottomnavbarProvider.setIndex(index);
            },
            items: List.generate(3, (i) {
              bool isActive = i == bottomnavbarProvider.currentIndex;
              return Container(
                width: 50,
                height: 50,
                decoration: isActive
                    ? const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF00A8E8), // Bright Blue
                            Color(0xFF2BBBAD), // Teal Green
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      )
                    : null,
                child: Icon(
                  [
                    Icons.home_outlined,
                    Icons.favorite_rounded,
                    Icons.person_outline,
                  ][i],
                  color: Colors.white,
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
