import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product_app/Provider/location/location_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/views/auth/login_screen.dart';
import 'package:product_app/views/home/navbar_screen.dart';
import 'package:product_app/views/splash/amoders_loading.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:url_launcher/url_launcher.dart';

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

  // Tri-state: null = still checking, true = logged in, false = not logged in
  bool? _isLoggedIn;

  bool _isLocationLoading = true;
  bool _locationPermissionDenied = false;
  String? _currentAddress;
  String? _errorMessage;
  bool _isInitialized = false;
  bool _isGuestLoginInProgress = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _positionAnimation = Tween<Offset>(
      begin: const Offset(0, 2.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    _controller.forward();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    final bool hasValidSession = SharedPrefHelper.hasValidSession();
    print("User logged in: $hasValidSession");

    setState(() {
      _isLoggedIn = hasValidSession;
    });

    if (_isLoggedIn == true) {
      await _initializeLocation();
    } else {
      setState(() {
        _isLocationLoading = false;
        _isInitialized = true;
      });
    }
  }

  Future<void> _initializeLocation() async {
    setState(() {
      _isLocationLoading = true;
      _locationPermissionDenied = false;
      _errorMessage = null;
    });

    try {
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);

      // First load saved location
      await locationProvider.loadSavedLocation();

      // Check permission
      bool hasPermission = await locationProvider.checkPermission();

      if (!hasPermission) {
        setState(() {
          _locationPermissionDenied = true;
          _isLocationLoading = false;
          _isInitialized = true;
        });
        return;
      }

      // Get current location
      await locationProvider.getCurrentLocation();

      if (locationProvider.currentPosition != null) {
        // Get address from coordinates
        _currentAddress = await _getAddressFromCoordinates(
          locationProvider.latitude!,
          locationProvider.longitude!,
        );

        // Update location to server
        await Future.delayed(const Duration(milliseconds: 500));
        final success = await locationProvider.updateLocationToServer();

        if (!success) {
          print(
              "Failed to update location to server: ${locationProvider.errorMessage}");
        } else {
          print("Location updated successfully to server");
        }

        setState(() {
          _isLocationLoading = false;
          _isInitialized = true;
        });

        // ✅ Auto-navigate to app once location is successfully fetched —
        // no need for the user to tap "Get Started"
        if (mounted) {
          _proceedToApp();
        }
      } else {
        setState(() {
          _errorMessage =
              locationProvider.errorMessage ?? 'Unable to get location';
          _isLocationLoading = false;
          _isInitialized = true;
        });
      }
    } catch (e) {
      print("Error in _initializeLocation: $e");
      setState(() {
        _errorMessage = e.toString();
        _isLocationLoading = false;
        _isInitialized = true;
      });
    }
  }

  Future<String?> _getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final addressParts = [
          place.subLocality,
          place.locality,
          place.administrativeArea,
        ].where((e) => e != null && e.isNotEmpty).toList();
        if (addressParts.isNotEmpty) {
          return addressParts.take(2).join(', ');
        }
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return null;
  }

  void _proceedToApp() {
    if (_isLoggedIn == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const NavbarScreen(initialIndex: 0)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _openLocationSettings() async {
    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    await locationProvider.openLocationSettings();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable location and come back'),
          duration: Duration(seconds: 2),
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) _initializeLocation();
      });
    }
  }

  void _retryLocation() => _initializeLocation();

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleGuestLogin() async {
    setState(() {
      _isGuestLoginInProgress = true;
    });

    try {
      // Save guest login status in SharedPreferences
      await SharedPrefHelper.setLoggedIn(true);
      await SharedPrefHelper.setToken(
          'guest_${DateTime.now().millisecondsSinceEpoch}');
      await SharedPrefHelper.prefs.setBool('is_guest', true);

      // Clear any existing user data to ensure fresh guest state
      await SharedPrefHelper.removeMobile();
      await SharedPrefHelper.removeUserId();

      if (mounted) {
        // Navigate directly to app without location permission
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const NavbarScreen(initialIndex: 0)),
        );
      }
    } catch (e) {
      setState(() {
        _isGuestLoginInProgress = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to continue as guest. Please try again."),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _showAccessModeDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE33629).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_android_rounded,
                    size: 40,
                    color: Color(0xFFE33629),
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                const Text(
                  "Choose Access Mode",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  "How would you like to continue?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 24),

                // User Login Button
                _buildDialogOption(
                  icon: Icons.person_outline,
                  title: "User Login",
                  subtitle: "Access your account and saved properties",
                  color: const Color(0xFFE33629),
                  onTap: () {
                    Navigator.pop(context);
                    _proceedToApp();
                  },
                ),
                const SizedBox(height: 12),

                // Guest Login Button
                _buildDialogOption(
                  icon: Icons.person_off_outlined,
                  title: "Continue as Guest",
                  subtitle: "Browse properties without logging in",
                  color: Colors.grey.shade700,
                  onTap: () {
                    Navigator.pop(context);
                    _handleGuestLogin();
                  },
                ),
                const SizedBox(height: 8),

                // Cancel button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ─── Still checking login state: show only the logo, no button ───
    // This prevents the brief "Login" button flash for logged-in users
    final bool isCheckingAuth = _isLoggedIn == null;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _positionAnimation,
                  child: Image.asset(
                    'assets/images/splash1.png',
                    width: 180,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 180,
                        height: 180,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.broken_image, size: 50),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              // ── Status section: hidden while auth check is in progress ──
              if (!isCheckingAuth) ...[
                if (_isLoggedIn == true) ...[
                  if (_isLocationLoading)
                    _buildLoadingStatus()
                  else if (_locationPermissionDenied)
                    _buildPermissionDeniedStatus()
                  else if (_errorMessage != null)
                    _buildErrorStatus(),
                ] else ...[
                  _buildWelcomeStatus(),
                ],
              ] else ...[
                // Minimal loading indicator while we silently check session
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ],

              // ── Action button: hidden while auth check is in progress ──
              if (!isCheckingAuth)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: _buildActionButton(),
                ),

              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  children: [
                    Text(
                      'Developed by Pixelmindsolutions Pvt Ltd',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _PMSLink(
                          label: 'Website',
                          icon: Icons.language_rounded,
                          color: const Color(0xFF7C3AED),
                          onTap: () =>
                              _launch('https://www.pixelmindsolutions.com'),
                        ),
                        _dot(),
                        _PMSLink(
                          label: 'Instagram',
                          icon: Icons.camera_alt_rounded,
                          color: const Color(0xFFE1306C),
                          onTap: () => _launch(
                              'https://www.instagram.com/pixelmindsolutions?igsh=MThuZmJwbHh4dXQzcA=='),
                        ),
                        _dot(),
                        _PMSLink(
                          label: 'Facebook',
                          icon: Icons.facebook_rounded,
                          color: const Color(0xFF1877F2),
                          onTap: () => _launch(
                              'https://www.facebook.com/share/1NVMnQVMni/'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset(
                'assets/images/splash2.png',
                width: double.infinity,
                fit: BoxFit.fitWidth,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    color: Colors.grey.shade200,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Text('·',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
      );

  Widget _buildLoadingStatus() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          const AmodersLoading(),
          const SizedBox(height: 12),
          Text(
            "Getting your location...",
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedStatus() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(Icons.location_off, color: Colors.red.shade700, size: 24),
          const SizedBox(height: 8),
          Text(
            "Location permission denied",
            style: TextStyle(
                fontSize: 14,
                color: Colors.red.shade700,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            "Enable location to find properties near you",
            style: TextStyle(fontSize: 12, color: Colors.red.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorStatus() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 24),
          const SizedBox(height: 8),
          Text(
            _errorMessage ?? "Something went wrong",
            style: TextStyle(fontSize: 14, color: Colors.red.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          TextButton(onPressed: _retryLocation, child: const Text('Try Again')),
        ],
      ),
    );
  }

  Widget _buildWelcomeStatus() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Text(
        "Welcome to EstateHouz",
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800),
      ),
    );
  }

  Widget _buildActionButton() {
    String buttonText;
    VoidCallback? onPressed;

    if (_isLoggedIn == true) {
      if (_isLocationLoading) {
        // Location is being fetched — button is disabled
        buttonText = "Getting Ready...";
        onPressed = null;
      } else if (_locationPermissionDenied) {
        buttonText = "Enable Location";
        onPressed = _openLocationSettings;
      } else if (_errorMessage != null) {
        // Location failed — let user proceed manually
        buttonText = "Continue Anyway";
        onPressed = _proceedToApp;
      } else {
        // Location success — auto-navigate is already triggered in
        // _initializeLocation(), this button is just a fallback
        buttonText = "Get Started";
        onPressed = _proceedToApp;
      }
    } else {
      buttonText = "Get Started";
      onPressed = _showAccessModeDialog;
    }

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE33629),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _PMSLink extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _PMSLink({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
