import 'package:flutter/material.dart';
import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
import 'package:product_app/utils/call_utils.dart';
import 'package:product_app/utils/whatsapp_utils.dart';
import 'package:product_app/utils/location_utils.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';
import 'package:product_app/views/widgets/app_back_control.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishlistProvider>().fetchWishlist();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Helper method to safely parse contact data
  Map<String, dynamic>? _parseContact(dynamic contactData) {
    if (contactData == null) return null;

    if (contactData is Map) {
      return Map<String, dynamic>.from(contactData);
    } else if (contactData is String) {
      try {
        final decoded = json.decode(contactData);
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } catch (e) {
        print('Error parsing contact JSON: $e');
      }
    }
    return null;
  }

  // Helper method to get the best available phone number from item
  String _getAgentPhone(Map<String, dynamic> item) {
    // Try to get from contact object first
    if (item.containsKey('contact') && item['contact'] != null) {
      final contact = _parseContact(item['contact']);
      if (contact != null) {
        if (contact.containsKey('callNumber') &&
            contact['callNumber'] != null) {
          return contact['callNumber'].toString().replaceAll('+', '');
        }
        if (contact.containsKey('whatsappNumber') &&
            contact['whatsappNumber'] != null) {
          return contact['whatsappNumber'].toString().replaceAll('+', '');
        }
      }
    }

    // Then try from user object
    if (item.containsKey('user') && item['user'] != null) {
      if (item['user'] is Map) {
        final user = Map<String, dynamic>.from(item['user']);
        if (user.containsKey('mobile') && user['mobile'] != null) {
          return user['mobile'].toString().replaceAll('+', '');
        }
      }
    }

    // Default fallback
    return "919961593179";
  }

  // Helper method to get agent name
  String _getAgentName(Map<String, dynamic> item) {
    if (item.containsKey('user') && item['user'] != null) {
      if (item['user'] is Map) {
        final user = Map<String, dynamic>.from(item['user']);
        if (user.containsKey('name') && user['name'] != null) {
          return user['name'].toString();
        }
      }
    }
    return "Property Agent";
  }

  // Helper method to get agent email
  String? _getAgentEmail(Map<String, dynamic> item) {
    // Try to get from contact object first
    if (item.containsKey('contact') && item['contact'] != null) {
      final contact = _parseContact(item['contact']);
      if (contact != null &&
          contact.containsKey('email') &&
          contact['email'] != null) {
        return contact['email'].toString();
      }
    }

    // Then try from user object
    if (item.containsKey('user') && item['user'] != null) {
      if (item['user'] is Map) {
        final user = Map<String, dynamic>.from(item['user']);
        if (user.containsKey('email') && user['email'] != null) {
          return user['email'].toString();
        }
      }
    }
    return null;
  }

  // Helper method to get agent website
  String? _getAgentWebsite(Map<String, dynamic> item) {
    if (item.containsKey('contact') && item['contact'] != null) {
      final contact = _parseContact(item['contact']);
      if (contact != null &&
          contact.containsKey('website') &&
          contact['website'] != null) {
        return contact['website'].toString();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: AppBackControl(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Consumer<WishlistProvider>(
                  builder: (context, wishlistProvider, child) {
                    if (wishlistProvider.isLoading &&
                        wishlistProvider.wishlistItems.isEmpty) {
                      return _buildLoadingState();
                    }

                    if (wishlistProvider.errorMessage != null &&
                        wishlistProvider.wishlistItems.isEmpty) {
                      return _buildErrorState(wishlistProvider);
                    }

                    if (wishlistProvider.wishlistItems.isEmpty) {
                      return _buildEmptyState();
                    }

                    return _buildWishlistContent(wishlistProvider);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Wishlist',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey.shade200),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _buildSkeletonCard();
      },
    );
  }

  Widget _buildSkeletonCard() {
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
                // Location skeleton
                Row(
                  children: [
                    Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      height: 12,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
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
                const SizedBox(height: 12),
                // View Details button skeleton
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  Widget _buildErrorState(WishlistProvider wishlistProvider) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              wishlistProvider.errorMessage ?? 'Something went wrong',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                wishlistProvider.fetchWishlist();
              },
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
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                size: 48,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your wishlist is empty',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start adding properties to your wishlist',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistContent(WishlistProvider wishlistProvider) {
    return RefreshIndicator(
      onRefresh: () => wishlistProvider.refreshWishlist(),
      color: const Color(0xFFE33629),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wishlistProvider.wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistProvider.wishlistItems[index];
          return _buildPropertyCard(item, wishlistProvider, index);
        },
      ),
    );
  }

  // Helper method to safely extract value from nested maps
  dynamic _safeGet(Map<String, dynamic> map, List<String> keys,
      {dynamic defaultValue}) {
    dynamic value = map;
    for (String key in keys) {
      if (value == null || value is! Map || !value.containsKey(key)) {
        return defaultValue;
      }
      value = value[key];
    }
    return value ?? defaultValue;
  }

  // Helper method to format price
  String _formatPrice(dynamic price) {
    if (price == null) return '';

    if (price is num) {
      if (price >= 10000000) {
        return '₹${(price / 10000000).toStringAsFixed(2)} Cr';
      } else if (price >= 100000) {
        return '₹${(price / 100000).toStringAsFixed(2)} Lac';
      } else if (price >= 1000) {
        return '₹${(price / 1000).toStringAsFixed(0)}k';
      } else {
        return '₹${price.toStringAsFixed(0)}';
      }
    } else if (price is String) {
      return '₹$price';
    }
    return '';
  }

  // Helper method to safely parse attributes
  Map<String, dynamic> _parseAttributes(dynamic attributesData) {
    if (attributesData == null) return {};

    if (attributesData is Map) {
      return Map<String, dynamic>.from(attributesData);
    } else if (attributesData is String) {
      try {
        final decoded = json.decode(attributesData);
        if (decoded is Map) {
          return Map<String, dynamic>.from(decoded);
        }
      } catch (e) {
        print('Error parsing attributes JSON: $e');
      }
    }
    return {};
  }

  Widget _buildPropertyCard(
      dynamic item, WishlistProvider wishlistProvider, int index) {
    // Safely convert item to Map
    Map<String, dynamic> productMap;
    if (item is Map) {
      productMap = Map<String, dynamic>.from(item);
    } else {
      productMap = {};
    }

    // Safely extract product data with null checks
    final productId = productMap['_id']?.toString() ?? '';
    final productName = productMap['name']?.toString() ?? 'Unnamed Property';
    final productType = productMap['type']?.toString() ?? '';
    final productAddress = productMap['address']?.toString() ?? '';
    final productDescription = productMap['description']?.toString() ??
        'Beautiful property located in prime area with modern amenities and peaceful surroundings.';

    // Get contact information dynamically
    final agentPhone = _getAgentPhone(productMap);
    final agentName = _getAgentName(productMap);
    final agentEmail = _getAgentEmail(productMap);
    final agentWebsite = _getAgentWebsite(productMap);

    // Safely extract price
    String formattedPrice = '';
    if (productMap.containsKey('price') && productMap['price'] != null) {
      formattedPrice = _formatPrice(productMap['price']);
    } else if (productMap.containsKey('attributes') &&
        productMap['attributes'] != null) {
      final attributes = _parseAttributes(productMap['attributes']);
      if (attributes.containsKey('price')) {
        formattedPrice = _formatPrice(attributes['price']);
      }
    }

    // Safely extract images
    List<String> images = [];
    if (productMap.containsKey('images') && productMap['images'] is List) {
      images = (productMap['images'] as List)
          .where((img) => img != null && img.toString().isNotEmpty)
          .map((img) => img.toString())
          .toList();
    }

    // Safely extract features/attributes
    final attributes = _parseAttributes(productMap['attributes']);

    // Extract bedroom, bathroom, area from attributes
    String bed = '';
    String bath = '';
    String area = '';

    // Check attributes first
    if (attributes.containsKey('bedrooms')) {
      final bedrooms = attributes['bedrooms'];
      if (bedrooms is num) {
        bed = '${bedrooms.toStringAsFixed(0)} Bed';
      } else if (bedrooms is String) {
        bed = bedrooms.contains('Bed') ? bedrooms : '$bedrooms Bed';
      }
    } else if (attributes.containsKey('bed')) {
      final beds = attributes['bed'];
      if (beds is num) {
        bed = '${beds.toStringAsFixed(0)} Bed';
      } else if (beds is String) {
        bed = beds.contains('Bed') ? beds : '$beds Bed';
      }
    }

    if (attributes.containsKey('bathrooms')) {
      final bathrooms = attributes['bathrooms'];
      if (bathrooms is num) {
        bath = '${bathrooms.toStringAsFixed(0)} Bath';
      } else if (bathrooms is String) {
        bath = bathrooms.contains('Bath') ? bathrooms : '$bathrooms Bath';
      }
    } else if (attributes.containsKey('bath')) {
      final baths = attributes['bath'];
      if (baths is num) {
        bath = '${baths.toStringAsFixed(0)} Bath';
      } else if (baths is String) {
        bath = baths.contains('Bath') ? baths : '$baths Bath';
      }
    }

    // AREA / LAND SIZE
    if (attributes.containsKey('landSize')) {
      final landSize = attributes['landSize'];
      final unit = attributes['unit']?.toString() ?? '';

      if (landSize is num) {
        area = '${landSize.toString()} $unit';
      } else if (landSize is String) {
        area = '$landSize $unit';
      }
    } else if (attributes.containsKey('sqft')) {
      final sqft = attributes['sqft'];
      if (sqft is num) {
        area = '${sqft.toStringAsFixed(0)} sqft';
      } else if (sqft is String) {
        area = sqft.contains('sqft') ? sqft : '$sqft sqft';
      }
    } else if (attributes.containsKey('area')) {
      final areaValue = attributes['area'];
      if (areaValue is num) {
        area = '${areaValue.toStringAsFixed(0)} sqft';
      } else if (areaValue is String) {
        area = areaValue.contains('sqft') ? areaValue : '$areaValue sqft';
      }
    }

    // Extract location coordinates if available
    double? latitude;
    double? longitude;
    if (productMap.containsKey('location') && productMap['location'] is Map) {
      final location = productMap['location'] as Map;
      if (location.containsKey('coordinates') &&
          location['coordinates'] is List) {
        final coordinates = location['coordinates'] as List;
        if (coordinates.length >= 2) {
          longitude = coordinates[0]?.toDouble();
          latitude = coordinates[1]?.toDouble();
        }
      }
    }

    // Create house object for navigation
    Map<String, dynamic> house = {
      'id': productId,
      'image': images.isNotEmpty ? images.first : '',
      'images': images,
      'tag': productType,
      'title': productName,
      'location': productAddress,
      'price': formattedPrice.isNotEmpty ? formattedPrice : 'Price on Request',
      'beds': bed.isNotEmpty ? bed : null,
      'baths': bath.isNotEmpty ? bath : null,
      'area': area.isNotEmpty ? area : null,
      'description': productDescription,
      'latitude': latitude,
      'longitude': longitude,
      'attributes': attributes,
      'contact': {
        'phone': agentPhone,
        'email': agentEmail,
        'website': agentWebsite,
      },
    };

    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 300 + (index * 100)),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NearestHouseDetail(productId: productId),
            ),
          );
        },
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
              /// Property Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: SizedBox(
                      height: 180,
                      width: double.infinity,
                      child:
                          images.isNotEmpty && images.first.startsWith('http')
                              ? Image.network(
                                  images.first,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade300,
                                      child: const Center(
                                        child: Icon(Icons.image_not_supported,
                                            size: 50, color: Colors.grey),
                                      ),
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey.shade200,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Colors.grey.shade300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image_not_supported,
                                        size: 50,
                                        color: Colors.grey.shade500,
                                      ),
                                    ],
                                  ),
                                ),
                    ),
                  ),

                  // Type Badge - Only show if type exists
                  if (productType.isNotEmpty)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          productType,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
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
                        if (!wishlistProvider.isToggling) {
                          final success =
                              await wishlistProvider.toggleWishlist(productId);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor:
                                    success ? Colors.green : Colors.red,
                                content: Text(
                                  success
                                      ? 'Removed from wishlist'
                                      : (wishlistProvider.errorMessage ??
                                          'Failed to remove'),
                                ),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: wishlistProvider.isToggling
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xFFE33629)),
                                ),
                              )
                            : const Icon(
                                Icons.favorite,
                                size: 16,
                                color: Color(0xFFE33629),
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
                    /// Title
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),

                    /// Location - Only show if address exists
                    if (productAddress.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/location.png',
                            width: 14,
                            height: 14,
                            errorBuilder: (_, __, ___) {
                              return const Icon(Icons.location_on,
                                  size: 14, color: Colors.grey);
                            },
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              productAddress,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],

                    /// Price - Only show if price exists
                    if (formattedPrice.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        formattedPrice,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE33629),
                        ),
                      ),
                    ],

                    const SizedBox(height: 12),

                    /// Stats Row - Only show if at least one stat exists
                    if (bed.isNotEmpty || bath.isNotEmpty || area.isNotEmpty)
                      Row(
                        children: [
                          if (bed.isNotEmpty)
                            _StatChip(
                              imagePath: 'assets/images/bed.png',
                              label: bed,
                            ),
                          if (bed.isNotEmpty &&
                              (bath.isNotEmpty || area.isNotEmpty))
                            const SizedBox(width: 12),
                          if (bath.isNotEmpty)
                            _StatChip(
                              imagePath: 'assets/images/bath.png',
                              label: bath,
                            ),
                          if (bath.isNotEmpty && area.isNotEmpty)
                            const SizedBox(width: 12),
                          if (area.isNotEmpty)
                            _StatChip(
                              imagePath: 'assets/images/sqft.png',
                              label: area,
                            ),
                        ],
                      ),

                    const SizedBox(height: 10),
                    Divider(color: Colors.grey.shade200, height: 1),
                    const SizedBox(height: 10),

                    /// Action Buttons Row
                    Row(
                      children: [
                        // Call Button - Using dynamic agent phone
                        _CallButton(
                          onTap: () {
                            CallUtils.showCallOptions(
                              context: context,
                              phoneNumber: agentPhone,
                              name: agentName,
                              showMessage: true,
                              showWhatsApp: true,
                            );
                          },
                        ),
                        const SizedBox(width: 12),

                        // WhatsApp Button - Using dynamic agent phone
                        _ActionButton(
                          imagePath: 'assets/images/whatsapp.png',
                          label: "Whatsapp",
                          onTap: () {
                            WhatsAppUtils.shareProperty(
                              context: context,
                              propertyTitle: house['title'],
                              propertyLocation: house['location'],
                              propertyPrice: house['price'],
                              agentPhone: "+91$agentPhone",
                              categoryName: house['tag'], // ✅ ADD THIS
                            );
                          },
                        ),
                        const Spacer(),

                        // Location Button - Only show if coordinates or address exists
                        if (latitude != null && longitude != null ||
                            productAddress.isNotEmpty)
                          _ActionButton(
                            imagePath: 'assets/images/location.png',
                            label: "Location",
                            onTap: () {
                              if (latitude != null && longitude != null) {
                                LocationUtils.openMap(
                                  context: context,
                                  latitude: latitude!,
                                  longitude: longitude!,
                                  address: productAddress.isNotEmpty
                                      ? productAddress
                                      : 'Property Location',
                                  label: productName,
                                );
                              } else if (productAddress.isNotEmpty) {
                                LocationUtils.openMap(
                                  context: context,
                                  latitude: 28.6139, // Default fallback
                                  longitude: 77.2090, // Default fallback
                                  address: productAddress,
                                  label: productName,
                                );
                              }
                            },
                          ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// View Details Button
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            "View Details",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Stat Chip ────────────────────────────────────────────────────────────────
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

// ── Call Button ──────────────────────────────────────────────────────────────
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

// ── Action Button ────────────────────────────────────────────────────────────
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
