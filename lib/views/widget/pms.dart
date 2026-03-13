// ── Pixelmind (PMS) Animated Logo Button ─────────────────────────────────────
// Place this BEFORE the location IconButton in _buildCustomAppBar()

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PixelmindLogoButton extends StatefulWidget {
  const PixelmindLogoButton();

  @override
  State<PixelmindLogoButton> createState() => _PixelmindLogoButtonState();
}

class _PixelmindLogoButtonState extends State<PixelmindLogoButton>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shimmerController;
  late AnimationController _tapController;

  late Animation<double> _pulseAnim;
  late Animation<double> _shimmerAnim;
  late Animation<double> _tapScaleAnim;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();

    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _pulseAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _shimmerAnim = Tween<double>(begin: -1.5, end: 2.5).animate(
      CurvedAnimation(parent: _shimmerController, curve: Curves.easeInOut),
    );

    _tapScaleAnim = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shimmerController.dispose();
    _tapController.dispose();
    super.dispose();
  }

  Future<void> _launchSite() async {
    final Uri url = Uri.parse('https://www.pixelmindsolutions.com'); // 🔁 Replace with your actual URL
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        _tapController.forward();
        setState(() => _isHovered = true);
      },
      onTapUp: (_) {
        _tapController.reverse();
        setState(() => _isHovered = false);
        _launchSite();
      },
      onTapCancel: () {
        _tapController.reverse();
        setState(() => _isHovered = false);
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_pulseAnim, _shimmerAnim, _tapScaleAnim]),
        builder: (context, _) {
          return Transform.scale(
            scale: _tapScaleAnim.value,
            child: Container(
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    Color.lerp(
                      const Color(0xFF0D0D0D),
                      const Color(0xFF1A1A2E),
                      _pulseAnim.value,
                    )!,
                    Color.lerp(
                      const Color(0xFF1A0533),
                      const Color(0xFF0D1B2A),
                      _pulseAnim.value,
                    )!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.lerp(
                      const Color(0xFF7C3AED).withOpacity(0.3),
                      const Color(0xFF06B6D4).withOpacity(0.5),
                      _pulseAnim.value,
                    )!,
                    blurRadius: 10 + (_pulseAnim.value * 6),
                    spreadRadius: _pulseAnim.value * 1.5,
                    offset: const Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: Color.lerp(
                    const Color(0xFF7C3AED).withOpacity(0.6),
                    const Color(0xFF06B6D4).withOpacity(0.8),
                    _pulseAnim.value,
                  )!,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Shimmer sweep
                    Positioned.fill(
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment(_shimmerAnim.value - 1, -0.3),
                            end: Alignment(_shimmerAnim.value + 0.5, 0.3),
                            colors: [
                              Colors.transparent,
                              Colors.white.withOpacity(0.08),
                              Colors.transparent,
                            ],
                          ).createShader(bounds);
                        },
                        child: Container(color: Colors.white),
                      ),
                    ),

                    // PMS text + pixel dot
Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    // Animated image that changes color/opacity
    AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(180),
        child: Image.asset(
          'assets/images/app_icon_ios.png', // Replace with your asset path
          width: 25,
          height: 25,
          // color: Color.lerp( // Optional: Tint the image with animation
          //   const Color(0xFF7C3AED),
          //   const Color(0xFF06B6D4),
          //   _pulseAnim.value,
          // ),
          fit: BoxFit.contain,
        ),
      ),
    ),
    const SizedBox(width: 5),
    ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Color.lerp(
            const Color(0xFFE879F9),
            const Color(0xFF38BDF8),
            _pulseAnim.value,
          )!,
          Color.lerp(
            const Color(0xFF7C3AED),
            const Color(0xFF06B6D4),
            _pulseAnim.value,
          )!,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: const Text(
        'PMS',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: 1.5,
          height: 1,
        ),
      ),
    ),
  ],
),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}