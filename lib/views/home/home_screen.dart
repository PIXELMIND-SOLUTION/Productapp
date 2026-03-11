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
import 'package:product_app/views/widget/pms.dart';
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

  // Selected category for filtering
  String? _selectedCategoryId;
  String? _selectedCategoryName;

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
    setState(() {
      isLoadingNearestProducts = false;
    });
    return;
  }

  setState(() {
    isLoadingNearestProducts = true;
  });

  try {
    // Build URL with optional category filter
    String url = 'https://estatehouz-backend.onrender.com/api/nearest/user/$userId';
    if (_selectedCategoryId != null && _selectedCategoryId!.isNotEmpty) {
      url += '/$_selectedCategoryId';
    }

    print('Fetching from URL: $url'); // Debug print

    final response = await http.get(
      Uri.parse(url),
    );

    print('Response status: ${response.statusCode}'); // Debug print

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['success'] == true && data['products'] != null) {
        final List products = data['products'];

        setState(() {
          nearestProducts = products.map<Map<String, dynamic>>((item) {
            // SAFE CASTING: Handle any type of item safely
            Map<String, dynamic> product = {};
            
            if (item is Map) {
              // Convert all keys to String safely
              try {
                product = Map<String, dynamic>.from(item);
              } catch (e) {
                print('Error converting item to Map: $e');
                // Fallback: create a new map by iterating
                final Map<String, dynamic> tempMap = {};
                item.forEach((key, value) {
                  tempMap[key.toString()] = value;
                });
                product = tempMap;
              }
            } else {
              print('Item is not a Map: ${item.runtimeType}');
              product = {};
            }

            // SAFE ATTRIBUTES HANDLING
            Map<String, dynamic> attributes = {};
            if (product.containsKey('attributes') && product['attributes'] != null) {
              final attrs = product['attributes'];
              if (attrs is Map) {
                try {
                  attributes = Map<String, dynamic>.from(attrs);
                } catch (e) {
                  print('Error converting attributes: $e');
                  // Safe fallback
                  final Map<String, dynamic> tempAttrs = {};
                  attrs.forEach((key, value) {
                    tempAttrs[key.toString()] = value;
                  });
                  attributes = tempAttrs;
                }
              }
            }

            // SAFE CONTACT HANDLING - NEW
            Map<String, dynamic> contact = {};
            if (product.containsKey('contact') && product['contact'] != null) {
              final cont = product['contact'];
              if (cont is Map) {
                try {
                  contact = Map<String, dynamic>.from(cont);
                } catch (e) {
                  print('Error converting contact: $e');
                }
              }
            }

            // SAFE BEDROOMS HANDLING
            String bed = "N/A";
            if (attributes.containsKey('bedrooms')) {
              final bedrooms = attributes['bedrooms'];
              if (bedrooms is num) {
                bed = "${bedrooms.toStringAsFixed(0)} Bed";
              } else if (bedrooms is String) {
                bed = "$bedrooms Bed";
              } else if (bedrooms != null) {
                bed = "$bedrooms Bed";
              }
            }

            // SAFE BATHROOMS HANDLING
            String bath = "N/A";
            if (attributes.containsKey('bathrooms')) {
              final bathrooms = attributes['bathrooms'];
              if (bathrooms is num) {
                bath = "${bathrooms.toStringAsFixed(0)} Bath";
              } else if (bathrooms is String) {
                bath = "$bathrooms Bath";
              } else if (bathrooms != null) {
                bath = "$bathrooms Bath";
              }
            }

            // SAFE AREA HANDLING
            String area = "N/A";
            if (attributes.containsKey('sqft')) {
              final sqft = attributes['sqft'];
              if (sqft is num) {
                area = "${sqft.toStringAsFixed(0)} sqft";
              } else if (sqft is String) {
                area = "$sqft sqft";
              } else if (sqft != null) {
                area = "$sqft sqft";
              }
            } else if (attributes.containsKey('landSize')) {
              final unit = attributes.containsKey('unit') ? attributes['unit']?.toString() ?? '' : '';
              if (unit.toLowerCase() == 'acres') {
                final landSize = attributes['landSize'];
                if (landSize is num) {
                  area = "${landSize.toStringAsFixed(1)} acres";
                } else if (landSize is String) {
                  area = "$landSize acres";
                } else if (landSize != null) {
                  area = "$landSize acres";
                }
              }
            }

            // SAFE PRICE HANDLING
            String price = "Price N/A";
            if (attributes.containsKey('price')) {
              final priceValue = attributes['price'];
              if (priceValue is num) {
                price = "₹${priceValue.toStringAsFixed(0)}";
              } else if (priceValue is String) {
                price = "₹$priceValue";
              } else if (priceValue != null) {
                price = "₹$priceValue";
              }
            }

            // SAFE IMAGE URL HANDLING
            String imageUrl = "";
            if (product.containsKey('images') && product['images'] != null) {
              final images = product['images'];
              if (images is List && images.isNotEmpty) {
                final firstImage = images.first;
                if (firstImage != null) {
                  imageUrl = firstImage.toString();
                }
              }
            }

            // SAFE CATEGORY HANDLING
            String categoryName = "Property";
            if (product.containsKey('category') && product['category'] != null) {
              final category = product['category'];
              if (category is Map) {
                if (category.containsKey('name') && category['name'] != null) {
                  categoryName = category['name'].toString();
                }
              }
            }

            // SAFE USER HANDLING - to get agent info
            Map<String, dynamic> user = {};
            if (product.containsKey('user') && product['user'] != null) {
              final usr = product['user'];
              if (usr is Map) {
                try {
                  user = Map<String, dynamic>.from(usr);
                } catch (e) {
                  print('Error converting user: $e');
                }
              }
            }

            // SAFE ID HANDLING
            String id = "";
            if (product.containsKey('_id') && product['_id'] != null) {
              id = product['_id'].toString();
            }

            // SAFE NAME HANDLING
            String name = "Unnamed";
            if (product.containsKey('name') && product['name'] != null) {
              name = product['name'].toString();
            }

            // SAFE ADDRESS HANDLING
            String address = "Unknown";
            if (product.containsKey('address') && product['address'] != null) {
              address = product['address'].toString();
            }

            // SAFE DESCRIPTION HANDLING
            String description = "";
            if (product.containsKey('description') && product['description'] != null) {
              description = product['description'].toString();
            }

            return {
              "id": id,
              "imageUrl": imageUrl,
              "tag": categoryName,
              "title": name,
              "location": address,
              "price": price,
              "bed": bed,
              "bath": bath,
              "area": area,
              "description": description,
              // NEW: Add contact and user info
              "contact": contact,
              "user": user,
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
      print('Error response: ${response.body}');
      setState(() {
        nearestProducts = [];
        isLoadingNearestProducts = false;
      });
    }
  } catch (e) {
    print("Error fetching nearest products: $e");
    print("Error type: ${e.runtimeType}"); // Debug print
    print("Stack trace: ${StackTrace.current}"); // Debug print

    setState(() {
      nearestProducts = [];
      isLoadingNearestProducts = false;
    });
  }
}

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://estatehouz-backend.onrender.com/api/auth/getall-categories'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          setState(() {
            categories = List<Map<String, dynamic>>.from(
              data['categories'].map((category) => {
                'id': category['_id'],
                'name': category['name'],
                'image': category['image'],
              }),
            );

            isLoadingCategories = false;
          });
        }
      }
    } catch (e) {
      print("Category error $e");

      setState(() {
        isLoadingCategories = false;
      });
    }
  }

  void _retryInitialization() {
    _initializeLocationAndData();
  }

  void _filterByCategory(String? categoryId, String? categoryName) {
    setState(() {
      if (_selectedCategoryId == categoryId) {
        // If same category is clicked, clear filter
        _selectedCategoryId = null;
        _selectedCategoryName = null;
      } else {
        _selectedCategoryId = categoryId;
        _selectedCategoryName = categoryName;
      }
    });
    fetchNearestProducts();
  }

  void _clearCategoryFilter() {
    setState(() {
      _selectedCategoryId = null;
      _selectedCategoryName = null;
    });
    fetchNearestProducts();
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
                  
                  // Section Header with optional category filter indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: _SectionHeader(
                          title: _selectedCategoryName != null 
                              ? "$_selectedCategoryName" 
                              : "Listing",
                          onSeeAll: () {
                            if (_selectedCategoryId != null) {
                              _clearCategoryFilter();
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NearestHouses()),
                              );
                            }
                          },
                          showClearFilter: _selectedCategoryId != null,
                          onClearFilter: _clearCategoryFilter,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Properties List with skeleton loading
                  isLoadingNearestProducts
                      ? _buildSkeletonLoader()
                      : displayProducts.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.house_outlined,
                                      size: 60,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      _selectedCategoryName != null
                                          ? "No $_selectedCategoryName properties found"
                                          : "No Properties Found",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                    if (_selectedCategoryId != null) ...[
                                      const SizedBox(height: 12),
                                      TextButton(
                                        onPressed: _clearCategoryFilter,
                                        child: const Text('Clear Filter'),
                                      ),
                                    ],
                                  ],
                                ),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NearestHouseDetail(

                                           productId: property['id'],

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

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
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
              // Image skeleton
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title skeleton
                    Container(
                      height: 16,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Stats skeleton
                    Row(
                      children: [
                        _buildSkeletonChip(),
                        const SizedBox(width: 12),
                        _buildSkeletonChip(),
                        const SizedBox(width: 12),
                        _buildSkeletonChip(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(color: Colors.grey.shade200, height: 1),
                    const SizedBox(height: 10),
                    // Buttons skeleton
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSkeletonChip() {
    return Container(
      width: 60,
      height: 14,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
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
        const PixelmindLogoButton(), 
        // Location Icon
        IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: _handleLocationUpdate,
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

  Widget _buildCategoriesRow() {
    if (isLoadingCategories) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) => _buildCategorySkeleton()),
      );
    }

    final displayCategories = categories.take(4).toList();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: displayCategories.map((cat) {
        return _CategoryItem(
          categoryId: cat['id'],
          label: cat['name'],
          image: cat['image'],
          isSelected: _selectedCategoryId == cat['id'],
          onTap: () => _filterByCategory(cat['id'], cat['name']),
        );
      }).toList(),
    );
  }

  Widget _buildCategorySkeleton() {
    return Column(
      children: [
        Container(
          width: 75,
          height: 84,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
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
  final bool showClearFilter;
  final VoidCallback? onClearFilter;

  const _SectionHeader({
    required this.title, 
    required this.onSeeAll,
    this.showClearFilter = false,
    this.onClearFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showClearFilter && onClearFilter != null)
          Row(
            children: [
              GestureDetector(
                onTap: onClearFilter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.clear, size: 14),
                      SizedBox(width: 2),
                      Text(
                        "Clear",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        GestureDetector(
          onTap: onSeeAll,
          child: Row(
            children: [
              Text(
                showClearFilter ? "All" : "See All",
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
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.label,
    required this.image,
    required this.categoryId,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 75,
            height: 84,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [
                        Color(0xFFE33629),
                        Color(0xFF9D0D0D),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : const LinearGradient(
                            colors: [
                        Color(0xFFE33629),
                        Color(0xFF9D0D0D),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(16),
              border: isSelected
                  ? Border.all(color: const Color(0xFFE33629), width: 2)
                  : null,
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
                    color: isSelected ? const Color(0xFFE33629) : Colors.grey,
                    errorBuilder: (_, __, ___) {
                      return Icon(
                        Icons.category,
                        color: isSelected ? const Color(0xFFE33629) : Colors.grey,
                        size: 20,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
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
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen()));
              },
              child: const Icon(Icons.chevron_right, size: 18, color: Colors.black54)
              ),
          ],
        ),
      ),
    );
  }
}

// ── Property Card ─────────────────────────────────────────────────────────────
// ── Property Card ─────────────────────────────────────────────────────────────
// ── Property Card ─────────────────────────────────────────────────────────────
// ── Property Card ─────────────────────────────────────────────────────────────
class _PropertyListCard extends StatelessWidget {
  final Map<String, dynamic> property;
  final VoidCallback onTap;

  const _PropertyListCard({
    super.key,
    required this.property,
    required this.onTap,
  });

  // Helper method to get the best available phone number
  String _getAgentPhone() {
    // Try to get from contact object first
    if (property.containsKey('contact') && property['contact'] != null) {
      final contact = property['contact'] as Map<String, dynamic>;
      if (contact.containsKey('callNumber') && contact['callNumber'] != null) {
        return contact['callNumber'].toString().replaceAll('+', '');
      }
      if (contact.containsKey('whatsappNumber') && contact['whatsappNumber'] != null) {
        return contact['whatsappNumber'].toString().replaceAll('+', '');
      }
    }
    
    // Then try from user object
    if (property.containsKey('user') && property['user'] != null) {
      final user = property['user'] as Map<String, dynamic>;
      if (user.containsKey('mobile') && user['mobile'] != null) {
        return user['mobile'].toString().replaceAll('+', '');
      }
    }
    
    // Default fallback
    return '919961593179';
  }

  // Helper method to get agent name
  String _getAgentName() {
    if (property.containsKey('user') && property['user'] != null) {
      final user = property['user'] as Map<String, dynamic>;
      if (user.containsKey('name') && user['name'] != null) {
        return user['name'].toString();
      }
    }
    return "Property Agent";
  }

  // Helper method to get the primary display name/title
String _getPrimaryTitle() {
  // Look for "title" first (since that's what you're storing in the map)
  if (property.containsKey('title') && property['title'] != null) {
    final title = property['title'].toString();
    if (title.isNotEmpty) {
      return title;
    }
  }
  
  // Fallback to "name" just in case
  if (property.containsKey('name') && property['name'] != null) {
    final name = property['name'].toString();
    if (name.isNotEmpty) {
      return name;
    }
  }
  
  return 'Listing';
}
  // Helper method to get secondary information/description
  String _getSecondaryInfo() {
    final category = property['tag']?.toString().toLowerCase() ?? '';
    final attributes = property.containsKey('attributes') 
        ? property['attributes'] as Map<String, dynamic> 
        : null;

    if (attributes == null) return '';

    List<String> info = [];

    switch (category) {
      case 'companies':
        if (attributes.containsKey('businessType')) {
          info.add(attributes['businessType'].toString());
        }
        if (attributes.containsKey('industry')) {
          info.add(attributes['industry'].toString());
        }
        if (attributes.containsKey('services')) {
          final services = attributes['services'];
          if (services is List) {
            info.addAll(services.cast<String>());
          } else {
            info.add(services.toString());
          }
        }
        break;

      case 'gold shops':
        if (attributes.containsKey('services')) {
          final services = attributes['services'];
          if (services is List) {
            info.addAll(services.cast<String>());
          } else {
            info.add(services.toString());
          }
        }
        if (attributes.containsKey('certified') && attributes['certified'] == true) {
          info.add("BIS Certified");
        }
        if (attributes.containsKey('hallmarkAvailable') && attributes['hallmarkAvailable'] == true) {
          info.add("Hallmark");
        }
        break;

      case 'villa':
      case 'apartment':
      case 'farmhouse':
        // For properties, we'll show bedroom/bathroom info later
        break;

      default:
        // For unknown categories, show any relevant text fields
        final textFields = ['type', 'service', 'category', 'description'];
        for (var field in textFields) {
          if (attributes.containsKey(field) && attributes[field] != null) {
            info.add(attributes[field].toString());
            break;
          }
        }
        break;
    }

    return info.isNotEmpty ? info.join(' • ') : '';
  }

  // Helper method to check if this is a property type (has bedrooms/bathrooms)
  bool _isPropertyType() {
    final category = property['tag']?.toString().toLowerCase() ?? '';
    final propertyTypes = ['villa', 'apartment', 'farmhouse', 'house', 'flat', 'land'];
    
    return propertyTypes.any((type) => category.contains(type));
  }

  // Helper method to get property stats (bed/bath/area)
  Map<String, String> _getPropertyStats() {
    final attributes = property.containsKey('attributes') 
        ? property['attributes'] as Map<String, dynamic> 
        : null;

    if (attributes == null) {
      return {'bed': 'N/A', 'bath': 'N/A', 'area': 'N/A'};
    }

    String bed = "N/A";
    String bath = "N/A";
    String area = "N/A";

    // Get bedrooms
    if (attributes.containsKey('bedrooms')) {
      final bedrooms = attributes['bedrooms'];
      if (bedrooms is num) {
        bed = "${bedrooms.toStringAsFixed(0)} Bed";
      } else if (bedrooms is String) {
        bed = "$bedrooms Bed";
      } else if (bedrooms != null) {
        bed = "$bedrooms Bed";
      }
    }

    // Get bathrooms
    if (attributes.containsKey('bathrooms')) {
      final bathrooms = attributes['bathrooms'];
      if (bathrooms is num) {
        bath = "${bathrooms.toStringAsFixed(0)} Bath";
      } else if (bathrooms is String) {
        bath = "$bathrooms Bath";
      } else if (bathrooms != null) {
        bath = "$bathrooms Bath";
      }
    }

    // Get area
    if (attributes.containsKey('sqft')) {
      final sqft = attributes['sqft'];
      if (sqft is num) {
        area = "${sqft.toStringAsFixed(0)} sqft";
      } else if (sqft is String) {
        area = "$sqft sqft";
      } else if (sqft != null) {
        area = "$sqft sqft";
      }
    } else if (attributes.containsKey('landSize')) {
      final unit = attributes.containsKey('unit') ? attributes['unit']?.toString() ?? '' : '';
      final landSize = attributes['landSize'];
      if (landSize is num) {
        area = "${landSize.toStringAsFixed(1)} $unit";
      } else if (landSize is String) {
        area = "$landSize $unit";
      } else if (landSize != null) {
        area = "$landSize $unit";
      }
    }

    return {'bed': bed, 'bath': bath, 'area': area};
  }

  // Helper method to get price
  String _getPrice() {
    final category = property['tag']?.toString().toLowerCase() ?? '';
    final attributes = property.containsKey('attributes') 
        ? property['attributes'] as Map<String, dynamic> 
        : null;

    // Don't show price for companies and gold shops
    if (category.contains('companies') || category.contains('gold')) {
      return '';
    }

    if (attributes != null && attributes.containsKey('price')) {
      final priceValue = attributes['price'];
      if (priceValue is num) {
        return "₹${priceValue.toStringAsFixed(0)}";
      } else if (priceValue is String) {
        return "₹$priceValue";
      } else if (priceValue != null) {
        return "₹$priceValue";
      }
    }

    return '';
  }

  // Helper method to get category-specific icon
  IconData _getCategoryIcon() {
    final category = property['tag']?.toString().toLowerCase() ?? '';
    
    if (category.contains('companies')) {
      return Icons.business;
    } else if (category.contains('gold')) {
      return Icons.diamond;
    } else if (category.contains('villa') || category.contains('house')) {
      return Icons.house;
    } else if (category.contains('apartment')) {
      return Icons.apartment;
    } else if (category.contains('hotel')) {
      return Icons.hotel;
    } else if (category.contains('land') || category.contains('farm')) {
      return Icons.landscape;
    }
    
    return Icons.image_not_supported;
  }

  // Helper method to get category color
  Color _getCategoryColor() {
    final category = property['tag']?.toString().toLowerCase() ?? '';
    
    if (category.contains('companies')) {
      return Colors.blue;
    } else if (category.contains('gold')) {
      return Colors.amber;
    } else if (category.contains('villa') || category.contains('house')) {
      return const Color(0xFFE33629);
    } else if (category.contains('apartment')) {
      return Colors.green;
    } else if (category.contains('hotel')) {
      return Colors.purple;
    } else if (category.contains('land') || category.contains('farm')) {
      return Colors.orange;
    }
    
    return const Color(0xFFE33629);
  }

  // Helper method to get custom WhatsApp message based on category
  String _getWhatsAppMessage() {
    final category = property['tag']?.toString().toLowerCase() ?? '';
    final title = _getPrimaryTitle();
    
    if (category.contains('companies')) {
      return "Hi, I'm interested in your business services at $title. Can you provide more details about your services and pricing?";
    } else if (category.contains('gold')) {
      return "Hi, I'm interested in your products at $title. Can you share current gold rates, offers, and available designs?";
    } else if (category.contains('hotel')) {
      return "Hi, I'm interested in booking at $title. Can you share room availability, rates, and amenities?";
    } else if (category.contains('villa') || category.contains('apartment') || category.contains('house')) {
      return "Hi, I'm interested in the property at $title. Can you provide more details and schedule a visit?";
    }
    
    return "Hi, I'm interested in your listing. Can you provide more details?";
  }

  @override
  Widget build(BuildContext context) {
    final isProperty = _isPropertyType();
    final stats = _getPropertyStats();
    final price = _getPrice();
    final primaryTitle = _getPrimaryTitle();
    final secondaryInfo = _getSecondaryInfo();
    final categoryColor = _getCategoryColor();
    final categoryIcon = _getCategoryIcon();
    final whatsAppMessage = _getWhatsAppMessage();
    
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        final isInWishlist = wishlistProvider.isInWishlist(property['id']);
        final agentPhone = _getAgentPhone();
        final agentName = _getAgentName();

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
                // Image Section
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
                                    child: Center(
                                      child: Icon(
                                        categoryIcon,
                                        size: 50,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                color: Colors.grey.shade300,
                                child: Center(
                                  child: Icon(
                                    categoryIcon,
                                    size: 50,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                      ),
                    ),
                    
                    // Category Badge
    Positioned(
  top: 10,
  left: 10,
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: categoryColor,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      // Fix: Access the nested category name
      property['category'] != null && property['category'] is Map
          ? (property['category']['name']?.toString() ?? 'Listing')
          : (property['tag'] ?? 'Listing'),
      style: const TextStyle(
        fontSize: 10,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
),
                    
                    // Favorite Button
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
                      // Primary Title
                      Text(
                        primaryTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Secondary Information
                      if (secondaryInfo.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          secondaryInfo,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      // Location
                      if (property['location'] != "Unknown") ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                property['location'],
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],

                      // Price (for property types only)
                      if (price.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE33629),
                          ),
                        ),
                      ],

                      // Property Stats (for property types only)
                      if (isProperty && 
                          (stats['bed'] != "N/A" || 
                           stats['bath'] != "N/A" || 
                           stats['area'] != "N/A")) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (stats['bed'] != "N/A")
                              _StatChip(
                                imagePath: 'assets/images/bed.png',
                                label: stats['bed']!,
                              ),
                            if (stats['bed'] != "N/A" && 
                                (stats['bath'] != "N/A" || stats['area'] != "N/A"))
                              const SizedBox(width: 12),
                            
                            if (stats['bath'] != "N/A")
                              _StatChip(
                                imagePath: 'assets/images/bath.png',
                                label: stats['bath']!,
                              ),
                            if (stats['bath'] != "N/A" && stats['area'] != "N/A")
                              const SizedBox(width: 12),
                            
                            if (stats['area'] != "N/A")
                              _StatChip(
                                imagePath: 'assets/images/sqft.png',
                                label: stats['area']!,
                              ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 12),
                      Divider(color: Colors.grey.shade200, height: 1),
                      const SizedBox(height: 10),

                      // Action Buttons Row
                      Row(
                        children: [
                          // Call Button
                          _CallButton(onTap: () {
                            CallUtils.showCallOptions(
                              context: context,
                              phoneNumber: agentPhone,
                              name: '',
                              showMessage: true,
                              showWhatsApp: true,
                            );
                          }),
                          
                          // WhatsApp Button
                          const SizedBox(width: 12),
                          _ActionButton(
                            imagePath: 'assets/images/whatsapp.png',
                            label: "Whatsapp",
                            onTap: () {
                              WhatsAppUtils.shareProperty(
                                context: context,
                                propertyTitle: primaryTitle,
                                propertyLocation: property['location'],
                                propertyPrice: price.isNotEmpty ? price : 'Contact for details',
                                agentPhone: "+91$agentPhone",
                              );
                            },
                          ),
                          
                          const Spacer(),
                          
                          // Location Button
                          if (property['location'] != "Unknown")
                            _ActionButton(
                              imagePath: 'assets/images/location.png',
                              label: "Location",
                              onTap: () {
                                LocationUtils.openMap(
                                  context: context,
                                  latitude: 28.6139,
                                  longitude: 77.2090,
                                  address: property['location'],
                                  label: primaryTitle,
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
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.circle,
                size: 8,
                color: Colors.grey.shade500,
              ),
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
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.circle,
                  size: 8,
                  color: Colors.grey.shade500,
                ),
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