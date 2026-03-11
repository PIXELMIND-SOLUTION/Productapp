import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product_app/Provider/location/location_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/views/auth/login_screen.dart';
import 'package:product_app/views/home/navbar_screen.dart';
import 'package:product_app/views/widgets/pmsad.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

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
  
  // State variables
  bool _isLoggedIn = false;
  bool _isLocationLoading = true;
  bool _locationPermissionDenied = false;
  String? _currentAddress;
  String? _errorMessage;
  bool _isInitialized = false;
  
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
      begin: const Offset(0, 2.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
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
    
    // Initialize app state
    _initialize();
  }

  Future<void> _initialize() async {
    // Wait for animation to complete
    await Future.delayed(const Duration(seconds: 1));
    
    // Check login status
    final bool hasValidSession = SharedPrefHelper.hasValidSession();
    
    setState(() {
      _isLoggedIn = hasValidSession;
    });
    
    if (_isLoggedIn) {
      // If logged in, try to get location
      await _initializeLocation();
    } else {
      // If not logged in, no need to check location
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
      final locationProvider = Provider.of<LocationProvider>(context, listen: false);
      
      // Try to load cached location first
      await locationProvider.loadSavedLocation();
      
      if (locationProvider.currentPosition != null) {
        // We have cached location
        _currentAddress = await _getAddressFromCoordinates(
          locationProvider.latitude!,
          locationProvider.longitude!,
        );
        setState(() {
          _isLocationLoading = false;
          _isInitialized = true;
        });
        return;
      }
      
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
        _currentAddress = await _getAddressFromCoordinates(
          locationProvider.latitude!,
          locationProvider.longitude!,
        );
        
        // Update location to server
        final updateSuccess = await locationProvider.updateLocationToServer();
        
        if (!updateSuccess && mounted) {
          // Show a subtle error but don't block the user
          print('Failed to update location to server');
        }
        
        setState(() {
          _isLocationLoading = false;
          _isInitialized = true;
        });
      } else {
        setState(() {
          _errorMessage = locationProvider.errorMessage ?? 'Unable to get location';
          _isLocationLoading = false;
          _isInitialized = true;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLocationLoading = false;
        _isInitialized = true;
      });
    }
  }

  Future<String?> _getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        latitude,
        longitude,
      );

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
    if (_isLoggedIn) {
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

  void _openLocationSettings() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    await locationProvider.openLocationSettings();
    
    // Retry after returning to app
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable location and come back'),
          duration: Duration(seconds: 2),
        ),
      );
      
      // Small delay before retrying
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _initializeLocation();
        }
      });
    }
  }

  void _retryLocation() {
    _initializeLocation();
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
          /// Animated logo
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

          /// Bottom section with status and button
          Column(
            children: [
              // Status message area
              if (_isLoggedIn) ...[
                if (_isLocationLoading)
                  _buildLoadingStatus()
                else if (_locationPermissionDenied)
                  _buildPermissionDeniedStatus()
                else if (_errorMessage != null)
                  _buildErrorStatus()
                // else if (_currentAddress != null)
                //   _buildLocationStatus()
                // else
                //   _buildNoLocationStatus(),
              ] else ...[
                _buildWelcomeStatus(),
              ],
                  const PMSAdvertBanner(),
              // Action button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: _buildActionButton(),
              ),
              
              // City skyline
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

  Widget _buildLoadingStatus() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE33629)),
          ),
          const SizedBox(height: 12),
          Text(
            "Getting your location...",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationStatus() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.location_on, color: Colors.green.shade700, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              _currentAddress ?? "Location detected",
              style: TextStyle(
                fontSize: 14,
                color: Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoLocationStatus() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          Icon(Icons.location_off, color: Colors.orange.shade700, size: 24),
          const SizedBox(height: 8),
          Text(
            "Unable to detect location",
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: _retryLocation,
            child: const Text('Retry'),
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
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Enable location to find properties near you",
            style: TextStyle(
              fontSize: 12,
              color: Colors.red.shade600,
            ),
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
            style: TextStyle(
              fontSize: 14,
              color: Colors.red.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          TextButton(
            onPressed: _retryLocation,
            child: const Text('Try Again'),
          ),
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
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  Widget _buildActionButton() {
    String buttonText;
    VoidCallback? onPressed;
    
    if (_isLoggedIn) {
      if (_isLocationLoading) {
        buttonText = "Getting Ready...";
        onPressed = null;
      } else if (_locationPermissionDenied) {
        buttonText = "Enable Location";
        onPressed = _openLocationSettings;
      } else {
        buttonText = "Get Started";
        onPressed = _proceedToApp;
      }
    } else {
      buttonText = "Login";
      onPressed = _proceedToApp;
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
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}