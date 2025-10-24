// import 'package:flutter/material.dart';

// class LogoScreen extends StatelessWidget {
//   const LogoScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white, 
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(height: 70,), 

//             Center(
//               child: Image.asset(
//                 'lib/assets/splashscreenlogo.png',
//                 height: 190,
//               ),
//             ),

           
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: Image.asset(
//                 'lib/assets/345bd60d710065fe219bdc89188a2907600d3f0f.png',
//                 height: 190,
              
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product_app/views/auth/login_screen.dart';
import 'package:product_app/views/home/option_screen.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Setup fade-in animation
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    // Navigate to next screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(height: 70),

              // Top logo
              Center(
                child: Image.asset(
                  'lib/assets/splashscreenlogo.png',
                  height: 190,
                ),
              ),

              // Bottom image
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Image.asset(
                  'lib/assets/345bd60d710065fe219bdc89188a2907600d3f0f.png',
                  height: 190,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy HomeScreen to navigate to
