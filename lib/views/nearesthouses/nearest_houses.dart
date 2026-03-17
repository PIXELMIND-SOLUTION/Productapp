// import 'package:flutter/material.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'package:product_app/utils/call_utils.dart';
// import 'package:product_app/utils/whatsapp_utils.dart';
// import 'package:product_app/utils/location_utils.dart';
// import 'package:product_app/views/Details/nearest_house_detail.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class NearestHouses extends StatefulWidget {
//   const NearestHouses({super.key});

//   @override
//   State<NearestHouses> createState() => _NearestHousesState();
// }

// class _NearestHousesState extends State<NearestHouses> {
//   List<Map<String, dynamic>> houseList = [];
//   bool isLoading = true;
//   String? errorMessage;

//   // Default agent phone number - will be replaced with actual agent number from API
//   final String defaultAgentPhone = "919961593179";

//   @override
//   void initState() {
//     super.initState();
//     fetchNearestProducts();
//   }

//   Future<void> fetchNearestProducts() async {
//     final userId = SharedPrefHelper.getUserId();
//     if (userId == null) {
//       print('User ID not found');
//       setState(() {
//         isLoading = false;
//         errorMessage = 'User ID not found. Please log in again.';
//       });
//       return;
//     }

//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     try {
//       final response = await http.get(
//         Uri.parse('${ApiConstants.baseUrl}/api/nearest/user/$userId'),
//       );

//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success'] == true && data['products'] != null) {
//           setState(() {
//             houseList = (data['products'] as List).map((product) {
//               return _parseProductData(product);
//             }).toList();
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             houseList = [];
//             isLoading = false;
//             errorMessage = 'No properties found nearby.';
//           });
//         }
//       } else {
//         throw Exception('Failed to load nearest products');
//       }
//     } catch (e) {
//       print('Error fetching nearest products: $e');
//       setState(() {
//         houseList = [];
//         isLoading = false;
//         errorMessage = 'Failed to load properties. Please try again.';
//       });
//     }
//   }

//   Map<String, dynamic> _parseProductData(dynamic product) {
//     // Parse attributes (could be Map or String)
//     Map<String, dynamic> attributes = {};
//     if (product['attributes'] is Map) {
//       attributes = Map<String, dynamic>.from(product['attributes']);
//     } else if (product['attributes'] is String) {
//       try {
//         attributes = json.decode(product['attributes']);
//       } catch (e) {
//         attributes = {};
//       }
//     }

//     // Extract values from attributes
//     String bed = _extractBedrooms(attributes);
//     String bath = _extractBathrooms(attributes);
//     String area = _extractArea(attributes);
//     String price = _formatPrice(attributes['price']);

//     // Extract location coordinates
//     double? latitude;
//     double? longitude;
//     if (product['location'] is Map) {
//       final location = product['location'];
//       if (location['coordinates'] is List) {
//         final coords = location['coordinates'] as List;
//         if (coords.length >= 2) {
//           longitude = coords[0]?.toDouble();
//           latitude = coords[1]?.toDouble();
//         }
//       }
//     }

//     // Get user/agent info if available
//     Map<String, dynamic>? userData;
//     if (product['user'] is Map) {
//       userData = Map<String, dynamic>.from(product['user']);
//     }

//     return {
//       'id': product['_id']?.toString() ?? '',
//       'image': (product['images'] != null &&
//               product['images'] is List &&
//               product['images'].isNotEmpty)
//           ? product['images'][0].toString()
//           : '',
//       'images': product['images'] is List ? List.from(product['images']) : [],
//       'tag': product['name']?.toString() ?? 'For Sale',
//       'title': product['name']?.toString() ?? 'Unnamed Property',
//       'location': product['address']?.toString() ?? 'Unknown',
//       'price': price.isNotEmpty ? price : 'Price on Request',
//       'beds': bed.isNotEmpty ? bed : null,
//       'baths': bath.isNotEmpty ? bath : null,
//       'area': area.isNotEmpty ? area : null,
//       'latitude': latitude,
//       'longitude': longitude,
//       'description': product['description']?.toString() ??
//           'Beautiful property located in prime area with modern amenities and peaceful surroundings.',
//       'user': userData,
//       'category': product['category'] is Map
//           ? Map<String, dynamic>.from(product['category'])
//           : null,
//       'attributes': attributes,
//       'isApproved': product['isApproved'] ?? false,
//       'isActive': product['isActive'] ?? false,
//     };
//   }

//   String _extractBedrooms(Map<String, dynamic> attributes) {
//     if (attributes.containsKey('bedrooms')) {
//       final beds = attributes['bedrooms'];
//       if (beds is num) return '${beds.toStringAsFixed(0)} Bed';
//       if (beds is String) return '$beds Bed';
//     } else if (attributes.containsKey('landSize')) {
//       final landSize = attributes['landSize'];
//       final unit = attributes['unit'] ?? '';
//       if (landSize is num) return '${landSize.toStringAsFixed(0)} $unit';
//       if (landSize is String) return '$landSize $unit';
//     }
//     return '';
//   }

//   String _extractBathrooms(Map<String, dynamic> attributes) {
//     if (attributes.containsKey('bathrooms')) {
//       final baths = attributes['bathrooms'];
//       if (baths is num) return '${baths.toStringAsFixed(0)} Bath';
//       if (baths is String) return '$baths Bath';
//     }
//     return '';
//   }

//   String _extractArea(Map<String, dynamic> attributes) {
//     if (attributes.containsKey('sqft')) {
//       final sqft = attributes['sqft'];
//       if (sqft is num) return '${sqft.toStringAsFixed(0)} sqft';
//       if (sqft is String) return '$sqft sqft';
//     } else if (attributes.containsKey('landSize') && attributes['unit'] == 'acres') {
//       final landSize = attributes['landSize'];
//       if (landSize is num) return '${landSize.toStringAsFixed(1)} acres';
//       if (landSize is String) return '$landSize acres';
//     }
//     return '';
//   }

//   String _formatPrice(dynamic price) {
//     if (price == null) return '';

//     if (price is num) {
//       if (price >= 10000000) {
//         return '₹${(price / 10000000).toStringAsFixed(2)} Cr';
//       } else if (price >= 100000) {
//         return '₹${(price / 100000).toStringAsFixed(2)} Lac';
//       } else if (price >= 1000) {
//         return '₹${(price / 1000).toStringAsFixed(0)}k';
//       } else {
//         return '₹${price.toStringAsFixed(0)}';
//       }
//     } else if (price is String) {
//       return '₹$price';
//     }
//     return '';
//   }

//   String _getAgentPhone(Map<String, dynamic>? userData) {
//     if (userData != null && userData['mobile'] != null) {
//       return userData['mobile'].toString().replaceAll('+', '');
//     }
//     return defaultAgentPhone;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () => Navigator.of(context).pop(),
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(color: Colors.grey.shade300),
//             ),
//             child: const Icon(Icons.arrow_back, size: 18, color: Colors.black87),
//           ),
//         ),
//         title: const Text(
//           "Nearest Properties",
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//             color: Colors.black87,
//           ),
//         ),
//         centerTitle: false,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Divider(height: 1, color: Colors.grey.shade200),
//         ),
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? _buildErrorState()
//               : houseList.isEmpty
//                   ? _buildEmptyState()
//                   : RefreshIndicator(
//                       onRefresh: fetchNearestProducts,
//                       color: const Color(0xFFE33629),
//                       child: ListView.builder(
//                         padding: const EdgeInsets.all(16),
//                         itemCount: houseList.length,
//                         itemBuilder: (context, index) {
//                           final house = houseList[index];
//                           return _buildPropertyCard(house);
//                         },
//                       ),
//                     ),
//     );
//   }

//   Widget _buildErrorState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.error_outline,
//               size: 48,
//               color: Colors.grey.shade400,
//             ),
//             const SizedBox(height: 16),
//             Text(
//               errorMessage!,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: fetchNearestProducts,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFE33629),
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text('Try Again'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(32),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.home_outlined,
//                 size: 48,
//                 color: Colors.grey.shade400,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'No Properties Found',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'We couldn\'t find any properties near your location',
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey.shade600,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             OutlinedButton.icon(
//               onPressed: fetchNearestProducts,
//               icon: const Icon(Icons.refresh),
//               label: const Text('Refresh'),
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: const Color(0xFFE33629),
//                 side: const BorderSide(color: Color(0xFFE33629)),
//                 padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildPropertyCard(Map<String, dynamic> house) {
//     final agentPhone = _getAgentPhone(house['user']);
//     final hasStats = house['beds'] != null || house['baths'] != null || house['area'] != null;
//     final hasLocation = house['latitude'] != null && house['longitude'] != null;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.07),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// Property Image (Tappable)
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => NearestHouseDetail(
//                     productId: house['id'],
//                   ),
//                 ),
//               );
//             },
//             child: Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(
//                     top: Radius.circular(16),
//                   ),
//                   child: SizedBox(
//                     height: 180,
//                     width: double.infinity,
//                     child: house['image'].toString().startsWith('http')
//                         ? Image.network(
//                             house['image'],
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 color: Colors.grey.shade300,
//                                 child: const Center(
//                                   child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
//                                 ),
//                               );
//                             },
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return Container(
//                                 color: Colors.grey.shade200,
//                                 child: const Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                               );
//                             },
//                           )
//                         : Container(
//                             color: Colors.grey.shade300,
//                             child: const Center(
//                               child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
//                             ),
//                           ),
//                   ),
//                 ),

//                 // Type Badge
//                 Positioned(
//                   top: 10,
//                   left: 10,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Text(
//                       house['tag'],
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.grey.shade700,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),

//                 // Price Badge (if available)
//                 if (house['price'] != 'Price on Request')
//                   Positioned(
//                     top: 10,
//                     right: 10,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFE33629),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         house['price'],
//                         style: const TextStyle(
//                           fontSize: 11,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           Padding(
//             padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 /// Title (Tappable)
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => NearestHouseDetail(
//                           productId: house['id'],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     house['title'],
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 /// Location
//                 Row(
//                   children: [
//                     Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade500),
//                     const SizedBox(width: 4),
//                     Expanded(
//                       child: Text(
//                         house['location'],
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade500,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),

//                 /// Stats Row - Only show if at least one stat exists
//                 if (hasStats)
//                   Row(
//                     children: [
//                       if (house['beds'] != null)
//                         _StatChip(
//                           imagePath: 'assets/images/bed.png',
//                           label: house['beds'],
//                         ),
//                       if (house['beds'] != null && (house['baths'] != null || house['area'] != null))
//                         const SizedBox(width: 12),

//                       if (house['baths'] != null)
//                         _StatChip(
//                           imagePath: 'assets/images/bath.png',
//                           label: house['baths'],
//                         ),
//                       if (house['baths'] != null && house['area'] != null)
//                         const SizedBox(width: 12),

//                       if (house['area'] != null)
//                         _StatChip(
//                           imagePath: 'assets/images/sqft.png',
//                           label: house['area'],
//                         ),
//                     ],
//                   ),

//                 const SizedBox(height: 12),
//                 Divider(color: Colors.grey.shade200, height: 1),
//                 const SizedBox(height: 12),

//                 /// Action Buttons
//                 Row(
//                   children: [
//                     _CallButton(
//                       onTap: () {
//                         CallUtils.showCallOptions(
//                           context: context,
//                           phoneNumber: agentPhone,
//                           name: house['user']?['name'] ?? "Property Agent",
//                           showMessage: true,
//                           showWhatsApp: true,
//                         );
//                       },
//                     ),
//                     const SizedBox(width: 12),
//                     _ActionButton(
//                       imagePath: 'assets/images/whatsapp.png',
//                       label: "Whatsapp",
//                       onTap: () {
//                         WhatsAppUtils.shareProperty(
//                           context: context,
//                           propertyTitle: house['title'],
//                           propertyLocation: house['location'],
//                           propertyPrice: house['price'],
//                           agentPhone: agentPhone,
//                         );
//                       },
//                     ),
//                     const Spacer(),

//                     /// Location Button - Only show if coordinates exist
//                     if (hasLocation)
//                       _ActionButton(
//                         imagePath: 'assets/images/location.png',
//                         label: "Location",
//                         onTap: () {
//                           LocationUtils.showMapOptions(
//                             context: context,
//                             latitude: house['latitude']!,
//                             longitude: house['longitude']!,
//                             address: house['location'],
//                             locationName: house['title'],
//                           );
//                         },
//                       ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),

//                 /// View Details Button
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => NearestHouseDetail(
//                           productId: house['id'],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey.shade300),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "View Details",
//                         style: TextStyle(
//                           fontSize: 13,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.black87,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Stat Chip ────────────────────────────────────────────────────────────────
// class _StatChip extends StatelessWidget {
//   final String imagePath;
//   final String label;

//   const _StatChip({
//     required this.imagePath,
//     required this.label,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Image.asset(
//           imagePath,
//           width: 14,
//           height: 14,
//           errorBuilder: (_, __, ___) {
//             return Container(
//               width: 14,
//               height: 14,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.circle,
//                 size: 8,
//                 color: Colors.grey.shade500,
//               ),
//             );
//           },
//         ),
//         const SizedBox(width: 4),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 11,
//             color: Colors.grey.shade600,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Call Button ──────────────────────────────────────────────────────────────
// class _CallButton extends StatelessWidget {
//   final VoidCallback onTap;

//   const _CallButton({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
//         decoration: BoxDecoration(
//           color: const Color(0xFFE33629),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: const Text(
//           "Call",
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ── Action Button ────────────────────────────────────────────────────────────
// class _ActionButton extends StatelessWidget {
//   final String imagePath;
//   final String label;
//   final VoidCallback onTap;

//   const _ActionButton({
//     required this.imagePath,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Image.asset(
//             imagePath,
//             width: 16,
//             height: 16,
//             errorBuilder: (_, __, ___) {
//               return Container(
//                 width: 16,
//                 height: 16,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(
//                   Icons.circle,
//                   size: 8,
//                   color: Colors.grey.shade500,
//                 ),
//               );
//             },
//           ),
//           const SizedBox(width: 5),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Colors.black87,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/utils/call_utils.dart';
import 'package:product_app/utils/whatsapp_utils.dart';
import 'package:product_app/utils/location_utils.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearestHouses extends StatefulWidget {
  const NearestHouses({super.key});

  @override
  State<NearestHouses> createState() => _NearestHousesState();
}

class _NearestHousesState extends State<NearestHouses>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> houseList = [];
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;
  bool isLoadingCategories = true;
  String? errorMessage;

  // Selected category for filtering
  String? _selectedCategoryId;
  String? _selectedCategoryName;

  // Default agent phone number
  final String defaultAgentPhone = "919961593179";

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

    fetchCategories();
    fetchNearestProducts();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/api/auth/getall-categories'),
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
      print("Category error: $e");
      setState(() {
        isLoadingCategories = false;
      });
    }
  }

  Future<void> fetchNearestProducts() async {
    final userId = SharedPrefHelper.getUserId();
    if (userId == null) {
      print('User ID not found');
      setState(() {
        isLoading = false;
        errorMessage = 'User ID not found. Please log in again.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Build URL with category filter if selected
      String url = '${ApiConstants.baseUrl}/api/nearest/user/$userId';
      if (_selectedCategoryId != null && _selectedCategoryId!.isNotEmpty) {
        url += '/$_selectedCategoryId';
      }

      print('Fetching from URL: $url');

      final response = await http.get(Uri.parse(url));

      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['products'] != null) {
          setState(() {
            houseList = (data['products'] as List).map((product) {
              return _parseProductData(product);
            }).toList();
            isLoading = false;
          });
        } else {
          setState(() {
            houseList = [];
            isLoading = false;
            errorMessage = 'No properties found nearby.';
          });
        }
      } else {
        throw Exception('Failed to load nearest products');
      }
    } catch (e) {
      print('Error fetching nearest products: $e');
      setState(() {
        houseList = [];
        isLoading = false;
        errorMessage = 'Failed to load properties. Please try again.';
      });
    }
  }

  Map<String, dynamic> _parseProductData(dynamic product) {
    // Parse attributes (could be Map or String)
    Map<String, dynamic> attributes = {};
    if (product['attributes'] is Map) {
      attributes = Map<String, dynamic>.from(product['attributes']);
    } else if (product['attributes'] is String) {
      try {
        attributes = json.decode(product['attributes']);
      } catch (e) {
        attributes = {};
      }
    }

    // Parse contact if available
    Map<String, dynamic> contact = {};
    if (product['contact'] is Map) {
      contact = Map<String, dynamic>.from(product['contact']);
    }

    // Extract values from attributes
    String bed = _extractBedrooms(attributes);
    String bath = _extractBathrooms(attributes);
    String area = _extractArea(attributes);
    String price = _formatPrice(attributes['price']);

    // Extract location coordinates
    double? latitude;
    double? longitude;
    if (product['location'] is Map) {
      final location = product['location'];
      if (location['coordinates'] is List) {
        final coords = location['coordinates'] as List;
        if (coords.length >= 2) {
          longitude = coords[0]?.toDouble();
          latitude = coords[1]?.toDouble();
        }
      }
    }

    // Get user/agent info if available
    Map<String, dynamic>? userData;
    if (product['user'] is Map) {
      userData = Map<String, dynamic>.from(product['user']);
    }

    // Get category info
    Map<String, dynamic>? categoryData;
    if (product['category'] is Map) {
      categoryData = Map<String, dynamic>.from(product['category']);
    }

    return {
      'id': product['_id']?.toString() ?? '',
      'image': (product['images'] != null &&
              product['images'] is List &&
              product['images'].isNotEmpty)
          ? product['images'][0].toString()
          : '',
      'images': product['images'] is List ? List.from(product['images']) : [],
      'tag': categoryData?['name']?.toString() ??
          (product['name']?.toString() ?? 'For Sale'),
      'title': product['name']?.toString() ?? 'Unnamed Property',
      'location': product['address']?.toString() ?? 'Unknown',
      'price': price.isNotEmpty ? price : 'Price on Request',
      'beds': bed.isNotEmpty ? bed : null,
      'baths': bath.isNotEmpty ? bath : null,
      'area': area.isNotEmpty ? area : null,
      'latitude': latitude,
      'longitude': longitude,
      'description': product['description']?.toString() ??
          'Beautiful property located in prime area with modern amenities.',
      'user': userData,
      'category': categoryData,
      'attributes': attributes,
      'contact': contact,
      'isApproved': product['isApproved'] ?? false,
      'isActive': product['isActive'] ?? false,
    };
  }

  String _extractBedrooms(Map<String, dynamic> attributes) {
    if (attributes.containsKey('bedrooms')) {
      final beds = attributes['bedrooms'];
      if (beds is num) return '${beds.toStringAsFixed(0)} Bed';
      if (beds is String) return '$beds Bed';
    } else if (attributes.containsKey('landSize')) {
      final landSize = attributes['landSize'];
      final unit = attributes['unit'] ?? '';
      if (landSize is num) return '${landSize.toStringAsFixed(0)} $unit';
      if (landSize is String) return '$landSize $unit';
    }
    return '';
  }

  String _extractBathrooms(Map<String, dynamic> attributes) {
    if (attributes.containsKey('bathrooms')) {
      final baths = attributes['bathrooms'];
      if (baths is num) return '${baths.toStringAsFixed(0)} Bath';
      if (baths is String) return '$baths Bath';
    }
    return '';
  }

  String _extractArea(Map<String, dynamic> attributes) {
    if (attributes.containsKey('sqft')) {
      final sqft = attributes['sqft'];
      if (sqft is num) return '${sqft.toStringAsFixed(0)} sqft';
      if (sqft is String) return '$sqft sqft';
    } else if (attributes.containsKey('landSize') &&
        attributes['unit'] == 'acres') {
      final landSize = attributes['landSize'];
      if (landSize is num) return '${landSize.toStringAsFixed(1)} acres';
      if (landSize is String) return '$landSize acres';
    }
    return '';
  }

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

  String _getAgentPhone(
      Map<String, dynamic>? userData, Map<String, dynamic>? contact) {
    // Try contact first
    if (contact != null) {
      if (contact.containsKey('callNumber') && contact['callNumber'] != null) {
        return contact['callNumber'].toString().replaceAll('+', '');
      }
      if (contact.containsKey('whatsappNumber') &&
          contact['whatsappNumber'] != null) {
        return contact['whatsappNumber'].toString().replaceAll('+', '');
      }
    }

    // Then try user
    if (userData != null && userData['mobile'] != null) {
      return userData['mobile'].toString().replaceAll('+', '');
    }
    return defaultAgentPhone;
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child:
                const Icon(Icons.arrow_back, size: 18, color: Colors.black87),
          ),
        ),
        title: Text(
          _selectedCategoryName != null
              ? "$_selectedCategoryName"
              : "Nearest Properties",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
        actions: [
          if (_selectedCategoryId != null)
            IconButton(
              icon: const Icon(Icons.clear, color: Colors.grey),
              onPressed: _clearCategoryFilter,
              tooltip: 'Clear filter',
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Categories Horizontal List
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: isLoadingCategories
                  ? _buildCategorySkeletonLoader()
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: _CategoryItem(
                            categoryId: category['id'],
                            label: category['name'],
                            image: category['image'],
                            isSelected: _selectedCategoryId == category['id'],
                            onTap: () => _filterByCategory(
                                category['id'], category['name']),
                          ),
                        );
                      },
                    ),
            ),

            // Properties List
            Expanded(
              child: isLoading
                  ? _buildSkeletonLoader()
                  : errorMessage != null
                      ? _buildErrorState()
                      : houseList.isEmpty
                          ? _buildEmptyState()
                          : RefreshIndicator(
                              onRefresh: fetchNearestProducts,
                              color: const Color(0xFFE33629),
                              child: ListView.builder(
                                padding: const EdgeInsets.all(16),
                                itemCount: houseList.length,
                                itemBuilder: (context, index) {
                                  final house = houseList[index];
                                  return _buildPropertyCard(house);
                                },
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySkeletonLoader() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
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
          ),
        );
      },
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
                    Container(
                      height: 16,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: List.generate(
                          3,
                          (_) => Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Container(
                                  width: 60,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              )),
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

  Widget _buildErrorState() {
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
              errorMessage!,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchNearestProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE33629),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Try Again'),
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
                Icons.home_outlined,
                size: 48,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _selectedCategoryName != null
                  ? "No $_selectedCategoryName Found"
                  : "No Properties Found",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedCategoryName != null
                  ? "We couldn't find any $_selectedCategoryName properties near your location"
                  : "We couldn't find any properties near your location",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (_selectedCategoryName != null)
              OutlinedButton.icon(
                onPressed: _clearCategoryFilter,
                icon: const Icon(Icons.clear),
                label: const Text('Clear Filter'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFE33629),
                  side: const BorderSide(color: Color(0xFFE33629)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              )
            else
              OutlinedButton.icon(
                onPressed: fetchNearestProducts,
                icon: const Icon(Icons.refresh),
                label: const Text('Refresh'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFE33629),
                  side: const BorderSide(color: Color(0xFFE33629)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> house) {
    final agentPhone = _getAgentPhone(house['user'], house['contact']);
    final hasStats = house['beds'] != null ||
        house['baths'] != null ||
        house['area'] != null;
    final hasLocation = house['latitude'] != null && house['longitude'] != null;
    final categoryColor = _getCategoryColor(house['tag']?.toString() ?? '');
    final categoryIcon = _getCategoryIcon(house['tag']?.toString() ?? '');

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
          /// Property Image (Tappable)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NearestHouseDetail(
                    productId: house['id'],
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: house['image'].toString().startsWith('http')
                        ? Image.network(
                            house['image'],
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
                            loadingBuilder: (context, child, loadingProgress) {
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

                // Type Badge
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: categoryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      house['tag'],
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Price Badge (if available)
                if (house['price'] != 'Price on Request')
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        house['price'],
                        style: TextStyle(
                          fontSize: 11,
                          color: categoryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title (Tappable)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NearestHouseDetail(
                          productId: house['id'],
                        ),
                      ),
                    );
                  },
                  child: Text(
                    house['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                /// Location
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 14, color: Colors.grey.shade500),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        house['location'],
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

                const SizedBox(height: 12),

                /// Stats Row
                if (hasStats)
                  Row(
                    children: [
                      if (house['beds'] != null)
                        _StatChip(
                          imagePath: 'assets/images/bed.png',
                          label: house['beds'],
                        ),
                      if (house['beds'] != null &&
                          (house['baths'] != null || house['area'] != null))
                        const SizedBox(width: 12),
                      if (house['baths'] != null)
                        _StatChip(
                          imagePath: 'assets/images/bath.png',
                          label: house['baths'],
                        ),
                      if (house['baths'] != null && house['area'] != null)
                        const SizedBox(width: 12),
                      if (house['area'] != null)
                        _StatChip(
                          imagePath: 'assets/images/sqft.png',
                          label: house['area'],
                        ),
                    ],
                  ),

                const SizedBox(height: 12),
                Divider(color: Colors.grey.shade200, height: 1),
                const SizedBox(height: 12),

                /// Action Buttons
                Row(
                  children: [
                    _CallButton(
                      onTap: () {
                        CallUtils.showCallOptions(
                          context: context,
                          phoneNumber: agentPhone,
                          name: house['user']?['name'] ?? "Property Agent",
                          showMessage: true,
                          showWhatsApp: true,
                        );
                      },
                    ),
                    const SizedBox(width: 12),
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
                    if (hasLocation)
                      _ActionButton(
                        imagePath: 'assets/images/location.png',
                        label: "Location",
                        onTap: () {
                          LocationUtils.showMapOptions(
                            context: context,
                            latitude: house['latitude']!,
                            longitude: house['longitude']!,
                            address: house['location'],
                            locationName: house['title'],
                          );
                        },
                      ),
                  ],
                ),

                const SizedBox(height: 12),

                /// View Details Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NearestHouseDetail(
                          productId: house['id'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
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
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    final cat = category.toLowerCase();

    if (cat.contains('companies') || cat.contains('business')) {
      return Colors.blue;
    } else if (cat.contains('gold') || cat.contains('jewel')) {
      return Colors.amber.shade700;
    } else if (cat.contains('villa') || cat.contains('house')) {
      return const Color(0xFFE33629);
    } else if (cat.contains('apartment') || cat.contains('flat')) {
      return Colors.green;
    } else if (cat.contains('hotel') || cat.contains('restaurant')) {
      return Colors.purple;
    } else if (cat.contains('land') ||
        cat.contains('farm') ||
        cat.contains('plot')) {
      return Colors.orange;
    } else if (cat.contains('shop') || cat.contains('store')) {
      return Colors.teal;
    }

    return const Color(0xFFE33629);
  }

  IconData _getCategoryIcon(String category) {
    final cat = category.toLowerCase();

    if (cat.contains('companies') || cat.contains('business')) {
      return Icons.business;
    } else if (cat.contains('gold') || cat.contains('jewel')) {
      return Icons.diamond;
    } else if (cat.contains('villa') || cat.contains('house')) {
      return Icons.house;
    } else if (cat.contains('apartment') || cat.contains('flat')) {
      return Icons.apartment;
    } else if (cat.contains('hotel') || cat.contains('restaurant')) {
      return Icons.hotel;
    } else if (cat.contains('land') ||
        cat.contains('farm') ||
        cat.contains('plot')) {
      return Icons.landscape;
    } else if (cat.contains('shop') || cat.contains('store')) {
      return Icons.store;
    }

    return Icons.image_not_supported;
  }
}

// ── Category Item Widget ─────────────────────────────────────────────────────
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
                      colors: [Color(0xFFE33629), Color(0xFF9D0D0D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [Color(0xFFE33629), Color(0xFF9D0D0D)],
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
                    color: isSelected
                        ? const Color(0xFFE33629)
                        : Colors.grey.shade600,
                    errorBuilder: (_, __, ___) {
                      return Icon(
                        Icons.category,
                        color: isSelected
                            ? const Color(0xFFE33629)
                            : Colors.grey.shade600,
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
                    color: isSelected ? Colors.white : Colors.white,
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
