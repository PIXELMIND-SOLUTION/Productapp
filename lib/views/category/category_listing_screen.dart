// category_listing_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/utils/call_utils.dart';
import 'package:product_app/utils/location_utils.dart';
import 'package:product_app/utils/whatsapp_utils.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';
import 'package:product_app/views/Listing/listing_screen.dart';
import 'package:provider/provider.dart';

class CategoryListingScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CategoryListingScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CategoryListingScreen> createState() => _CategoryListingScreenState();
}

class _CategoryListingScreenState extends State<CategoryListingScreen>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> categoryProducts = [];
  bool isLoading = true;
  String? errorMessage;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    fetchCategoryProducts();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchCategoryProducts() async {
    final userId = SharedPrefHelper.getUserId();

    if (userId == null) {
      setState(() {
        isLoading = false;
        errorMessage = 'User not logged in';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Build URL with category filter
      String url = '${ApiConstants.baseUrl}/api/nearest/user/$userId/${widget.categoryId}';

      print('Fetching category products from: $url'); // Debug print

      final response = await http.get(
        Uri.parse(url),
      );

      print('Response status: ${response.statusCode}'); // Debug print

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true && data['products'] != null) {
          final List products = data['products'];

          setState(() {
            categoryProducts = products.map<Map<String, dynamic>>((item) {
              // SAFE CASTING: Handle any type of item safely
              Map<String, dynamic> product = {};
              
              if (item is Map) {
                try {
                  product = Map<String, dynamic>.from(item);
                } catch (e) {
                  print('Error converting item to Map: $e');
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
                    final Map<String, dynamic> tempAttrs = {};
                    attrs.forEach((key, value) {
                      tempAttrs[key.toString()] = value;
                    });
                    attributes = tempAttrs;
                  }
                }
              }

              // SAFE CONTACT HANDLING
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
              String categoryName = widget.categoryName;
              Map<String, dynamic> category = {};
              if (product.containsKey('category') && product['category'] != null) {
                final cat = product['category'];
                if (cat is Map) {
                  try {
                    category = Map<String, dynamic>.from(cat);
                    if (category.containsKey('name') && category['name'] != null) {
                      categoryName = category['name'].toString();
                    }
                  } catch (e) {
                    print('Error converting category: $e');
                  }
                }
              }

              // SAFE USER HANDLING
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
                "contact": contact,
                "user": user,
                "category": category, // Add full category object
                "attributes": attributes, // Add attributes
              };
            }).toList();

            isLoading = false;
          });
        } else {
          setState(() {
            categoryProducts = [];
            isLoading = false;
            errorMessage = 'No properties found in this category';
          });
        }
      } else {
        print('Error response: ${response.body}');
        setState(() {
          categoryProducts = [];
          isLoading = false;
          errorMessage = 'Failed to load properties';
        });
      }
    } catch (e) {
      print("Error fetching category products: $e");
      print("Error type: ${e.runtimeType}");
      
      setState(() {
        categoryProducts = [];
        isLoading = false;
        errorMessage = 'Network error. Please try again.';
      });
    }
  }

  // Helper method to get category-specific icon
  IconData _getCategoryIcon() {
    final category = widget.categoryName.toLowerCase();
    
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
    
    return Icons.category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey.shade200,
            height: 1,
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: isLoading
            ? _buildSkeletonLoader()
            : errorMessage != null || categoryProducts.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
                    onRefresh: fetchCategoryProducts,
                    color: const Color(0xFFE33629),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: categoryProducts.length,
                      itemBuilder: (context, index) {
                        final property = categoryProducts[index];
                        return _CategoryPropertyCard(
                          key: ValueKey(property['id']),
                          property: property,
                          categoryName: widget.categoryName,
                          categoryIcon: _getCategoryIcon(),
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
                  ),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getCategoryIcon(),
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Properties Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'No properties available in ${widget.categoryName}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: fetchCategoryProducts,
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
    );
  }
}

// Category Property Card - Similar to home screen's property card
class _CategoryPropertyCard extends StatelessWidget {
  final Map<String, dynamic> property;
  final String categoryName;
  final IconData categoryIcon;
  final VoidCallback onTap;

  const _CategoryPropertyCard({
    super.key,
    required this.property,
    required this.categoryName,
    required this.categoryIcon,
    required this.onTap,
  });

  // Helper method to get the best available phone number
  String _getAgentPhone() {
    if (property.containsKey('contact') && property['contact'] != null) {
      final contact = property['contact'] as Map<String, dynamic>;
      if (contact.containsKey('callNumber') && contact['callNumber'] != null) {
        return contact['callNumber'].toString().replaceAll('+', '');
      }
      if (contact.containsKey('whatsappNumber') && contact['whatsappNumber'] != null) {
        return contact['whatsappNumber'].toString().replaceAll('+', '');
      }
    }
    
    if (property.containsKey('user') && property['user'] != null) {
      final user = property['user'] as Map<String, dynamic>;
      if (user.containsKey('mobile') && user['mobile'] != null) {
        return user['mobile'].toString().replaceAll('+', '');
      }
    }
    
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

  // Helper method to check if this is a property type
  bool _isPropertyType() {
    final category = categoryName.toLowerCase();
    final propertyTypes = ['villa', 'apartment', 'farmhouse', 'house', 'flat', 'land'];
    
    return propertyTypes.any((type) => category.contains(type));
  }

  // Helper method to get property stats
  Map<String, String> _getPropertyStats() {
    final attributes = property.containsKey('attributes') 
        ? property['attributes'] as Map<String, dynamic> 
        : null;

    if (attributes == null) {
      return {'bed': 'N/A', 'bath': 'N/A', 'area': 'N/A'};
    }

    String bed = property['bed'] ?? "N/A";
    String bath = property['bath'] ?? "N/A";
    String area = property['area'] ?? "N/A";

    return {'bed': bed, 'bath': bath, 'area': area};
  }

  // Helper method to get secondary information
  String _getSecondaryInfo() {
    final attributes = property.containsKey('attributes') 
        ? property['attributes'] as Map<String, dynamic> 
        : null;

    if (attributes == null) return '';

    List<String> info = [];

    switch (categoryName.toLowerCase()) {
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

      default:
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

  // Helper method to get category color
  Color _getCategoryColor() {
    final category = categoryName.toLowerCase();
    
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

  // Helper method to get custom WhatsApp message
  String _getWhatsAppMessage() {
    final title = property['title'] ?? 'Listing';
    
    if (categoryName.toLowerCase().contains('companies')) {
      return "Hi, I'm interested in your business services at $title. Can you provide more details about your services and pricing?";
    } else if (categoryName.toLowerCase().contains('gold')) {
      return "Hi, I'm interested in your products at $title. Can you share current gold rates, offers, and available designs?";
    } else if (categoryName.toLowerCase().contains('hotel')) {
      return "Hi, I'm interested in booking at $title. Can you share room availability, rates, and amenities?";
    } else if (categoryName.toLowerCase().contains('villa') || 
               categoryName.toLowerCase().contains('apartment') || 
               categoryName.toLowerCase().contains('house')) {
      return "Hi, I'm interested in the property at $title. Can you provide more details and schedule a visit?";
    }
    
    return "Hi, I'm interested in your listing. Can you provide more details?";
  }

  @override
  Widget build(BuildContext context) {
    final isProperty = _isPropertyType();
    final stats = _getPropertyStats();
    final price = property['price'] != "Price N/A" ? property['price'] : '';
    final primaryTitle = property['title'] ?? 'Listing';
    final secondaryInfo = _getSecondaryInfo();
    final categoryColor = _getCategoryColor();
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
                          categoryName,
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

// Reusable Stat Chip
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

// Reusable Call Button
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

// Reusable Action Button
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