import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PMSAdvertBanner extends StatefulWidget {
  const PMSAdvertBanner();

  @override
  State<PMSAdvertBanner> createState() => _PMSAdvertBannerState();
}

class _PMSAdvertBannerState extends State<PMSAdvertBanner>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _slideController;
  late AnimationController _iconBounceController;

  late Animation<double> _glowAnim;
  late Animation<Offset> _slideAnim;
  late Animation<double> _iconBounceAnim;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _iconBounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _glowAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack));

    _iconBounceAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconBounceController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    _slideController.dispose();
    _iconBounceController.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnim,
      child: AnimatedBuilder(
        animation: Listenable.merge([_glowAnim, _iconBounceAnim]),
        builder: (context, _) {
          return Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Color.lerp(const Color(0xFF0D0D1A), const Color(0xFF12012B), _glowAnim.value)!,
                  Color.lerp(const Color(0xFF0A1628), const Color(0xFF001038), _glowAnim.value)!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Color.lerp(
                    const Color(0xFF7C3AED).withOpacity(0.25),
                    const Color(0xFF06B6D4).withOpacity(0.4),
                    _glowAnim.value,
                  )!,
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: Color.lerp(
                  const Color(0xFF7C3AED).withOpacity(0.5),
                  const Color(0xFF06B6D4).withOpacity(0.7),
                  _glowAnim.value,
                )!,
                width: 1.2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  // Background grid pattern
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _GridPainter(opacity: 0.06),
                    ),
                  ),

                  // Glow orb top-right
                  Positioned(
                    top: -20,
                    right: -20,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color.lerp(
                              const Color(0xFF7C3AED).withOpacity(0.4),
                              const Color(0xFF06B6D4).withOpacity(0.4),
                              _glowAnim.value,
                            )!,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        // Top row: pixel dot + brand name + tagline
                        Row(
                          children: [
                            // Animated pixel cube icon
                            Transform.translate(
                              offset: Offset(0, -2 * _iconBounceAnim.value),
                              child: Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.lerp(const Color(0xFF7C3AED), const Color(0xFF06B6D4), _glowAnim.value)!,
                                      Color.lerp(const Color(0xFFE879F9), const Color(0xFF38BDF8), _glowAnim.value)!,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.lerp(
                                        const Color(0xFF7C3AED).withOpacity(0.6),
                                        const Color(0xFF06B6D4).withOpacity(0.6),
                                        _glowAnim.value,
                                      )!,
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'P',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ShaderMask(
                                    shaderCallback: (bounds) => LinearGradient(
                                      colors: [
                                        Color.lerp(const Color(0xFFE879F9), const Color(0xFF38BDF8), _glowAnim.value)!,
                                        Color.lerp(const Color(0xFF7C3AED), const Color(0xFF06B6D4), _glowAnim.value)!,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ).createShader(bounds),
                                    child: const Text(
                                      'Pixelmind Studio',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Crafting Digital Experiences',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white.withOpacity(0.5),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // PMS badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Colors.white.withOpacity(0.07),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.15),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'PMS',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(0.7),
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 14),
                        Divider(color: Colors.white.withOpacity(0.08), height: 1),
                        const SizedBox(height: 14),

                        // Social + website links
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _SocialButton(
                              label: 'Website',
                              icon: Icons.language_rounded,
                              gradient: [const Color(0xFF7C3AED), const Color(0xFF5B21B6)],
                              glowColor: const Color(0xFF7C3AED),
                              onTap: () => _launch('https://www.pixelmindstudio.in'), // 🔁 Replace
                            ),
                            _SocialButton(
                              label: 'Instagram',
                              icon: Icons.camera_alt_rounded,
                              gradient: [const Color(0xFFE1306C), const Color(0xFFF77737)],
                              glowColor: const Color(0xFFE1306C),
                              onTap: () => _launch('https://www.instagram.com/pixelmindstudio'), // 🔁 Replace
                            ),
                            _SocialButton(
                              label: 'Facebook',
                              icon: Icons.facebook_rounded,
                              gradient: [const Color(0xFF1877F2), const Color(0xFF0C56C9)],
                              glowColor: const Color(0xFF1877F2),
                              onTap: () => _launch('https://www.facebook.com/pixelmindstudio'), // 🔁 Replace
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Social Icon Button ────────────────────────────────────────────────────────
class _SocialButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final List<Color> gradient;
  final Color glowColor;
  final VoidCallback onTap;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.glowColor,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.85).animate(
      CurvedAnimation(parent: _pressController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _pressController.forward(),
      onTapUp: (_) {
        _pressController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _pressController.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnim,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnim.value,
          child: child,
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: widget.gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.glowColor.withOpacity(0.45),
                    blurRadius: 12,
                    spreadRadius: 0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Grid Background Painter ───────────────────────────────────────────────────
class _GridPainter extends CustomPainter {
  final double opacity;
  const _GridPainter({required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..strokeWidth = 0.8;

    const spacing = 24.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}