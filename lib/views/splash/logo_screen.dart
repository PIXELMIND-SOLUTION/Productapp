import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/views/auth/login_screen.dart';
import 'package:product_app/views/home/navbar_screen.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Setup animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Position animation from bottom to center
    _positionAnimation = Tween<Offset>(
      begin: const Offset(0, 2.5), // Start from bottom
      end: Offset.zero, // End at center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack, // Slight bounce effect at the end
    ));

    // Fade animation for smooth appearance
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Start animation
    _controller.forward();

    // Navigate after animation + delay
    _initialize();
  }

  Future<void> _initialize() async {
    // Wait for animation to complete (1 second) plus 1 more second
    await Future.delayed(const Duration(seconds: 2));

    final bool hasValidSession = SharedPrefHelper.hasValidSession();

    if (!mounted) return;

    if (hasValidSession) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavbarScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
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
      body: Column(
        children: [
          /// Top section — animated logo from bottom to center
          Expanded(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _positionAnimation,
                  child: Image.asset(
                    'assets/images/splash1.png',
                    width: 180,
                  ),
                ),
              ),
            ),
          ),

          /// Bottom section — city skyline pinned to bottom
          Image.asset(
            'assets/images/splash2.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }
}