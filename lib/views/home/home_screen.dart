import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/Provider/location/location_provider.dart';
import 'package:product_app/Provider/profile/profile_provider.dart';
import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/profile/edit_profile.dart';
import 'package:product_app/utils/call_utils.dart';
import 'package:product_app/utils/location_utils.dart';
import 'package:product_app/utils/whatsapp_utils.dart';
import 'package:product_app/views/Buy/buy_screen.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';
import 'package:product_app/views/Listing/listing_screen.dart';
import 'package:product_app/views/Notifications/notification_screen.dart';
import 'package:product_app/views/category/category_screen.dart';
import 'package:product_app/views/location/location_screen.dart';
import 'package:product_app/views/nearesthouses/nearest_houses.dart';
import 'package:product_app/views/search/filter_screen.dart';
import 'package:product_app/views/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> categories = [];
  bool isLoadingCategories = true;
  String? currentAddress;
  bool isLoadingAddress = false;
  
  // Location and Network States
  bool _isLocationPermissionDenied = false;
  bool _isLocationServicesDisabled = false;
  bool _hasNetworkError = false;
  bool _isLoadingLocation = true;
  bool _isInitialized = false;
  
  int selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  // Location cache keys
  static const String CACHED_LATITUDE = 'cached_latitude';
  static const String CACHED_LONGITUDE = 'cached_longitude';
  static const String CACHED_ADDRESS = 'cached_address';
  static const String LOCATION_TIMESTAMP = 'location_timestamp';
  
  // Cache expiry (24 hours in milliseconds)
  static const int CACHE_EXPIRY = 24 * 60 * 60 * 1000;

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  List<Map<String, dynamic>> nearestProducts = [];
  bool isLoadingNearestProducts = true;

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _animationController.forward();

    final userId = SharedPrefHelper.getUserId();
    if (userId != null) {
      Future.microtask(() {
        Provider.of<ProfileProvider>(context, listen: false).fetchProfile(userId);
        Provider.of<WishlistProvider>(context, listen: false).fetchWishlist();
      });
    }
    
    fetchCategories();
    _initializeLocationAndData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _initializeLocationAndData() async {
    setState(() {
      _isLoadingLocation = true;
      _hasNetworkError = false;
      _isLocationPermissionDenied = false;
      _isLocationServicesDisabled = false;
    });

    // Check network connectivity first
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _hasNetworkError = true;
        _isLoadingLocation = false;
        _isInitialized = true;
      });
      return;
    }

    // Try to load cached location
    bool locationLoaded = await _loadCachedLocation();
    
    if (locationLoaded) {
      // Use cached location
      setState(() {
        _isLoadingLocation = false;
        _isInitialized = true;
      });
      await fetchNearestProducts();
    } else {
      // No valid cache, fetch fresh location
      await _checkLocationPermissionAndFetch();
    }
  }

  Future<bool> _loadCachedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Check if cache exists and is not expired
      double? cachedLat = prefs.getDouble(CACHED_LATITUDE);
      double? cachedLng = prefs.getDouble(CACHED_LONGITUDE);
      String? cachedAddr = prefs.getString(CACHED_ADDRESS);
      int? timestamp = prefs.getInt(LOCATION_TIMESTAMP);
      
      if (cachedLat != null && cachedLng != null && cachedAddr != null && timestamp != null) {
        // Check if cache is expired
        if (DateTime.now().millisecondsSinceEpoch - timestamp < CACHE_EXPIRY) {
          // Use cached location
          final locationProvider = Provider.of<LocationProvider>(context, listen: false);
          locationProvider.setManualLocation(
            latitude: cachedLat,
            longitude: cachedLng,
          );
          
          setState(() {
            currentAddress = cachedAddr;
          });
          
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Error loading cached location: $e');
      return false;
    }
  }

  Future<void> _cacheLocation(double latitude, double longitude, String address) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(CACHED_LATITUDE, latitude);
      await prefs.setDouble(CACHED_LONGITUDE, longitude);
      await prefs.setString(CACHED_ADDRESS, address);
      await prefs.setInt(LOCATION_TIMESTAMP, DateTime.now().millisecondsSinceEpoch);
    } catch (e) {
      print('Error caching location: $e');
    }
  }

  Future<void> _checkLocationPermissionAndFetch() async {
    setState(() {
      isLoadingAddress = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLocationServicesDisabled = true;
          _isLoadingLocation = false;
          _isInitialized = true;
          isLoadingAddress = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLocationPermissionDenied = true;
            _isLoadingLocation = false;
            _isInitialized = true;
            isLoadingAddress = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLocationPermissionDenied = true;
          _isLoadingLocation = false;
          _isInitialized = true;
          isLoadingAddress = false;
        });
        return;
      }

      // Permission granted, fetch location
      await _fetchCurrentLocation();
    } catch (e) {
      print('Error checking location permission: $e');
      setState(() {
        _hasNetworkError = true;
        _isLoadingLocation = false;
        _isInitialized = true;
        isLoadingAddress = false;
      });
    }
  }

  Future<void> _fetchCurrentLocation() async {
    try {
      final locationProvider = Provider.of<LocationProvider>(context, listen: false);

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      locationProvider.setManualLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      await _getAddressFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      print('Error fetching location: $e');
      
      if (e.toString().contains('timeout')) {
        setState(() {
          _hasNetworkError = true;
        });
      } else {
        setState(() {
          _isLocationPermissionDenied = true;
        });
      }
      
      setState(() {
        _isLoadingLocation = false;
        _isInitialized = true;
        isLoadingAddress = false;
      });
    }
  }

  Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = [
          place.locality,
          place.administrativeArea,
        ].where((e) => e != null && e.isNotEmpty).take(2).join(', ');
        
        setState(() {
          currentAddress = address;
          _isLoadingLocation = false;
          _isInitialized = true;
          isLoadingAddress = false;
        });
        
        // Cache the location
        await _cacheLocation(latitude, longitude, address);
        
        await fetchNearestProducts();
      }
    } catch (e) {
      print('Error getting address: $e');
      setState(() {
        currentAddress = 'Location unavailable';
        _isLoadingLocation = false;
        _isInitialized = true;
        isLoadingAddress = false;
      });
    }
  }

  Future<void> _handleLocationUpdate() async {
    final userId = SharedPrefHelper.getUserId();
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    setState(() {
      isLoadingAddress = true;
    });

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationFetchScreen(userId: userId),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        currentAddress = result['address'] as String?;
      });

      final locationProvider = Provider.of<LocationProvider>(context, listen: false);
      final latitude = result['latitude'] as double;
      final longitude = result['longitude'] as double;
      
      locationProvider.setManualLocation(
        latitude: latitude,
        longitude: longitude,
      );

      // Cache the new location
      await _cacheLocation(latitude, longitude, result['address'] as String);

      await fetchNearestProducts();
    }
    
    setState(() {
      isLoadingAddress = false;
    });
  }

  Future<void> fetchNearestProducts() async {
    final userId = SharedPrefHelper.getUserId();
    if (userId == null) {
      print('User ID not found');
      setState(() {
        isLoadingNearestProducts = false;
      });
      return;
    }

    setState(() {
      isLoadingNearestProducts = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:9174/api/nearest/user/$userId'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['products'] != null) {
          setState(() {
            nearestProducts = (data['products'] as List).map((product) {
              String bed = '';
              String bath = '';
              String area = '';

              if (product['features'] != null) {
                for (var feature in product['features']) {
                  String name = (feature['name']?.toString() ?? '').toLowerCase();
                  if (name.contains('bedroom') || name.contains('bed')) {
                    bed = feature['name']?.toString() ?? '';
                  } else if (name.contains('bathroom') || name.contains('bath')) {
                    bath = feature['name']?.toString() ?? '';
                  } else if (name.contains('sqft') || name.contains('sq')) {
                    area = feature['name']?.toString() ?? '';
                  }
                }
              }

              String imageUrl = '';
              if (product['images'] != null && (product['images'] as List).isNotEmpty) {
                imageUrl = product['images'][0].toString();
              }

              return {
                'id': product['_id']?.toString() ?? '',
                'imageUrl': imageUrl,
                'tag': product['type']?.toString() ?? 'For Sale',
                'title': product['name']?.toString() ?? 'Unnamed Property',
                'location': product['address']?.toString() ?? 'Unknown',
                'price': '₹25,000',
                'bed': bed.isNotEmpty ? bed : '4 Bed',
                'bath': bath.isNotEmpty ? bath : '2 Bath',
                'area': area.isNotEmpty ? area : '7,500 sqft',
              };
            }).toList();
            isLoadingNearestProducts = false;
          });
        } else {
          setState(() {
            nearestProducts = [];
            isLoadingNearestProducts = false;
          });
        }
      } else {
        throw Exception('Failed to load nearest products');
      }
    } catch (e) {
      print('Error fetching nearest products: $e');
      setState(() {
        nearestProducts = [];
        isLoadingNearestProducts = false;
      });
    }
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:9174/api/auth/sub/all'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          setState(() {
            categories = List<Map<String, dynamic>>.from(
              data['subCategories'].map((subCategory) => {
                'id': subCategory['_id'],
                'name': subCategory['name'],
                'image': subCategory['image'],
                'mainCategoryId': subCategory['category']['_id'],
                'mainCategoryName': subCategory['category']['name'],
              }),
            );
            isLoadingCategories = false;
          });
        } else {
          isLoadingCategories = false;
        }
      } else {
        isLoadingCategories = false;
      }
    } catch (e) {
      print('Error fetching sub categories: $e');
      setState(() {
        isLoadingCategories = false;
      });
    }
  }

  void _retryInitialization() {
    _initializeLocationAndData();
  }

  @override
  Widget build(BuildContext context) {
    // Show loading while initializing
    if (!_isInitialized || _isLoadingLocation) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text(
                'Initializing...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Show network error screen
    if (_hasNetworkError) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 80,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 24),
                const Text(
                  'No Internet Connection',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Please check your internet connection\nand try again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _retryInitialization,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE33629),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Show location permission screen (matching your image)
    if (_isLocationPermissionDenied || _isLocationServicesDisabled) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Location Icon
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE33629).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on,
                      size: 60,
                      color: Color(0xFFE33629),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Title
                const Text(
                  'Allow your location',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Description
                Text(
                  'We will need your location to give you better reports.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                const Spacer(),
                // Allow Location Button
                ElevatedButton(
                  onPressed: () async {
                    if (_isLocationServicesDisabled) {
                      await Geolocator.openLocationSettings();
                    } else {
                      await Geolocator.openAppSettings();
                    }
                    // Retry after returning to app
                    Future.delayed(const Duration(seconds: 2), () {
                      _retryInitialization();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE33629),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sure, I\'d like that',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Next Step Button (if you want to proceed without location)
                TextButton(
                  onPressed: () {
                    // Handle next step (maybe set default location or proceed with limited features)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Location is required for full features'),
                      ),
                    );
                  },
                  child: Text(
                    'Next step',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    }

    // Show main home screen
    return _buildHomeScreen();
  }

  Widget _buildHomeScreen() {
    final List<Map<String, dynamic>> displayProducts = nearestProducts.isNotEmpty ? nearestProducts : [];
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  
                  // Custom App Bar
                  _buildCustomAppBar(),
                  
                  const SizedBox(height: 16),
                  
        
                  // Search Bar
                  _SearchBar(),
                  
                  const SizedBox(height: 16),
                  
                  // Banner Card
                  _BannerCard(),
                  
                  const SizedBox(height: 20),
                  
                  // Categories Container
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: const Color.fromARGB(255, 216, 209, 187),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _buildCategoriesRow(),
                          const SizedBox(height: 6),
                          _AllCategoryRow(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CategoryScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Section Header for Nearest Houses
                  _SectionHeader(
                    title: "Nearest Houses",
                    onSeeAll: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NearestHouses()),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Properties List
        // In your HomeScreen _buildHomeScreen method, update the PropertyListCard onTap:

// Properties List
isLoadingNearestProducts
    ? const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        ),
      )
    : displayProducts.isEmpty
        ? const Center(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: Text("No Properties Found"),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayProducts.length,
            itemBuilder: (context, index) {
              final property = displayProducts[index];
              return _PropertyListCard(
                key: ValueKey(property['id']),
                property: property,
                onTap: () {
                  // Navigate directly to property detail screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NearestHouseDetail(
                        house: {
                          'id': property['id'],
                          'image': property['imageUrl'],
                          'tag': property['tag'],
                          'title': property['title'],
                          'location': property['location'],
                          'price': property['price'],
                          'beds': property['bed'],
                          'baths': property['bath'],
                          'area': property['area'],
                          'description': property['description'] ?? 'Beautiful property located in prime area with modern amenities and peaceful surroundings.',
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Row(
      children: [
        // Profile Avatar
        Consumer<ProfileProvider>(
          builder: (context, profileProvider, _) {
            final imageUrl = profileProvider.profileImageUrl;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfile()),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl)
                    : null,
                child: imageUrl == null || imageUrl.isEmpty
                    ? const Icon(Icons.person, color: Colors.grey, size: 20)
                    : null,
              ),
            );
          },
        ),
        const SizedBox(width: 12),
        
        // Greeting and Name
        Expanded(
          child: Consumer<ProfileProvider>(
            builder: (context, profileProvider, _) {
              final userName = profileProvider.name ?? 'User';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getGreeting(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
        ),
        
        // Location Icon
        IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: () {
                currentAddress != null && !isLoadingAddress ? _handleLocationUpdate : null;

          },
        ),


                // Notification Icon
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationScreen()),
            );
          },
        ),
      ],
    );
  }

  // Widget _buildLocationBanner() {
  //   return GestureDetector(
  //     onTap: currentAddress != null && !isLoadingAddress ? _handleLocationUpdate : null,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //       decoration: BoxDecoration(
  //         color: Colors.grey.shade100,
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Row(
  //         children: [
  //           const Icon(Icons.location_on, size: 16, color: Colors.grey),
  //           const SizedBox(width: 8),
  //           Expanded(
  //             child: isLoadingAddress
  //                 ? const SizedBox(
  //                     height: 16,
  //                     width: 16,
  //                     child: CircularProgressIndicator(strokeWidth: 2),
  //                   )
  //                 : Text(
  //                     currentAddress ?? 'Set your location',
  //                     style: const TextStyle(fontSize: 13),
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //           ),
  //           const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildCategoriesRow() {
    if (isLoadingCategories) {
      return const Center(child: CircularProgressIndicator());
    }

    final displayCategories = categories.take(4).toList();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: displayCategories.map((cat) {
        return _CategoryItem(
          categoryId: cat['id'],
          label: cat['name'],
          image: cat['image'],
        );
      }).toList(),
    );
  }
}

// ── Search Bar ────────────────────────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        readOnly: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        },
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

// ── Banner ────────────────────────────────────────────────────────────────────
class _BannerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        height: 140,
        color: Colors.blue.shade100,
        child: Image.asset(
          'assets/images/banner.png',
          width: double.infinity,
          height: 140,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return const Center(
              child: Text('Banner Image'),
            );
          },
        ),
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const _SectionHeader({required this.title, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Row(
            children: [
              Text(
                "See All",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Icon(Icons.chevron_right, size: 16, color: Colors.black54),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Categories ────────────────────────────────────────────────────────────────
class _CategoryItem extends StatelessWidget {
  final String label;
  final String image;
  final String categoryId;

  const _CategoryItem({
    required this.label,
    required this.image,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateListingScreen(
              subcategoryId: categoryId,
              name: label,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 75,
            height: 84,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFE33629),
                  Color(0xFF9D0D0D),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Image.network(
                    image,
                    color: const Color(0xFFE33629),
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.category,
                        color: Color(0xFFE33629),
                        size: 20,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AllCategoryRow extends StatelessWidget {
  final VoidCallback onTap;

  const _AllCategoryRow({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "All Category",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Icon(Icons.chevron_right, size: 18, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}

// ── Property Card ─────────────────────────────────────────────────────────────
class _PropertyListCard extends StatelessWidget {
  final Map<String, dynamic> property;
  final VoidCallback onTap;

  const _PropertyListCard({
    super.key,
    required this.property,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        final isInWishlist = wishlistProvider.isInWishlist(property['id']);

        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: property['imageUrl'].toString().startsWith('http')
                            ? Image.network(
                                property['imageUrl'],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade300,
                                    child: const Center(
                                      child: Icon(Icons.image_not_supported, size: 50),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Icon(Icons.image_not_supported, size: 50),
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () async {
                          final success = await wishlistProvider.toggleWishlist(property['id']);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: success ? Colors.green : Colors.red,
                                content: Text(
                                  success
                                      ? (isInWishlist
                                          ? 'Removed from wishlist'
                                          : 'Added to wishlist')
                                      : (wishlistProvider.errorMessage ?? 'Failed to update wishlist'),
                                ),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isInWishlist ? Icons.favorite : Icons.favorite_border,
                            size: 16,
                            color: isInWishlist
                                ? Colors.red
                                : Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        property['title'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          _StatChip(
                            imagePath: 'assets/images/bed.png',
                            label: property['bed'],
                          ),
                          const SizedBox(width: 12),
                          _StatChip(
                            imagePath: 'assets/images/bath.png',
                            label: property['bath'],
                          ),
                          const SizedBox(width: 12),
                          _StatChip(
                            imagePath: 'assets/images/sqft.png',
                            label: property['area'],
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),
                      Divider(color: Colors.grey.shade200, height: 1),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          _CallButton(onTap: () {
              CallUtils.showCallOptions(
                              context: context,
                              phoneNumber: "9961593179",
                              name: "Property Agent",
                              showMessage: true,
                              showWhatsApp: true,
                            );
    
                          }),
                          const SizedBox(width: 12),
                          _ActionButton(
                            imagePath: 'assets/images/whatsapp.png',
                            label: "Whatsapp",
                            onTap: () {
                                  WhatsAppUtils.shareProperty(
      context: context,
      propertyTitle: property['title'],
      propertyLocation: property['location'],
      propertyPrice: property['price'],
      agentPhone: '919961593179', // Your agent phone number
    );
                            },
                          ),
                          const Spacer(),
                          _ActionButton(
                            imagePath: 'assets/images/location.png',
                            label: "Location",
                            onTap: () {
                                  LocationUtils.openMap(
      context: context,
      latitude: 28.6139, // Your latitude from property
      longitude: 77.2090, // Your longitude from property
      address: property['location'],
      label: property['title'],
    );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CallButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CallButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFFE33629),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          "Call",
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String imagePath;
  final String label;

  const _StatChip({
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 14,
          height: 14,
          errorBuilder: (_, __, ___) {
            return Container(
              width: 14,
              height: 14,
              color: Colors.grey,
            );
          },
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 16,
            height: 16,
            errorBuilder: (_, __, ___) {
              return Container(
                width: 16,
                height: 16,
                color: Colors.grey,
              );
            },
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}