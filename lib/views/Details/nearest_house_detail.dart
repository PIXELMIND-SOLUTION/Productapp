
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class NearestHouseDetail extends StatefulWidget {
//   final String productId;

//   const NearestHouseDetail({
//     super.key,
//     required this.productId,
//   });

//   @override
//   State<NearestHouseDetail> createState() => _NearestHouseDetailState();
// }

// class _NearestHouseDetailState extends State<NearestHouseDetail> {
//   bool isLoading = true;
//   String? errorMessage;
//   Map<String, dynamic>? productData;
  
//   bool isFavorite = false;
//   int _currentImageIndex = 0;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _fetchProductDetails();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchProductDetails() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     try {
//       final response = await http.get(
//         Uri.parse('${ApiConstants.baseUrl}/api/${widget.productId}'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
        
//         if (data['success'] == true) {
//           setState(() {
//             productData = Map<String, dynamic>.from(data['product']);
//             isLoading = false;
//           });
//         } else {
//           throw Exception('Failed to load product');
//         }
//       } else {
//         throw Exception('Failed to load product');
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   // Helper methods to safely extract data
//   Map<String, dynamic>? get _userData => 
//       productData?['user'] is Map ? Map<String, dynamic>.from(productData!['user']) : null;

//   Map<String, dynamic>? get _categoryData => 
//       productData?['category'] is Map ? Map<String, dynamic>.from(productData!['category']) : null;

//   Map<String, dynamic>? get _attributes => 
//       productData?['attributes'] is Map ? Map<String, dynamic>.from(productData!['attributes']) : null;

//   Map<String, dynamic>? get _contact => 
//       productData?['contact'] is Map ? Map<String, dynamic>.from(productData!['contact']) : null;

//   List<dynamic> get _images => 
//       productData?['images'] is List ? List.from(productData!['images']) : [];

//   String _getFormattedPrice() {
//     if (_attributes == null) return 'Price on Request';

//     // Check for different price types
//     if (_attributes!.containsKey('pricePerNight')) {
//       final price = _attributes!['pricePerNight'];
//       if (price is num) {
//         return '₹${price.toStringAsFixed(0)}/night';
//       }
//     }
    
//     if (_attributes!.containsKey('price')) {
//       final price = _attributes!['price'];
//       if (price is num) {
//         if (price >= 10000000) {
//           return '₹${(price / 10000000).toStringAsFixed(2)} Cr';
//         } else if (price >= 100000) {
//           return '₹${(price / 100000).toStringAsFixed(2)} Lac';
//         } else if (price >= 1000) {
//           return '₹${(price / 1000).toStringAsFixed(0)}k';
//         } else {
//           return '₹${price.toStringAsFixed(0)}';
//         }
//       }
//       return price.toString();
//     }
    
//     return 'Price on Request';
//   }

//   // Helper method to get the best available phone number
//   String _getAgentPhone() {
//     // Try to get from contact object first
//     if (_contact != null) {
//       if (_contact!.containsKey('callNumber') && _contact!['callNumber'] != null) {
//         return _contact!['callNumber'].toString().replaceAll('+', '');
//       }
//       if (_contact!.containsKey('whatsappNumber') && _contact!['whatsappNumber'] != null) {
//         return _contact!['whatsappNumber'].toString().replaceAll('+', '');
//       }
//     }
    
//     // Then try from user object
//     if (_userData != null) {
//       if (_userData!.containsKey('mobile') && _userData!['mobile'] != null) {
//         return _userData!['mobile'].toString().replaceAll('+', '');
//       }
//     }
    
//     // Default fallback
//     return '919961593179';
//   }

//   // Helper method to get agent name
//   String _getAgentName() {
//     if (_userData != null && _userData!.containsKey('name') && _userData!['name'] != null) {
//       return _userData!['name'].toString();
//     }
//     return "Info";
//   }

//   // Helper method to get agent email
//   String? _getAgentEmail() {
//     if (_contact != null && _contact!.containsKey('email') && _contact!['email'] != null) {
//       return _contact!['email'].toString();
//     }
//     if (_userData != null && _userData!.containsKey('email') && _userData!['email'] != null) {
//       return _userData!['email'].toString();
//     }
//     return null;
//   }

//   // Helper method to get agent website
//   String? _getAgentWebsite() {
//     if (_contact != null && _contact!.containsKey('website') && _contact!['website'] != null) {
//       return _contact!['website'].toString();
//     }
//     return null;
//   }

//   List<Map<String, dynamic>> _getAdditionalFeatures() {
//     List<Map<String, dynamic>> features = [];
    
//     if (_attributes == null) return features;

//     // Define icons for all attribute types
//     final Map<String, IconData> attributeIcons = {
//       // Land/Farm attributes
//       'landSize': Icons.square_foot,
//       'unit': Icons.straighten,
//       'landType': Icons.landscape,
//       'roadFacing': Icons.map,
//       'waterConnection': Icons.water_drop,
//       'electricityAvailable': Icons.electric_bolt,
//       'waterSource': Icons.water,
//       'farmHouseBuilt': Icons.house,
//       'boundaryWall': Icons.stop,
//       'borewell': Icons.water,
//       'crops': Icons.grass,
      
//       // Residential attributes
//       'bedrooms': Icons.bed,
//       'bathrooms': Icons.bathtub,
//       'sqft': Icons.square_foot,
//       'floorNumber': Icons.stairs,
//       'totalFloors': Icons.apartment,
//       'furnishing': Icons.chair,
//       'parking': Icons.local_parking,
//       'maintenance': Icons.money,
//       'balcony': Icons.window,
//       'lift': Icons.elevator,
//       'garden': Icons.grass,
//       'floors': Icons.stairs,
//       'privatePool': Icons.pool,
      
//       // Gated community attributes
//       'clubhouse': Icons.celebration,
//       'gym': Icons.fitness_center,
//       'security': Icons.security,
//       'swimmingPool': Icons.pool,
//       'playArea': Icons.sports_handball,
      
//       // Hotel attributes
//       'totalRooms': Icons.hotel,
//       'roomTypes': Icons.meeting_room,
//       'pricePerNight': Icons.nightlife,
//       'restaurantAvailable': Icons.restaurant,
//       'wifi': Icons.wifi,
//       'spa': Icons.spa,
//       'roomService': Icons.room_service,
//       'breakfastIncluded': Icons.free_breakfast,
//       'checkInTime': Icons.login,
//       'checkOutTime': Icons.logout,
      
//       // Common
//       'price': Icons.currency_rupee,
//       'availableFor': Icons.event_available,
//     };

//     // Define which keys to show in features (skip those shown in stats)
//     final List<String> statsKeys = ['bedrooms', 'bathrooms', 'sqft', 'landSize', 'unit', 'landType', 'totalRooms', 'pricePerNight'];

//     // Iterate through all attributes
//     _attributes!.forEach((key, value) {
//       // Skip null values
//       if (value == null) return;

//       // Handle different types
//       if (key == 'roomTypes' && value is List) {
//         features.add({
//           'icon': attributeIcons[key] ?? Icons.meeting_room,
//           'label': 'Room Types',
//           'value': value.join(', '),
//           'available': true,
//         });
//       }
//       else if (key == 'checkInTime' || key == 'checkOutTime') {
//         features.add({
//           'icon': attributeIcons[key] ?? Icons.access_time,
//           'label': key == 'checkInTime' ? 'Check-in' : 'Check-out',
//           'value': value.toString(),
//           'available': true,
//         });
//       }
//       else if (!statsKeys.contains(key)) {
//         // Format the label
//         String label = _formatAttributeLabel(key);
        
//         // Format the value
//         String displayValue = _formatAttributeValue(key, value);
        
//         // Determine if it's available (for boolean values)
//         bool isAvailable = true;
//         if (value is bool) {
//           isAvailable = value;
//           if (!isAvailable) return; // Skip false booleans
//         }

//         // Get icon or use default
//         IconData icon = attributeIcons[key] ?? Icons.info_outline;

//         features.add({
//           'icon': icon,
//           'label': label,
//           'value': displayValue,
//           'available': isAvailable,
//         });
//       }
//     });

//     return features;
//   }

//   String _formatAttributeLabel(String key) {
//     // Convert camelCase or snake_case to Title Case
//     String label = key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match[1]}');
//     label = label.replaceAll('_', ' ');
//     label = label.split(' ').map((word) => 
//       word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : ''
//     ).join(' ');
    
//     // Special cases
//     if (label.toLowerCase() == 'sqft') return 'Area';
//     if (label.toLowerCase() == 'available for') return 'Availability';
//     if (label.toLowerCase() == 'electricity available') return 'Electricity';
//     if (label.toLowerCase() == 'water connection') return 'Water';
//     if (label.toLowerCase() == 'road facing') return 'Road Access';
//     if (label.toLowerCase() == 'farm house built') return 'Farm House';
//     if (label.toLowerCase() == 'land size') return 'Land Size';
//     if (label.toLowerCase() == 'land type') return 'Land Type';
//     if (label.toLowerCase() == 'total rooms') return 'Total Rooms';
//     if (label.toLowerCase() == 'price per night') return 'Price/Night';
//     if (label.toLowerCase() == 'restaurant available') return 'Restaurant';
//     if (label.toLowerCase() == 'breakfast included') return 'Breakfast';
//     if (label.toLowerCase() == 'check in time') return 'Check-in';
//     if (label.toLowerCase() == 'check out time') return 'Check-out';
//     if (label.toLowerCase() == 'room service') return 'Room Service';
    
//     return label;
//   }

//   String _formatAttributeValue(String key, dynamic value) {
//     if (value is bool) {
//       return value ? 'Yes' : 'No';
//     }
    
//     if (value is num) {
//       // Format numbers nicely
//       if (key.toLowerCase().contains('price')) {
//         return _formatPrice(value);
//       }
//       if (key.toLowerCase().contains('size') || key.toLowerCase().contains('area')) {
//         return value.toStringAsFixed(0);
//       }
//       return value.toString();
//     }
    
//     if (value is List) {
//       return value.join(', ');
//     }
    
//     return value.toString();
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
//     }
//     return price.toString();
//   }

//   Future<void> _openWhatsApp() async {
//     final phoneNumber = _getAgentPhone();
//     final formattedPhone = phoneNumber.toString().replaceAll('+', '');
    
//     final message = Uri.encodeComponent(
//       'Hi, I am interested in the property: ${productData?['name'] ?? 'Property'} '
//       'located at ${productData?['address'] ?? 'Unknown location'}. '
//       'Price: ${_getFormattedPrice()}'
//     );

//     final whatsappUrl = Uri.parse('https://wa.me/$formattedPhone?text=$message');

//     try {
//       if (await canLaunchUrl(whatsappUrl)) {
//         await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar('Could not open WhatsApp');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error: $e');
//       }
//     }
//   }

//   Future<void> _makePhoneCall() async {
//     final phoneNumber = _getAgentPhone();
//     final phoneUrl = Uri.parse('tel:$phoneNumber');

//     try {
//       if (await canLaunchUrl(phoneUrl)) {
//         await launchUrl(phoneUrl);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar('Could not make phone call');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error: $e');
//       }
//     }
//   }

//   Future<void> _sendEmail() async {
//     final email = _getAgentEmail();
//     if (email == null) {
//       _showErrorSnackBar('No email available');
//       return;
//     }

//     final subject = 'Inquiry about ${productData?['name'] ?? 'Property'}';
//     final body = 'Hi, I am interested in the property: ${productData?['name'] ?? 'Property'} '
//         'located at ${productData?['address'] ?? 'Unknown location'}. Price: ${_getFormattedPrice()}';
    
//     final emailUrl = Uri.parse('mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');
    
//     try {
//       if (await canLaunchUrl(emailUrl)) {
//         await launchUrl(emailUrl);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar('Could not open email app');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error: $e');
//       }
//     }
//   }

//   Future<void> _openWebsite() async {
//     final website = _getAgentWebsite();
//     if (website == null) {
//       _showErrorSnackBar('No website available');
//       return;
//     }

//     // Ensure URL has protocol
//     String urlString = website;
//     if (!urlString.startsWith('http://') && !urlString.startsWith('https://')) {
//       urlString = 'https://$urlString';
//     }

//     try {
//       final url = Uri.parse(urlString);
//       if (await canLaunchUrl(url)) {
//         await launchUrl(url, mode: LaunchMode.externalApplication);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar('Could not open website');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error: $e');
//       }
//     }
//   }

//   Future<void> _openMap() async {
//     final location = productData?['location'];
//     double? lat, lng;
    
//     if (location is Map && location.containsKey('coordinates')) {
//       final coords = location['coordinates'] as List;
//       if (coords.length >= 2) {
//         lng = coords[0]?.toDouble();
//         lat = coords[1]?.toDouble();
//       }
//     }

//     if (lat != null && lng != null) {
//       final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
//       if (await canLaunchUrl(url)) {
//         await launchUrl(url);
//       }
//     } else {
//       final query = Uri.encodeComponent(productData?['address'] ?? '');
//       final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
//       if (await canLaunchUrl(url)) {
//         await launchUrl(url);
//       }
//     }
//   }

//   String _generateShareText() {
//     StringBuffer text = StringBuffer();
    
//     text.writeln('🏠 *${productData?['name'] ?? 'Property'}*');
//     if (_categoryData != null) {
//       text.writeln('📋 *Type:* ${_categoryData!['name']}');
//     }
//     text.writeln('');
//     text.writeln('📍 *Location:* ${productData?['address'] ?? 'Unknown'}');
//     text.writeln('💰 *Price:* ${_getFormattedPrice()}');
//     text.writeln('');
    
//     // Add all attributes dynamically
//     if (_attributes != null && _attributes!.isNotEmpty) {
//       text.writeln('📋 *Property Details:*');
      
//       _attributes!.forEach((key, value) {
//         // Skip null values
//         if (value == null) return;
        
//         // Format the key
//         String label = _formatAttributeLabel(key);
        
//         // Format the value
//         String displayValue;
//         if (value is bool) {
//           displayValue = value ? 'Yes' : 'No';
//         } else if (value is List) {
//           displayValue = value.join(', ');
//         } else if (value is num && (key.toLowerCase().contains('price') || key == 'pricePerNight')) {
//           if (key == 'pricePerNight') {
//             displayValue = '₹${value.toStringAsFixed(0)}/night';
//           } else {
//             displayValue = _formatPrice(value);
//           }
//         } else {
//           displayValue = value.toString();
//         }
        
//         // Add emoji based on key
//         String emoji = _getEmojiForKey(key);
//         text.writeln('$emoji *$label:* $displayValue');
//       });
      
//       text.writeln('');
//     }
    
//     text.writeln('📝 *Description:*');
//     text.writeln(productData?['description'] ?? 'Beautiful property located in prime area.');
//     text.writeln('');
//     text.writeln('📞 *Contact Details:*');
    
//     final agentName = _getAgentName();
//     final agentPhone = _getAgentPhone();
//     final agentEmail = _getAgentEmail();
//     final agentWebsite = _getAgentWebsite();
    
//     text.writeln('👤 Agent: $agentName');
//     text.writeln('📱 Phone: $agentPhone');
//     if (agentEmail != null) text.writeln('📧 Email: $agentEmail');
//     if (agentWebsite != null) text.writeln('🌐 Website: $agentWebsite');
//     text.writeln('💬 WhatsApp: Available');
//     text.writeln('');
//     text.writeln('Download our app to view more properties!');
    
//     return text.toString();
//   }

//   String _getEmojiForKey(String key) {
//     final Map<String, String> keyEmojis = {
//       // Residential
//       'bedrooms': '🛏️',
//       'bathrooms': '🚿',
//       'sqft': '📐',
//       'area': '📐',
//       'floorNumber': '🔢',
//       'totalFloors': '🏢',
//       'furnishing': '🪑',
//       'parking': '🅿️',
//       'maintenance': '💰',
//       'balcony': '🪟',
//       'lift': '🛗',
//       'garden': '🌳',
//       'floors': '🏠',
//       'privatePool': '🏊',
      
//       // Land/Farm
//       'landSize': '🌲',
//       'unit': '📏',
//       'landType': '🏞️',
//       'roadFacing': '🛣️',
//       'waterConnection': '💧',
//       'waterSource': '💧',
//       'electricityAvailable': '⚡',
//       'farmHouseBuilt': '🏡',
//       'boundaryWall': '🧱',
//       'borewell': '🪣',
//       'crops': '🌾',
      
//       // Gated Community
//       'clubhouse': '🏘️',
//       'gym': '🏋️',
//       'security': '🛡️',
//       'swimmingPool': '🏊',
//       'playArea': '🎪',
      
//       // Hotel
//       'totalRooms': '🏨',
//       'roomTypes': '🚪',
//       'pricePerNight': '🌙',
//       'restaurantAvailable': '🍽️',
//       'wifi': '📶',
//       'spa': '💆',
//       'roomService': '🛎️',
//       'breakfastIncluded': '🍳',
//       'checkInTime': '⏰',
//       'checkOutTime': '⏱️',
      
//       // Common
//       'price': '💰',
//       'availableFor': '📅',
//       'availability': '📅',
//       'ownership': '📄',
//     };
    
//     return keyEmojis[key] ?? '•';
//   }

//   void _shareProperty() async {
//     try {
//       String shareText = _generateShareText();
//       await Share.share(
//         shareText,
//         subject: 'Check out this property: ${productData?['name']}',
//       );
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error sharing: $e');
//       }
//     }
//   }

//   void _showContactOptions() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         final agentEmail = _getAgentEmail();
//         final agentWebsite = _getAgentWebsite();
        
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.phone, color: Colors.green, size: 24),
//                 ),
//                 title: const Text('Call'),
//                 subtitle: Text(_getAgentPhone()),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _makePhoneCall();
//                 },
//               ),
//               ListTile(
//                 leading: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Image.asset(
//                     'assets/images/whatsapp.png',
//                     width: 24,
//                     height: 24,
//                     errorBuilder: (_, __, ___) {
//                       return const Icon(Icons.chat, color: Colors.green, size: 24);
//                     },
//                   ),
//                 ),
//                 title: const Text('WhatsApp'),
//                 subtitle: Text(_getAgentPhone()),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _openWhatsApp();
//                 },
//               ),
//               if (agentEmail != null)
//                 ListTile(
//                   leading: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.red.shade50,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.email, color: Colors.red, size: 24),
//                   ),
//                   title: const Text('Email'),
//                   subtitle: Text(agentEmail),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _sendEmail();
//                   },
//                 ),
//               if (agentWebsite != null)
//                 ListTile(
//                   leading: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade50,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.language, color: Colors.blue, size: 24),
//                   ),
//                   title: const Text('Website'),
//                   subtitle: Text(agentWebsite),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _openWebsite();
//                   },
//                 ),
//               ListTile(
//                 leading: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.share, color: Colors.blue, size: 24),
//                 ),
//                 title: const Text('Share'),
//                 subtitle: const Text('Share property details'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _shareProperty();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.error_outline, color: Colors.white, size: 20),
//             const SizedBox(width: 8),
//             Expanded(child: Text(message)),
//           ],
//         ),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const CircularProgressIndicator(),
//               const SizedBox(height: 16),
//               Text(
//                 'Loading property details...',
//                 style: TextStyle(color: Colors.grey.shade600),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     if (errorMessage != null) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Failed to load property',
//                   style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   errorMessage!,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey.shade600),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _fetchProductDetails,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFE33629),
//                     foregroundColor: Colors.white,
//                   ),
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//     final additionalFeatures = _getAdditionalFeatures();
//     final String categoryName = _categoryData?['name']?.toString().toLowerCase() ?? '';
//     final agentName = _getAgentName();
//     final agentPhone = _getAgentPhone();
//     final agentEmail = _getAgentEmail();
//     final agentWebsite = _getAgentWebsite();
    
//     // Determine property type for stats
//     final bool isLandOrFarm = categoryName == 'land' || categoryName == 'farm';
//     final bool isHotel = categoryName == 'hotel';

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: _PropertyImageHeader(
//                   images: _images,
//                   title: productData?['name'],
//                   categoryName: _categoryData?['name'],
//                   isFavorite: isFavorite,
//                   currentIndex: _currentImageIndex,
//                   onPageChanged: (index) {
//                     setState(() {
//                       _currentImageIndex = index;
//                     });
//                   },
//                   onFavoriteTap: () {
//                     setState(() {
//                       isFavorite = !isFavorite;
//                     });
//                   },
//                   onShareTap: _showContactOptions,
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title and Price
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               productData?['name'] ?? 'Property',
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFE33629).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               _getFormattedPrice(),
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w700,
//                                 color: Color(0xFFE33629),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 12),

//                       // Location with Agent Info
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           children: [
//                             // Location
//                             Row(
//                               children: [
//                                 Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade600),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     productData?['address'] ?? 'Unknown location',
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       color: Colors.grey.shade700,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
                            
//                             // Agent Info - Enhanced with contact details
//                             const SizedBox(height: 8),
//                             const Divider(height: 1),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundImage: _userData != null && _userData!['profileImage'] != null
//                                       ? NetworkImage(_userData!['profileImage'])
//                                       : null,
//                                   child: _userData == null || _userData!['profileImage'] == null
//                                       ? const Icon(Icons.person, size: 20)
//                                       : null,
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         agentName,
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Row(
//                                         children: [
//                                           const Icon(Icons.phone, size: 12, color: Colors.grey),
//                                           const SizedBox(width: 4),
//                                           Text(
//                                             agentPhone,
//                                             style: TextStyle(
//                                               fontSize: 11,
//                                               color: Colors.grey.shade600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       if (agentEmail != null) ...[
//                                         const SizedBox(height: 2),
//                                         Row(
//                                           children: [
//                                             const Icon(Icons.email, size: 12, color: Colors.grey),
//                                             const SizedBox(width: 4),
//                                             Expanded(
//                                               child: Text(
//                                                 agentEmail,
//                                                 style: TextStyle(
//                                                   fontSize: 11,
//                                                   color: Colors.grey.shade600,
//                                                 ),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: Colors.green.shade50,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Text(
//                                     'Verified',
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       color: Colors.green.shade700,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
                            
//                             // Website link if available
//                             if (agentWebsite != null) ...[
//                               const SizedBox(height: 8),
//                               GestureDetector(
//                                 onTap: _openWebsite,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue.shade50,
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       const Icon(Icons.language, size: 14, color: Colors.blue),
//                                       const SizedBox(width: 6),
//                                       Expanded(
//                                         child: Text(
//                                           agentWebsite,
//                                           style: const TextStyle(
//                                             fontSize: 11,
//                                             color: Colors.blue,
//                                             decoration: TextDecoration.underline,
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // Stats Container - Conditionally show based on property type
//                       if (_attributes != null)
//                         isHotel
//                             ? _buildHotelStats()
//                             : isLandOrFarm
//                                 ? _buildLandStats()
//                                 : _buildResidentialStats(),

//                       const SizedBox(height: 20),

//                       // Description
//                       const _SectionTitle("Description"),
//                       const SizedBox(height: 8),
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           productData?['description'] ??
//                               'Beautiful property located in prime area with modern amenities.',
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey.shade700,
//                             height: 1.5,
//                           ),
//                         ),
//                       ),

//                       // Additional Features
//                       if (additionalFeatures.isNotEmpty) ...[
//                         const SizedBox(height: 20),
//                         const _SectionTitle("Features"),
//                         const SizedBox(height: 12),
//                         Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: additionalFeatures.map((feature) {
//                             return Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                               decoration: BoxDecoration(
//                                 color: feature['available'] 
//                                     ? Colors.green.shade50 
//                                     : Colors.grey.shade100,
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: feature['available'] 
//                                       ? Colors.green.shade200 
//                                       : Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     feature['icon'],
//                                     size: 14,
//                                     color: feature['available'] 
//                                         ? Colors.green.shade700 
//                                         : Colors.grey.shade500,
//                                   ),
//                                   const SizedBox(width: 6),
//                                   Text(
//                                     feature['label'],
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       color: feature['available'] 
//                                           ? Colors.green.shade700 
//                                           : Colors.grey.shade600,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   if (feature['value'] != null && feature['value'].toString().isNotEmpty) ...[
//                                     const SizedBox(width: 4),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: feature['available'] 
//                                             ? Colors.green.shade100 
//                                             : Colors.grey.shade200,
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Text(
//                                         feature['value'],
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           color: feature['available'] 
//                                               ? Colors.green.shade800 
//                                               : Colors.grey.shade700,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],

//                       const SizedBox(height: 20),

//                       // Map Section
//                       const _SectionTitle("Location on Map"),
//                       const SizedBox(height: 10),

//                       GestureDetector(
//                         onTap: _openMap,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(14),
//                           child: Container(
//                             height: 160,
//                             width: double.infinity,
//                             color: Colors.grey.shade200,
//                             child: Stack(
//                               children: [
//                                 Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.map, size: 40, color: Colors.grey.shade400),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         'Tap to open map',
//                                         style: TextStyle(color: Colors.grey.shade600),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 12,
//                                   left: 12,
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(20),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.1),
//                                           blurRadius: 4,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         const Icon(Icons.location_on, size: 14, color: Color(0xFFE33629)),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           productData?['address']?.toString().split(',').first ?? 'View on Map',
//                                           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: _BottomActionBar(
//               onContactTap: _showContactOptions,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHotelStats() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           // Total Rooms
//           if (_attributes!.containsKey('totalRooms'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.hotel,
//                 label: 'Total Rooms',
//                 value: _attributes!['totalRooms'].toString(),
//               ),
//             ),
          
//           if (_attributes!.containsKey('totalRooms') && _attributes!.containsKey('pricePerNight'))
//             Container(width: 1, height: 30, color: Colors.grey.shade300),
          
//           // Price Per Night
//           if (_attributes!.containsKey('pricePerNight'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.nightlife,
//                 label: 'Per Night',
//                 value: '₹${_attributes!['pricePerNight']}',
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLandStats() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           // Land Size
//           if (_attributes!.containsKey('landSize'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.square_foot,
//                 label: 'Land Size',
//                 value: '${_attributes!['landSize']} ${_attributes!['unit'] ?? ''}',
//               ),
//             ),
          
//           if (_attributes!.containsKey('landSize') && _attributes!.containsKey('landType'))
//             Container(width: 1, height: 30, color: Colors.grey.shade300),
          
//           // Land Type
//           if (_attributes!.containsKey('landType'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.landscape,
//                 label: 'Land Type',
//                 value: _attributes!['landType'],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildResidentialStats() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           // Bedrooms
//           if (_attributes!.containsKey('bedrooms'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.bed_outlined,
//                 label: 'Bedrooms',
//                 value: '${_attributes!['bedrooms']} Bed',
//               ),
//             ),
          
//           if (_attributes!.containsKey('bedrooms') && _attributes!.containsKey('bathrooms'))
//             Container(width: 1, height: 30, color: Colors.grey.shade300),
          
//           // Bathrooms
//           if (_attributes!.containsKey('bathrooms'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.bathtub_outlined,
//                 label: 'Bathrooms',
//                 value: '${_attributes!['bathrooms']} Bath',
//               ),
//             ),
          
//           if (_attributes!.containsKey('bathrooms') && _attributes!.containsKey('sqft'))
//             Container(width: 1, height: 30, color: Colors.grey.shade300),
          
//           // Area
//           if (_attributes!.containsKey('sqft'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.square_foot,
//                 label: 'Area',
//                 value: '${_attributes!['sqft']} sqft',
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // ── Property Image Header with Gallery ─────────────────────────────────────
// class _PropertyImageHeader extends StatelessWidget {
//   final List<dynamic> images;
//   final String? title;
//   final String? categoryName;
//   final bool isFavorite;
//   final int currentIndex;
//   final Function(int) onPageChanged;
//   final VoidCallback onFavoriteTap;
//   final VoidCallback onShareTap;

//   const _PropertyImageHeader({
//     required this.images,
//     required this.title,
//     required this.categoryName,
//     required this.isFavorite,
//     required this.currentIndex,
//     required this.onPageChanged,
//     required this.onFavoriteTap,
//     required this.onShareTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hasImages = images.isNotEmpty;

//     return Stack(
//       children: [
//         // Image Gallery
//         SizedBox(
//           height: 375,
//           width: double.infinity,
//           child: Stack(
//             children: [
//               PageView.builder(
//                 onPageChanged: onPageChanged,
//                 itemCount: hasImages ? images.length : 1,
//                 itemBuilder: (context, index) {
//                   final imageUrl = hasImages ? images[index].toString() : null;
                  
//                   return ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       bottom: Radius.circular(30),
//                     ),
//                     child: imageUrl != null && imageUrl.startsWith('http')
//                         ? Image.network(
//                             imageUrl,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return _buildPlaceholder();
//                             },
//                           )
//                         : _buildPlaceholder(),
//                   );
//                 },
//               ),

//               // Image Counter
//               if (hasImages && images.length > 1)
//                 Positioned(
//                   bottom: 16,
//                   right: 16,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       '${currentIndex + 1}/${images.length}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),

//               // Category Badge
//               if (categoryName != null)
//                 Positioned(
//                   top: 44,
//                   left: 14,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       categoryName!,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),

//         // Back Button
//         Positioned(
//           top: 44,
//           left: 14,
//           child: _CircleIconButton(
//             icon: Icons.arrow_back,
//             onTap: () => Navigator.pop(context),
//           ),
//         ),

//         // Action Icons
//         Positioned(
//           top: 44,
//           right: 14,
//           child: Column(
//             children: [
//               _CircleIconButton(
//                 icon: isFavorite ? Icons.favorite : Icons.favorite_border,
//                 onTap: onFavoriteTap,
//               ),
//               const SizedBox(height: 12),
//               _CircleIconButton(
//                 icon: Icons.share,
//                 onTap: onShareTap,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPlaceholder() {
//     return Container(
//       color: Colors.grey.shade300,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.image_not_supported, size: 50, color: Colors.grey.shade500),
//             const SizedBox(height: 8),
//             Text(
//               'No Image',
//               style: TextStyle(color: Colors.grey.shade600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ── Circle Icon Button ───────────────────────────────────────────────────
// class _CircleIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const _CircleIconButton({
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 36,
//         height: 36,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(icon, size: 18, color: Colors.black87),
//       ),
//     );
//   }
// }

// // ── Section Title ────────────────────────────────────────────────────────
// class _SectionTitle extends StatelessWidget {
//   final String title;

//   const _SectionTitle(this.title);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w700,
//         color: Colors.black87,
//       ),
//     );
//   }
// }

// // ── Stat Item ────────────────────────────────────────────────────────────
// class _StatItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;

//   const _StatItem({
//     required this.icon,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, size: 18, color: const Color(0xFFE33629)),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w700,
//             color: Colors.black87,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 10,
//             color: Colors.grey.shade600,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Bottom Action Bar ─────────────────────────────────────────────────────
// class _BottomActionBar extends StatelessWidget {
//   final VoidCallback onContactTap;

//   const _BottomActionBar({
//     required this.onContactTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.07),
//             blurRadius: 12,
//             offset: const Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Map Button
//           Expanded(
//             child: GestureDetector(
//               onTap: () {}, // Map functionality is elsewhere
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.map_outlined, size: 18, color: Colors.grey.shade700),
//                     const SizedBox(width: 6),
//                     const Text(
//                       "Map",
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),

//           // Contact Button
//           Expanded(
//             flex: 2,
//             child: GestureDetector(
//               onTap: onContactTap,
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE33629),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.contact_phone, color: Colors.white, size: 18),
//                     SizedBox(width: 8),
//                     Text(
//                       "Contact Agent",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
























// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class NearestHouseDetail extends StatefulWidget {
//   final String productId;

//   const NearestHouseDetail({
//     super.key,
//     required this.productId,
//   });

//   @override
//   State<NearestHouseDetail> createState() => _NearestHouseDetailState();
// }

// class _NearestHouseDetailState extends State<NearestHouseDetail> {
//   bool isLoading = true;
//   String? errorMessage;
//   Map<String, dynamic>? productData;
  
//   bool isFavorite = false;
//   int _currentImageIndex = 0;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//     _fetchProductDetails();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchProductDetails() async {
//     setState(() {
//       isLoading = true;
//       errorMessage = null;
//     });

//     try {
//       final response = await http.get(
//         Uri.parse('${ApiConstants.baseUrl}/api/${widget.productId}'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
        
//         if (data['success'] == true) {
//           setState(() {
//             productData = Map<String, dynamic>.from(data['product']);
//             isLoading = false;
//           });
//         } else {
//           throw Exception('Failed to load product');
//         }
//       } else {
//         throw Exception('Failed to load product');
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//         isLoading = false;
//       });
//     }
//   }

//   // Helper methods to safely extract data
//   Map<String, dynamic>? get _userData => 
//       productData?['user'] is Map ? Map<String, dynamic>.from(productData!['user']) : null;

//   Map<String, dynamic>? get _categoryData => 
//       productData?['category'] is Map ? Map<String, dynamic>.from(productData!['category']) : null;

//   Map<String, dynamic>? get _attributes => 
//       productData?['attributes'] is Map ? Map<String, dynamic>.from(productData!['attributes']) : null;

//   Map<String, dynamic>? get _contact => 
//       productData?['contact'] is Map ? Map<String, dynamic>.from(productData!['contact']) : null;

//   List<dynamic> get _images => 
//       productData?['images'] is List ? List.from(productData!['images']) : [];

//   // ===== NEW: Get portfolio items =====
//   List<dynamic> get _portfolio => 
//       productData?['portfolio'] is List ? List.from(productData!['portfolio']) : [];

//   // ===== NEW: Get previous events =====
//   List<dynamic> get _previousEvents => 
//       productData?['previousEvents'] is List ? List.from(productData!['previousEvents']) : [];

//   String _getFormattedPrice() {
//     final categoryName = _categoryData?['name']?.toString().toLowerCase() ?? '';
    
//     // For companies and gold shops - DON'T show price
//     if (categoryName == 'companies' || categoryName == 'gold shops') {
//       return ''; // Return empty string - price won't be shown
//     }

//     if (_attributes == null) return 'Price on Request';

//     // Check for different price types
//     if (_attributes!.containsKey('pricePerNight')) {
//       final price = _attributes!['pricePerNight'];
//       if (price is num) {
//         return '₹${price.toStringAsFixed(0)}/night';
//       }
//     }
    
//     if (_attributes!.containsKey('price')) {
//       final price = _attributes!['price'];
//       if (price is num) {
//         if (price >= 10000000) {
//           return '₹${(price / 10000000).toStringAsFixed(2)} Cr';
//         } else if (price >= 100000) {
//           return '₹${(price / 100000).toStringAsFixed(2)} Lac';
//         } else if (price >= 1000) {
//           return '₹${(price / 1000).toStringAsFixed(0)}k';
//         } else {
//           return '₹${price.toStringAsFixed(0)}';
//         }
//       }
//       return price.toString();
//     }
    
//     return 'Price on Request';
//   }

//   // Helper method to get the best available phone number
//   String _getAgentPhone() {
//     // Try to get from contact object first
//     if (_contact != null) {
//       if (_contact!.containsKey('callNumber') && _contact!['callNumber'] != null) {
//         return _contact!['callNumber'].toString().replaceAll('+', '');
//       }
//       if (_contact!.containsKey('whatsappNumber') && _contact!['whatsappNumber'] != null) {
//         return _contact!['whatsappNumber'].toString().replaceAll('+', '');
//       }
//     }
    
//     // Then try from user object
//     if (_userData != null) {
//       if (_userData!.containsKey('mobile') && _userData!['mobile'] != null) {
//         return _userData!['mobile'].toString().replaceAll('+', '');
//       }
//     }
    
//     // Default fallback
//     return '919961593179';
//   }

//   // Helper method to get agent name
//   String _getAgentName() {
//     if (_userData != null && _userData!.containsKey('name') && _userData!['name'] != null) {
//       return _userData!['name'].toString();
//     }
//     return "Info";
//   }

//   // Helper method to get agent email
//   String? _getAgentEmail() {
//     if (_contact != null && _contact!.containsKey('email') && _contact!['email'] != null) {
//       return _contact!['email'].toString();
//     }
//     if (_userData != null && _userData!.containsKey('email') && _userData!['email'] != null) {
//       return _userData!['email'].toString();
//     }
//     return null;
//   }

//   // Helper method to get agent website
//   String? _getAgentWebsite() {
//     if (_contact != null && _contact!.containsKey('website') && _contact!['website'] != null) {
//       return _contact!['website'].toString();
//     }
//     return null;
//   }

//   // ===== NEW: Get working hours for company/gold shop =====
//   String? _getWorkingHours() {
//     if (_attributes != null && _attributes!.containsKey('workingHours')) {
//       return _attributes!['workingHours'].toString();
//     }
//     return null;
//   }

//   // ===== NEW: Get working days for company/gold shop =====
//   String? _getWorkingDays() {
//     if (_attributes != null && _attributes!.containsKey('workingDays')) {
//       return _attributes!['workingDays'].toString();
//     }
//     return null;
//   }

//   // ===== NEW: Get opening hours for gold shop =====
//   String? _getOpeningHours() {
//     if (_attributes != null && _attributes!.containsKey('openingHours')) {
//       return _attributes!['openingHours'].toString();
//     }
//     return _getWorkingHours(); // Fallback to workingHours
//   }

//   List<Map<String, dynamic>> _getAdditionalFeatures() {
//     List<Map<String, dynamic>> features = [];
//     final categoryName = _categoryData?['name']?.toString().toLowerCase() ?? '';
    
//     if (_attributes == null) return features;

//     // Define icons for all attribute types
//     final Map<String, IconData> attributeIcons = {
//       // Land/Farm attributes
//       'landSize': Icons.square_foot,
//       'unit': Icons.straighten,
//       'landType': Icons.landscape,
//       'roadFacing': Icons.map,
//       'waterConnection': Icons.water_drop,
//       'electricityAvailable': Icons.electric_bolt,
//       'waterSource': Icons.water,
//       'farmHouseBuilt': Icons.house,
//       'boundaryWall': Icons.stop,
//       'borewell': Icons.water,
//       'crops': Icons.grass,
      
//       // Residential attributes
//       'bedrooms': Icons.bed,
//       'bathrooms': Icons.bathtub,
//       'sqft': Icons.square_foot,
//       'floorNumber': Icons.stairs,
//       'totalFloors': Icons.apartment,
//       'furnishing': Icons.chair,
//       'parking': Icons.local_parking,
//       'maintenance': Icons.money,
//       'balcony': Icons.window,
//       'lift': Icons.elevator,
//       'garden': Icons.grass,
//       'floors': Icons.stairs,
//       'privatePool': Icons.pool,
      
//       // Gated community attributes
//       'clubhouse': Icons.celebration,
//       'gym': Icons.fitness_center,
//       'security': Icons.security,
//       'swimmingPool': Icons.pool,
//       'playArea': Icons.sports_handball,
      
//       // Hotel attributes
//       'totalRooms': Icons.hotel,
//       'roomTypes': Icons.meeting_room,
//       'pricePerNight': Icons.nightlife,
//       'restaurantAvailable': Icons.restaurant,
//       'wifi': Icons.wifi,
//       'spa': Icons.spa,
//       'roomService': Icons.room_service,
//       'breakfastIncluded': Icons.free_breakfast,
//       'checkInTime': Icons.login,
//       'checkOutTime': Icons.logout,
      
//       // Company attributes
//       'businessType': Icons.business,
//       'industry': Icons.category,
//       'foundedYear': Icons.calendar_today,
//       'services': Icons.build,
//       'technologies': Icons.computer,
//       'clients': Icons.people,
//       'officeSpace': Icons.business_center,
//       'meetingRooms': Icons.meeting_room,
//       'remoteWork': Icons.home_work,
//       'hiring': Icons.work,
      
//       // Gold shop attributes
//       'shopName': Icons.store,
//       'establishedYear': Icons.calendar_today,
//       'certified': Icons.verified,
//       'hallmarkAvailable': Icons.star,
//       'exchangeAvailable': Icons.swap_horiz,
//       'customDesign': Icons.design_services,
//       'repairsService': Icons.build,
//       'goldRate': Icons.monetization_on,
//       'silverRate': Icons.monetization_on,
//       'makingCharge': Icons.receipt,
//       'schemesAvailable': Icons.card_giftcard,
      
//       // Common
//       'price': Icons.currency_rupee,
//       'availableFor': Icons.event_available,
//       'workingHours': Icons.access_time,
//       'workingDays': Icons.date_range,
//       'openingHours': Icons.access_time,
//     };

//     // Define which keys to show in features (skip those shown in stats)
//     final List<String> statsKeys = ['bedrooms', 'bathrooms', 'sqft', 'landSize', 'unit', 'landType', 'totalRooms', 'pricePerNight'];
    
//     // For companies, don't show working hours/days in features (they're shown in top bar)
//     final List<String> topBarKeys = ['workingHours', 'workingDays', 'openingHours'];

//     // Iterate through all attributes
//     _attributes!.forEach((key, value) {
//       // Skip null values
//       if (value == null) return;

//       // Skip top bar keys for companies and gold shops
//       if ((categoryName == 'companies' || categoryName == 'gold shops') && topBarKeys.contains(key)) {
//         return;
//       }

//       // Handle different types
//       if (key == 'roomTypes' && value is List) {
//         features.add({
//           'icon': attributeIcons[key] ?? Icons.meeting_room,
//           'label': 'Room Types',
//           'value': value.join(', '),
//           'available': true,
//         });
//       }
//       else if (key == 'checkInTime' || key == 'checkOutTime') {
//         features.add({
//           'icon': attributeIcons[key] ?? Icons.access_time,
//           'label': key == 'checkInTime' ? 'Check-in' : 'Check-out',
//           'value': value.toString(),
//           'available': true,
//         });
//       }
//       else if (!statsKeys.contains(key)) {
//         // Format the label
//         String label = _formatAttributeLabel(key);
        
//         // Format the value
//         String displayValue = _formatAttributeValue(key, value);
        
//         // Determine if it's available (for boolean values)
//         bool isAvailable = true;
//         if (value is bool) {
//           isAvailable = value;
//           if (!isAvailable) return; // Skip false booleans
//         }

//         // Get icon or use default
//         IconData icon = attributeIcons[key] ?? Icons.info_outline;

//         features.add({
//           'icon': icon,
//           'label': label,
//           'value': displayValue,
//           'available': isAvailable,
//         });
//       }
//     });

//     return features;
//   }

//   String _formatAttributeLabel(String key) {
//     // Convert camelCase or snake_case to Title Case
//     String label = key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match[1]}');
//     label = label.replaceAll('_', ' ');
//     label = label.split(' ').map((word) => 
//       word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : ''
//     ).join(' ');
    
//     // Special cases
//     if (label.toLowerCase() == 'sqft') return 'Area';
//     if (label.toLowerCase() == 'available for') return 'Availability';
//     if (label.toLowerCase() == 'electricity available') return 'Electricity';
//     if (label.toLowerCase() == 'water connection') return 'Water';
//     if (label.toLowerCase() == 'road facing') return 'Road Access';
//     if (label.toLowerCase() == 'farm house built') return 'Farm House';
//     if (label.toLowerCase() == 'land size') return 'Land Size';
//     if (label.toLowerCase() == 'land type') return 'Land Type';
//     if (label.toLowerCase() == 'total rooms') return 'Total Rooms';
//     if (label.toLowerCase() == 'price per night') return 'Price/Night';
//     if (label.toLowerCase() == 'restaurant available') return 'Restaurant';
//     if (label.toLowerCase() == 'breakfast included') return 'Breakfast';
//     if (label.toLowerCase() == 'check in time') return 'Check-in';
//     if (label.toLowerCase() == 'check out time') return 'Check-out';
//     if (label.toLowerCase() == 'room service') return 'Room Service';
//     if (label.toLowerCase() == 'business type') return 'Business Type';
//     if (label.toLowerCase() == 'founded year') return 'Founded';
//     if (label.toLowerCase() == 'office space') return 'Office Space';
//     if (label.toLowerCase() == 'meeting rooms') return 'Meeting Rooms';
//     if (label.toLowerCase() == 'remote work') return 'Remote Work';
//     if (label.toLowerCase() == 'working hours') return 'Working Hours';
//     if (label.toLowerCase() == 'working days') return 'Working Days';
//     if (label.toLowerCase() == 'opening hours') return 'Opening Hours';
//     if (label.toLowerCase() == 'established year') return 'Established';
//     if (label.toLowerCase() == 'hallmark available') return 'Hallmark';
//     if (label.toLowerCase() == 'exchange available') return 'Exchange';
//     if (label.toLowerCase() == 'custom design') return 'Custom Design';
//     if (label.toLowerCase() == 'repairs service') return 'Repairs';
//     if (label.toLowerCase() == 'gold rate') return 'Gold Rate';
//     if (label.toLowerCase() == 'silver rate') return 'Silver Rate';
//     if (label.toLowerCase() == 'making charge') return 'Making Charge';
//     if (label.toLowerCase() == 'schemes available') return 'Schemes';
    
//     return label;
//   }

//   String _formatAttributeValue(String key, dynamic value) {
//     if (value is bool) {
//       return value ? 'Yes' : 'No';
//     }
    
//     if (value is num) {
//       // Format numbers nicely
//       if (key.toLowerCase().contains('price') || key == 'goldRate' || key == 'silverRate' || key == 'makingCharge') {
//         return _formatPrice(value);
//       }
//       if (key.toLowerCase().contains('size') || key.toLowerCase().contains('area') || key == 'officeSpace') {
//         return value.toStringAsFixed(0);
//       }
//       if (key == 'foundedYear' || key == 'establishedYear') {
//         return value.toStringAsFixed(0);
//       }
//       return value.toString();
//     }
    
//     if (value is List) {
//       return value.join(', ');
//     }
    
//     return value.toString();
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
//     }
//     return price.toString();
//   }

//   Future<void> _openWhatsApp() async {
//     final phoneNumber = _getAgentPhone();
//     final formattedPhone = phoneNumber.toString().replaceAll('+', '');
    
//     final message = Uri.encodeComponent(
//       'Hi, I am interested in the property: ${productData?['name'] ?? 'Property'} '
//       'located at ${productData?['address'] ?? 'Unknown location'}. '
//       'Price: ${_getFormattedPrice()}'
//     );

//     final whatsappUrl = Uri.parse('https://wa.me/$formattedPhone?text=$message');

//     try {
//       if (await canLaunchUrl(whatsappUrl)) {
//         await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar('Could not open WhatsApp');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error: $e');
//       }
//     }
//   }

//   Future<void> _makePhoneCall() async {
//     final phoneNumber = _getAgentPhone();
//     final phoneUrl = Uri.parse('tel:$phoneNumber');

//     try {
//       if (await canLaunchUrl(phoneUrl)) {
//         await launchUrl(phoneUrl);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar('Could not make phone call');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error: $e');
//       }
//     }
//   }

//   Future<void> _sendEmail() async {
//     final email = _getAgentEmail();
//     if (email == null) {
//       _showErrorSnackBar('No email available');
//       return;
//     }

//     final subject = 'Inquiry about ${productData?['name'] ?? 'Property'}';
//     final body = 'Hi, I am interested in the property: ${productData?['name'] ?? 'Property'} '
//         'located at ${productData?['address'] ?? 'Unknown location'}. Price: ${_getFormattedPrice()}';
    
//     final emailUrl = Uri.parse('mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');
    
//     try {
//       if (await canLaunchUrl(emailUrl)) {
//         await launchUrl(emailUrl);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar('Could not open email app');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error: $e');
//       }
//     }
//   }

//   Future<void> _openWebsite() async {
//     final website = _getAgentWebsite();
//     if (website == null) {
//       _showErrorSnackBar('No website available');
//       return;
//     }

//     // Ensure URL has protocol
//     String urlString = website;
//     if (!urlString.startsWith('http://') && !urlString.startsWith('https://')) {
//       urlString = 'https://$urlString';
//     }

//     try {
//       final url = Uri.parse(urlString);
//       if (await canLaunchUrl(url)) {
//         await launchUrl(url, mode: LaunchMode.externalApplication);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar('Could not open website');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error: $e');
//       }
//     }
//   }

//   Future<void> _openMap() async {
//     final location = productData?['location'];
//     double? lat, lng;
    
//     if (location is Map && location.containsKey('coordinates')) {
//       final coords = location['coordinates'] as List;
//       if (coords.length >= 2) {
//         lng = coords[0]?.toDouble();
//         lat = coords[1]?.toDouble();
//       }
//     }

//     if (lat != null && lng != null) {
//       final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
//       if (await canLaunchUrl(url)) {
//         await launchUrl(url);
//       }
//     } else {
//       final query = Uri.encodeComponent(productData?['address'] ?? '');
//       final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
//       if (await canLaunchUrl(url)) {
//         await launchUrl(url);
//       }
//     }
//   }

//   String _generateShareText() {
//     StringBuffer text = StringBuffer();
//     final categoryName = _categoryData?['name']?.toString().toLowerCase() ?? '';
    
//     text.writeln('🏠 *${productData?['name'] ?? 'Property'}*');
//     if (_categoryData != null) {
//       text.writeln('📋 *Type:* ${_categoryData!['name']}');
//     }
//     text.writeln('');
//     text.writeln('📍 *Location:* ${productData?['address'] ?? 'Unknown'}');
    
//     // Only show price for non-company/gold shop
//     if (categoryName != 'companies' && categoryName != 'gold shops') {
//       text.writeln('💰 *Price:* ${_getFormattedPrice()}');
//     }
//     text.writeln('');
    
//     // Add all attributes dynamically
//     if (_attributes != null && _attributes!.isNotEmpty) {
//       text.writeln('📋 *Property Details:*');
      
//       _attributes!.forEach((key, value) {
//         // Skip null values
//         if (value == null) return;
        
//         // Format the key
//         String label = _formatAttributeLabel(key);
        
//         // Format the value
//         String displayValue;
//         if (value is bool) {
//           displayValue = value ? 'Yes' : 'No';
//         } else if (value is List) {
//           displayValue = value.join(', ');
//         } else if (value is num && (key.toLowerCase().contains('price') || key == 'pricePerNight')) {
//           if (key == 'pricePerNight') {
//             displayValue = '₹${value.toStringAsFixed(0)}/night';
//           } else {
//             displayValue = _formatPrice(value);
//           }
//         } else {
//           displayValue = value.toString();
//         }
        
//         // Add emoji based on key
//         String emoji = _getEmojiForKey(key);
//         text.writeln('$emoji *$label:* $displayValue');
//       });
      
//       text.writeln('');
//     }
    
//     // Add portfolio if exists
//     if (_portfolio.isNotEmpty) {
//       text.writeln('📁 *Portfolio:*');
//       for (var item in _portfolio) {
//         text.writeln('  • ${item['name'] ?? 'Project'}');
//         if (item['description'] != null && item['description'].toString().isNotEmpty) {
//           text.writeln('    ${item['description']}');
//         }
//       }
//       text.writeln('');
//     }
    
//     // Add previous events if exists
//     if (_previousEvents.isNotEmpty) {
//       text.writeln('📅 *Previous Events:*');
//       for (var event in _previousEvents) {
//         text.writeln('  • ${event['title'] ?? 'Event'}');
//         if (event['location'] != null && event['location'].toString().isNotEmpty) {
//           text.writeln('    Location: ${event['location']}');
//         }
//         if (event['eventDate'] != null) {
//           try {
//             final date = DateTime.parse(event['eventDate']);
//             text.writeln('    Date: ${date.day}/${date.month}/${date.year}');
//           } catch (e) {
//             // Ignore date parsing errors
//           }
//         }
//       }
//       text.writeln('');
//     }
    
//     text.writeln('📝 *Description:*');
//     text.writeln(productData?['description'] ?? 'Beautiful property located in prime area.');
//     text.writeln('');
//     text.writeln('📞 *Contact Details:*');
    
//     final agentName = _getAgentName();
//     final agentPhone = _getAgentPhone();
//     final agentEmail = _getAgentEmail();
//     final agentWebsite = _getAgentWebsite();
    
//     text.writeln('👤 Agent: $agentName');
//     text.writeln('📱 Phone: $agentPhone');
//     if (agentEmail != null) text.writeln('📧 Email: $agentEmail');
//     if (agentWebsite != null) text.writeln('🌐 Website: $agentWebsite');
//     text.writeln('💬 WhatsApp: Available');
//     text.writeln('');
//     text.writeln('Download our app to view more properties!');
    
//     return text.toString();
//   }

//   String _getEmojiForKey(String key) {
//     final Map<String, String> keyEmojis = {
//       // Residential
//       'bedrooms': '🛏️',
//       'bathrooms': '🚿',
//       'sqft': '📐',
//       'area': '📐',
//       'floorNumber': '🔢',
//       'totalFloors': '🏢',
//       'furnishing': '🪑',
//       'parking': '🅿️',
//       'maintenance': '💰',
//       'balcony': '🪟',
//       'lift': '🛗',
//       'garden': '🌳',
//       'floors': '🏠',
//       'privatePool': '🏊',
      
//       // Land/Farm
//       'landSize': '🌲',
//       'unit': '📏',
//       'landType': '🏞️',
//       'roadFacing': '🛣️',
//       'waterConnection': '💧',
//       'waterSource': '💧',
//       'electricityAvailable': '⚡',
//       'farmHouseBuilt': '🏡',
//       'boundaryWall': '🧱',
//       'borewell': '🪣',
//       'crops': '🌾',
      
//       // Gated Community
//       'clubhouse': '🏘️',
//       'gym': '🏋️',
//       'security': '🛡️',
//       'swimmingPool': '🏊',
//       'playArea': '🎪',
      
//       // Hotel
//       'totalRooms': '🏨',
//       'roomTypes': '🚪',
//       'pricePerNight': '🌙',
//       'restaurantAvailable': '🍽️',
//       'wifi': '📶',
//       'spa': '💆',
//       'roomService': '🛎️',
//       'breakfastIncluded': '🍳',
//       'checkInTime': '⏰',
//       'checkOutTime': '⏱️',
      
//       // Company
//       'businessType': '🏢',
//       'industry': '🏭',
//       'foundedYear': '📅',
//       'services': '🔧',
//       'technologies': '💻',
//       'clients': '👥',
//       'officeSpace': '🏢',
//       'meetingRooms': '🚪',
//       'remoteWork': '🏠',
//       'hiring': '💼',
//       'workingHours': '⏰',
//       'workingDays': '📆',
      
//       // Gold Shop
//       'shopName': '🏪',
//       'establishedYear': '📅',
//       'certified': '✅',
//       'hallmarkAvailable': '✨',
//       'exchangeAvailable': '🔄',
//       'customDesign': '🎨',
//       'repairsService': '🔨',
//       'goldRate': '💰',
//       'silverRate': '💰',
//       'makingCharge': '💵',
//       'schemesAvailable': '🎁',
//       'openingHours': '⏰',
      
//       // Common
//       'price': '💰',
//       'availableFor': '📅',
//       'availability': '📅',
//       'ownership': '📄',
//     };
    
//     return keyEmojis[key] ?? '•';
//   }

//   void _shareProperty() async {
//     try {
//       String shareText = _generateShareText();
//       await Share.share(
//         shareText,
//         subject: 'Check out this property: ${productData?['name']}',
//       );
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Error sharing: $e');
//       }
//     }
//   }

//   void _showContactOptions() {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         final agentEmail = _getAgentEmail();
//         final agentWebsite = _getAgentWebsite();
        
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.phone, color: Colors.green, size: 24),
//                 ),
//                 title: const Text('Call'),
//                 subtitle: Text(_getAgentPhone()),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _makePhoneCall();
//                 },
//               ),
//               ListTile(
//                 leading: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Image.asset(
//                     'assets/images/whatsapp.png',
//                     width: 24,
//                     height: 24,
//                     errorBuilder: (_, __, ___) {
//                       return const Icon(Icons.chat, color: Colors.green, size: 24);
//                     },
//                   ),
//                 ),
//                 title: const Text('WhatsApp'),
//                 subtitle: Text(_getAgentPhone()),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _openWhatsApp();
//                 },
//               ),
//               if (agentEmail != null)
//                 ListTile(
//                   leading: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.red.shade50,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.email, color: Colors.red, size: 24),
//                   ),
//                   title: const Text('Email'),
//                   subtitle: Text(agentEmail),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _sendEmail();
//                   },
//                 ),
//               if (agentWebsite != null)
//                 ListTile(
//                   leading: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade50,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.language, color: Colors.blue, size: 24),
//                   ),
//                   title: const Text('Website'),
//                   subtitle: Text(agentWebsite),
//                   onTap: () {
//                     Navigator.pop(context);
//                     _openWebsite();
//                   },
//                 ),
//               ListTile(
//                 leading: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.share, color: Colors.blue, size: 24),
//                 ),
//                 title: const Text('Share'),
//                 subtitle: const Text('Share property details'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _shareProperty();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showErrorSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             const Icon(Icons.error_outline, color: Colors.white, size: 20),
//             const SizedBox(width: 8),
//             Expanded(child: Text(message)),
//           ],
//         ),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const CircularProgressIndicator(),
//               const SizedBox(height: 16),
//               Text(
//                 'Loading property details...',
//                 style: TextStyle(color: Colors.grey.shade600),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     if (errorMessage != null) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Failed to load property',
//                   style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   errorMessage!,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey.shade600),
//                 ),
//                 const SizedBox(height: 24),
//                 ElevatedButton(
//                   onPressed: _fetchProductDetails,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFE33629),
//                     foregroundColor: Colors.white,
//                   ),
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     }

//     final additionalFeatures = _getAdditionalFeatures();
//     final String categoryName = _categoryData?['name']?.toString().toLowerCase() ?? '';
//     final agentName = _getAgentName();
//     final agentPhone = _getAgentPhone();
//     final agentEmail = _getAgentEmail();
//     final agentWebsite = _getAgentWebsite();
    
//     // Determine property type for stats
//     final bool isLandOrFarm = categoryName == 'land' || categoryName == 'farm';
//     final bool isHotel = categoryName == 'hotel';
//     final bool isCompany = categoryName == 'companies';
//     final bool isGoldShop = categoryName == 'gold shops';

//     // Get working hours/days for company/gold shop
//     final String? workingHours = _getWorkingHours();
//     final String? workingDays = _getWorkingDays();
//     final String? openingHours = _getOpeningHours();

//     // Determine title for About/Features section
//     String aboutTitle = 'Features';
//     if (isCompany) {
//       aboutTitle = 'About Us';
//     } else if (isGoldShop) {
//       aboutTitle = 'About Shop';
//     }

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: _PropertyImageHeader(
//                   images: _images,
//                   title: productData?['name'],
//                   categoryName: _categoryData?['name'],
//                   isFavorite: isFavorite,
//                   currentIndex: _currentImageIndex,
//                   onPageChanged: (index) {
//                     setState(() {
//                       _currentImageIndex = index;
//                     });
//                   },
//                   onFavoriteTap: () {
//                     setState(() {
//                       isFavorite = !isFavorite;
//                     });
//                   },
//                   onShareTap: _showContactOptions,
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Title and Price (hide price for company/gold shop)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: Text(
//                               productData?['name'] ?? 'Property',
//                               style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                           if (!isCompany && !isGoldShop && _getFormattedPrice().isNotEmpty)
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFE33629).withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 _getFormattedPrice(),
//                                 style: const TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w700,
//                                   color: Color(0xFFE33629),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),

//                       const SizedBox(height: 12),

//                       // ===== NEW: Working Hours/Days for Company/Gold Shop (shown at top) =====
//                       if ((isCompany || isGoldShop) && (workingHours != null || workingDays != null))
//                         Container(
//                           margin: const EdgeInsets.only(bottom: 12),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade50,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.blue.shade200),
//                           ),
//                           child: Row(
//                             children: [
//                               Icon(Icons.access_time, color: Colors.blue.shade700, size: 20),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     if (isGoldShop && openingHours != null) ...[
//                                       Text(
//                                         'Opening Hours: $openingHours',
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.blue.shade700,
//                                         ),
//                                       ),
//                                       if (workingDays != null) ...[
//                                         const SizedBox(height: 4),
//                                         Text(
//                                           'Working Days: $workingDays',
//                                           style: TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.blue.shade700,
//                                           ),
//                                         ),
//                                       ],
//                                     ] else if (workingHours != null) ...[
//                                       Text(
//                                         'Working Hours: $workingHours',
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.blue.shade700,
//                                         ),
//                                       ),
//                                       if (workingDays != null) ...[
//                                         const SizedBox(height: 4),
//                                         Text(
//                                           'Working Days: $workingDays',
//                                           style: TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.blue.shade700,
//                                           ),
//                                         ),
//                                       ],
//                                     ] else if (workingDays != null) ...[
//                                       Text(
//                                         'Working Days: $workingDays',
//                                         style: TextStyle(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.blue.shade700,
//                                         ),
//                                       ),
//                                     ],
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                       // Location with Agent Info
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           children: [
//                             // Location
//                             Row(
//                               children: [
//                                 Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade600),
//                                 const SizedBox(width: 8),
//                                 Expanded(
//                                   child: Text(
//                                     productData?['address'] ?? 'Unknown location',
//                                     style: TextStyle(
//                                       fontSize: 13,
//                                       color: Colors.grey.shade700,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
                            
//                             // Agent Info - Enhanced with contact details
//                             const SizedBox(height: 8),
//                             const Divider(height: 1),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 20,
//                                   backgroundImage: _userData != null && _userData!['profileImage'] != null
//                                       ? NetworkImage(_userData!['profileImage'])
//                                       : null,
//                                   child: _userData == null || _userData!['profileImage'] == null
//                                       ? const Icon(Icons.person, size: 20)
//                                       : null,
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         agentName,
//                                         style: const TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Row(
//                                         children: [
//                                           const Icon(Icons.phone, size: 12, color: Colors.grey),
//                                           const SizedBox(width: 4),
//                                           Text(
//                                             agentPhone,
//                                             style: TextStyle(
//                                               fontSize: 11,
//                                               color: Colors.grey.shade600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       if (agentEmail != null) ...[
//                                         const SizedBox(height: 2),
//                                         Row(
//                                           children: [
//                                             const Icon(Icons.email, size: 12, color: Colors.grey),
//                                             const SizedBox(width: 4),
//                                             Expanded(
//                                               child: Text(
//                                                 agentEmail,
//                                                 style: TextStyle(
//                                                   fontSize: 11,
//                                                   color: Colors.grey.shade600,
//                                                 ),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ],
//                                   ),
//                                 ),
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     color: Colors.green.shade50,
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                   child: Text(
//                                     'Verified',
//                                     style: TextStyle(
//                                       fontSize: 10,
//                                       color: Colors.green.shade700,
//                                       fontWeight: FontWeight.w600,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
                            
//                             // Website link if available
//                             if (agentWebsite != null) ...[
//                               const SizedBox(height: 8),
//                               GestureDetector(
//                                 onTap: _openWebsite,
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue.shade50,
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       const Icon(Icons.language, size: 14, color: Colors.blue),
//                                       const SizedBox(width: 6),
//                                       Expanded(
//                                         child: Text(
//                                           agentWebsite,
//                                           style: const TextStyle(
//                                             fontSize: 11,
//                                             color: Colors.blue,
//                                             decoration: TextDecoration.underline,
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // Stats Container - Conditionally show based on property type
//                       if (_attributes != null && !isCompany && !isGoldShop)
//                         isHotel
//                             ? _buildHotelStats()
//                             : isLandOrFarm
//                                 ? _buildLandStats()
//                                 : _buildResidentialStats(),

//                       if (_attributes != null && !isCompany && !isGoldShop)
//                         const SizedBox(height: 20),

//                       // Description
//                       const _SectionTitle("Description"),
//                       const SizedBox(height: 8),
//                       Container(
//                         padding: const EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           productData?['description'] ??
//                               'Beautiful property located in prime area with modern amenities.',
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.grey.shade700,
//                             height: 1.5,
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // ===== NEW: Portfolio Section for Companies =====
//                       if (isCompany && _portfolio.isNotEmpty) ...[
//                         const _SectionTitle("Portfolio"),
//                         const SizedBox(height: 12),
//                         ..._portfolio.map((item) => _buildPortfolioItem(item)).toList(),
//                         const SizedBox(height: 20),
//                       ],

//                       // ===== NEW: Previous Events Section =====
//                       if ((isCompany || isHotel || isGoldShop) && _previousEvents.isNotEmpty) ...[
//                         const _SectionTitle("Previous Events"),
//                         const SizedBox(height: 12),
//                         ..._previousEvents.map((event) => _buildEventItem(event)).toList(),
//                         const SizedBox(height: 20),
//                       ],

//                       // Additional Features (renamed to About Us for company)
//                       if (additionalFeatures.isNotEmpty) ...[
//                         _SectionTitle(aboutTitle),
//                         const SizedBox(height: 12),
//                         Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: additionalFeatures.map((feature) {
//                             return Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                               decoration: BoxDecoration(
//                                 color: feature['available'] 
//                                     ? Colors.green.shade50 
//                                     : Colors.grey.shade100,
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(
//                                   color: feature['available'] 
//                                       ? Colors.green.shade200 
//                                       : Colors.grey.shade300,
//                                 ),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     feature['icon'],
//                                     size: 14,
//                                     color: feature['available'] 
//                                         ? Colors.green.shade700 
//                                         : Colors.grey.shade500,
//                                   ),
//                                   const SizedBox(width: 6),
//                                   Text(
//                                     feature['label'],
//                                     style: TextStyle(
//                                       fontSize: 11,
//                                       color: feature['available'] 
//                                           ? Colors.green.shade700 
//                                           : Colors.grey.shade600,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   if (feature['value'] != null && feature['value'].toString().isNotEmpty) ...[
//                                     const SizedBox(width: 4),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: feature['available'] 
//                                             ? Colors.green.shade100 
//                                             : Colors.grey.shade200,
//                                         borderRadius: BorderRadius.circular(12),
//                                       ),
//                                       child: Text(
//                                         feature['value'],
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           color: feature['available'] 
//                                               ? Colors.green.shade800 
//                                               : Colors.grey.shade700,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],

//                       const SizedBox(height: 20),

//                       // Map Section
//                       const _SectionTitle("Location on Map"),
//                       const SizedBox(height: 10),

//                       GestureDetector(
//                         onTap: _openMap,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(14),
//                           child: Container(
//                             height: 160,
//                             width: double.infinity,
//                             color: Colors.grey.shade200,
//                             child: Stack(
//                               children: [
//                                 Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Icon(Icons.map, size: 40, color: Colors.grey.shade400),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         'Tap to open map',
//                                         style: TextStyle(color: Colors.grey.shade600),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 12,
//                                   left: 12,
//                                   child: Container(
//                                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(20),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.1),
//                                           blurRadius: 4,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         const Icon(Icons.location_on, size: 14, color: Color(0xFFE33629)),
//                                         const SizedBox(width: 4),
//                                         Text(
//                                           productData?['address']?.toString().split(',').first ?? 'View on Map',
//                                           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: _BottomActionBar(
//               onContactTap: _showContactOptions,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ===== NEW: Build portfolio item widget =====
//   Widget _buildPortfolioItem(Map<String, dynamic> item) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Logo
//           if (item['logo'] != null && item['logo'].toString().isNotEmpty)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 item['logo'],
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   width: 60,
//                   height: 60,
//                   color: Colors.grey.shade300,
//                   child: const Icon(Icons.broken_image, color: Colors.grey),
//                 ),
//               ),
//             )
//           else
//             Container(
//               width: 60,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(Icons.image_not_supported, color: Colors.grey.shade400),
//             ),
          
//           const SizedBox(width: 12),
          
//           // Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   item['name'] ?? 'Project',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 if (item['description'] != null && item['description'].toString().isNotEmpty) ...[
//                   const SizedBox(height: 4),
//                   Text(
//                     item['description'],
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey.shade600,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     if (item['playStoreLink'] != null && item['playStoreLink'].toString().isNotEmpty)
//                       _buildLinkIcon(
//                         icon: Icons.play_arrow,
//                         color: Colors.green,
//                         onTap: () => _launchUrl(item['playStoreLink']),
//                       ),
//                     if (item['appStoreLink'] != null && item['appStoreLink'].toString().isNotEmpty)
//                       _buildLinkIcon(
//                         icon: Icons.apple,
//                         color: Colors.black,
//                         onTap: () => _launchUrl(item['appStoreLink']),
//                       ),
//                     if (item['website'] != null && item['website'].toString().isNotEmpty)
//                       _buildLinkIcon(
//                         icon: Icons.language,
//                         color: Colors.blue,
//                         onTap: () => _launchUrl(item['website']),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ===== NEW: Build event item widget =====
//   Widget _buildEventItem(Map<String, dynamic> event) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade50,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image
//           if (event['image'] != null && event['image'].toString().isNotEmpty)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8),
//               child: Image.network(
//                 event['image'],
//                 width: 80,
//                 height: 80,
//                 fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   width: 80,
//                   height: 80,
//                   color: Colors.grey.shade300,
//                   child: const Icon(Icons.broken_image, color: Colors.grey),
//                 ),
//               ),
//             )
//           else
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(Icons.event, color: Colors.grey.shade400),
//             ),
          
//           const SizedBox(width: 12),
          
//           // Details
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   event['title'] ?? 'Event',
//                   style: const TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 if (event['description'] != null && event['description'].toString().isNotEmpty) ...[
//                   const SizedBox(height: 4),
//                   Text(
//                     event['description'],
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey.shade600,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//                 if (event['location'] != null && event['location'].toString().isNotEmpty) ...[
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(Icons.location_on, size: 12, color: Colors.grey.shade500),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           event['location'],
//                           style: TextStyle(
//                             fontSize: 11,
//                             color: Colors.grey.shade500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//                 if (event['eventDate'] != null) ...[
//                   const SizedBox(height: 4),
//                   Row(
//                     children: [
//                       Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade500),
//                       const SizedBox(width: 4),
//                       Text(
//                         _formatDate(event['eventDate']),
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.grey.shade500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ===== NEW: Build link icon =====
//   Widget _buildLinkIcon({
//     required IconData icon,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(right: 8),
//         padding: const EdgeInsets.all(6),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Icon(icon, size: 16, color: color),
//       ),
//     );
//   }

//   // ===== NEW: Launch URL =====
//   Future<void> _launchUrl(String url) async {
//     try {
//       String urlString = url;
//       if (!urlString.startsWith('http://') && !urlString.startsWith('https://')) {
//         urlString = 'https://$urlString';
//       }
//       final uri = Uri.parse(urlString);
//       if (await canLaunchUrl(uri)) {
//         await launchUrl(uri, mode: LaunchMode.externalApplication);
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar('Could not open link');
//       }
//     }
//   }

//   // ===== NEW: Format date =====
//   String _formatDate(dynamic date) {
//     try {
//       if (date is String) {
//         final parsedDate = DateTime.parse(date);
//         return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
//       } else if (date is DateTime) {
//         return '${date.day}/${date.month}/${date.year}';
//       }
//     } catch (e) {
//       // Ignore parsing errors
//     }
//     return date?.toString() ?? '';
//   }

//   Widget _buildHotelStats() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           // Total Rooms
//           if (_attributes!.containsKey('totalRooms'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.hotel,
//                 label: 'Total Rooms',
//                 value: _attributes!['totalRooms'].toString(),
//               ),
//             ),
          
//           if (_attributes!.containsKey('totalRooms') && _attributes!.containsKey('pricePerNight'))
//             Container(width: 1, height: 30, color: Colors.grey.shade300),
          
//           // Price Per Night
//           if (_attributes!.containsKey('pricePerNight'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.nightlife,
//                 label: 'Per Night',
//                 value: '₹${_attributes!['pricePerNight']}',
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLandStats() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           // Land Size
//           if (_attributes!.containsKey('landSize'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.square_foot,
//                 label: 'Land Size',
//                 value: '${_attributes!['landSize']} ${_attributes!['unit'] ?? ''}',
//               ),
//             ),
          
//           if (_attributes!.containsKey('landSize') && _attributes!.containsKey('landType'))
//             Container(width: 1, height: 30, color: Colors.grey.shade300),
          
//           // Land Type
//           if (_attributes!.containsKey('landType'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.landscape,
//                 label: 'Land Type',
//                 value: _attributes!['landType'],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildResidentialStats() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           // Bedrooms
//           if (_attributes!.containsKey('bedrooms'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.bed_outlined,
//                 label: 'Bedrooms',
//                 value: '${_attributes!['bedrooms']} Bed',
//               ),
//             ),
          
//           if (_attributes!.containsKey('bedrooms') && _attributes!.containsKey('bathrooms'))
//             Container(width: 1, height: 30, color: Colors.grey.shade300),
          
//           // Bathrooms
//           if (_attributes!.containsKey('bathrooms'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.bathtub_outlined,
//                 label: 'Bathrooms',
//                 value: '${_attributes!['bathrooms']} Bath',
//               ),
//             ),
          
//           if (_attributes!.containsKey('bathrooms') && _attributes!.containsKey('sqft'))
//             Container(width: 1, height: 30, color: Colors.grey.shade300),
          
//           // Area
//           if (_attributes!.containsKey('sqft'))
//             Expanded(
//               child: _StatItem(
//                 icon: Icons.square_foot,
//                 label: 'Area',
//                 value: '${_attributes!['sqft']} sqft',
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // ── Property Image Header with Gallery ─────────────────────────────────────
// class _PropertyImageHeader extends StatelessWidget {
//   final List<dynamic> images;
//   final String? title;
//   final String? categoryName;
//   final bool isFavorite;
//   final int currentIndex;
//   final Function(int) onPageChanged;
//   final VoidCallback onFavoriteTap;
//   final VoidCallback onShareTap;

//   const _PropertyImageHeader({
//     required this.images,
//     required this.title,
//     required this.categoryName,
//     required this.isFavorite,
//     required this.currentIndex,
//     required this.onPageChanged,
//     required this.onFavoriteTap,
//     required this.onShareTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final hasImages = images.isNotEmpty;

//     return Stack(
//       children: [
//         // Image Gallery
//         SizedBox(
//           height: 375,
//           width: double.infinity,
//           child: Stack(
//             children: [
//               PageView.builder(
//                 onPageChanged: onPageChanged,
//                 itemCount: hasImages ? images.length : 1,
//                 itemBuilder: (context, index) {
//                   final imageUrl = hasImages ? images[index].toString() : null;
                  
//                   return ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       bottom: Radius.circular(30),
//                     ),
//                     child: imageUrl != null && imageUrl.startsWith('http')
//                         ? Image.network(
//                             imageUrl,
//                             fit: BoxFit.cover,
//                             errorBuilder: (context, error, stackTrace) {
//                               return _buildPlaceholder();
//                             },
//                           )
//                         : _buildPlaceholder(),
//                   );
//                 },
//               ),

//               // Image Counter
//               if (hasImages && images.length > 1)
//                 Positioned(
//                   bottom: 16,
//                   right: 16,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.6),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       '${currentIndex + 1}/${images.length}',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),

//               // Category Badge
//               if (categoryName != null)
//                 Positioned(
//                   top: 44,
//                   left: 14,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       categoryName!,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),

//         // Back Button
//         Positioned(
//           top: 44,
//           left: 14,
//           child: _CircleIconButton(
//             icon: Icons.arrow_back,
//             onTap: () => Navigator.pop(context),
//           ),
//         ),

//         // Action Icons
//         Positioned(
//           top: 44,
//           right: 14,
//           child: Column(
//             children: [
//               _CircleIconButton(
//                 icon: isFavorite ? Icons.favorite : Icons.favorite_border,
//                 onTap: onFavoriteTap,
//               ),
//               const SizedBox(height: 12),
//               _CircleIconButton(
//                 icon: Icons.share,
//                 onTap: onShareTap,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPlaceholder() {
//     return Container(
//       color: Colors.grey.shade300,
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.image_not_supported, size: 50, color: Colors.grey.shade500),
//             const SizedBox(height: 8),
//             Text(
//               'No Image',
//               style: TextStyle(color: Colors.grey.shade600),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ── Circle Icon Button ───────────────────────────────────────────────────
// class _CircleIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const _CircleIconButton({
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 36,
//         height: 36,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Icon(icon, size: 18, color: Colors.black87),
//       ),
//     );
//   }
// }

// // ── Section Title ────────────────────────────────────────────────────────
// class _SectionTitle extends StatelessWidget {
//   final String title;

//   const _SectionTitle(this.title);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w700,
//         color: Colors.black87,
//       ),
//     );
//   }
// }

// // ── Stat Item ────────────────────────────────────────────────────────────
// class _StatItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;

//   const _StatItem({
//     required this.icon,
//     required this.label,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, size: 18, color: const Color(0xFFE33629)),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w700,
//             color: Colors.black87,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 10,
//             color: Colors.grey.shade600,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Bottom Action Bar ─────────────────────────────────────────────────────
// class _BottomActionBar extends StatelessWidget {
//   final VoidCallback onContactTap;

//   const _BottomActionBar({
//     required this.onContactTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.07),
//             blurRadius: 12,
//             offset: const Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Map Button
//           Expanded(
//             child: GestureDetector(
//               onTap: () {}, // Map functionality is elsewhere
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.map_outlined, size: 18, color: Colors.grey.shade700),
//                     const SizedBox(width: 6),
//                     const Text(
//                       "Map",
//                       style: TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 8),

//           // Contact Button
//           Expanded(
//             flex: 2,
//             child: GestureDetector(
//               onTap: onContactTap,
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE33629),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.contact_phone, color: Colors.white, size: 18),
//                     SizedBox(width: 8),
//                     Text(
//                       "Contact Agent",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

























import 'package:flutter/material.dart';
import 'package:product_app/constant/api_constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearestHouseDetail extends StatefulWidget {
  final String productId;

  const NearestHouseDetail({
    super.key,
    required this.productId,
  });

  @override
  State<NearestHouseDetail> createState() => _NearestHouseDetailState();
}

class _NearestHouseDetailState extends State<NearestHouseDetail> {
  bool isLoading = true;
  String? errorMessage;
  Map<String, dynamic>? productData;
  
  bool isFavorite = false;
  int _currentImageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fetchProductDetails();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _fetchProductDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/api/${widget.productId}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          setState(() {
            productData = Map<String, dynamic>.from(data['product']);
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load product');
        }
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  // Helper methods to safely extract data
  Map<String, dynamic>? get _userData => 
      productData?['user'] is Map ? Map<String, dynamic>.from(productData!['user']) : null;

  Map<String, dynamic>? get _categoryData => 
      productData?['category'] is Map ? Map<String, dynamic>.from(productData!['category']) : null;

  Map<String, dynamic>? get _attributes => 
      productData?['attributes'] is Map ? Map<String, dynamic>.from(productData!['attributes']) : null;

  Map<String, dynamic>? get _contact => 
      productData?['contact'] is Map ? Map<String, dynamic>.from(productData!['contact']) : null;

  List<dynamic> get _images => 
      productData?['images'] is List ? List.from(productData!['images']) : [];

  List<dynamic> get _portfolio => 
      productData?['portfolio'] is List ? List.from(productData!['portfolio']) : [];

  List<dynamic> get _previousEvents => 
      productData?['previousEvents'] is List ? List.from(productData!['previousEvents']) : [];

  List<dynamic> get _features => 
      productData?['features'] is List ? List.from(productData!['features']) : [];

  String _getFormattedPrice() {
    final categoryName = _categoryData?['name']?.toString().toLowerCase() ?? '';
    
    // For companies and gold shops - DON'T show price
    if (categoryName == 'companies' || categoryName == 'gold shops') {
      return ''; // Return empty string - price won't be shown
    }

    if (_attributes == null) return 'Price on Request';

    // Check for different price types
    if (_attributes!.containsKey('pricePerNight')) {
      final price = _attributes!['pricePerNight'];
      if (price is num) {
        return '₹${price.toStringAsFixed(0)}/night';
      }
    }
    
    if (_attributes!.containsKey('price')) {
      final price = _attributes!['price'];
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
      }
      return price.toString();
    }
    
    return 'Price on Request';
  }

  String _getAgentPhone() {
    // Try to get from contact object first
    if (_contact != null) {
      if (_contact!.containsKey('callNumber') && _contact!['callNumber'] != null) {
        return _contact!['callNumber'].toString().replaceAll('+', '');
      }
      if (_contact!.containsKey('whatsappNumber') && _contact!['whatsappNumber'] != null) {
        return _contact!['whatsappNumber'].toString().replaceAll('+', '');
      }
    }
    
    // Then try from user object
    if (_userData != null) {
      if (_userData!.containsKey('mobile') && _userData!['mobile'] != null) {
        return _userData!['mobile'].toString().replaceAll('+', '');
      }
    }
    
    // Default fallback
    return '919961593179';
  }

  String _getAgentName() {
    if (_userData != null && _userData!.containsKey('name') && _userData!['name'] != null) {
      return _userData!['name'].toString();
    }
    return "Info";
  }

  String? _getAgentEmail() {
    if (_contact != null && _contact!.containsKey('email') && _contact!['email'] != null) {
      return _contact!['email'].toString();
    }
    if (_userData != null && _userData!.containsKey('email') && _userData!['email'] != null) {
      return _userData!['email'].toString();
    }
    return null;
  }

  String? _getAgentWebsite() {
    if (_contact != null && _contact!.containsKey('website') && _contact!['website'] != null) {
      return _contact!['website'].toString();
    }
    return null;
  }

  String? _getWorkingHours() {
    if (_attributes != null && _attributes!.containsKey('workingHours')) {
      return _attributes!['workingHours'].toString();
    }
    return null;
  }

  String? _getWorkingDays() {
    if (_attributes != null && _attributes!.containsKey('workingDays')) {
      return _attributes!['workingDays'].toString();
    }
    return null;
  }

  String? _getOpeningHours() {
    if (_attributes != null && _attributes!.containsKey('openingHours')) {
      return _attributes!['openingHours'].toString();
    }
    return _getWorkingHours();
  }

  List<Map<String, dynamic>> _getAdditionalFeatures() {
    List<Map<String, dynamic>> features = [];
    final categoryName = _categoryData?['name']?.toString().toLowerCase() ?? '';
    
    if (_attributes == null) return features;

    final Map<String, IconData> attributeIcons = {
      // Land/Farm attributes
      'landSize': Icons.square_foot,
      'unit': Icons.straighten,
      'landType': Icons.landscape,
      'roadFacing': Icons.map,
      'waterConnection': Icons.water_drop,
      'electricityAvailable': Icons.electric_bolt,
      'waterSource': Icons.water,
      'farmHouseBuilt': Icons.house,
      'boundaryWall': Icons.stop,
      'borewell': Icons.water,
      'crops': Icons.grass,
      
      // Residential attributes
      'bedrooms': Icons.bed,
      'bathrooms': Icons.bathtub,
      'sqft': Icons.square_foot,
      'floorNumber': Icons.stairs,
      'totalFloors': Icons.apartment,
      'furnishing': Icons.chair,
      'parking': Icons.local_parking,
      'maintenance': Icons.money,
      'balcony': Icons.window,
      'lift': Icons.elevator,
      'garden': Icons.grass,
      'floors': Icons.stairs,
      'privatePool': Icons.pool,
      
      // Gated community attributes
      'clubhouse': Icons.celebration,
      'gym': Icons.fitness_center,
      'security': Icons.security,
      'swimmingPool': Icons.pool,
      'playArea': Icons.sports_handball,
      
      // Hotel attributes
      'totalRooms': Icons.hotel,
      'roomTypes': Icons.meeting_room,
      'pricePerNight': Icons.nightlife,
      'restaurantAvailable': Icons.restaurant,
      'wifi': Icons.wifi,
      'spa': Icons.spa,
      'roomService': Icons.room_service,
      'breakfastIncluded': Icons.free_breakfast,
      'checkInTime': Icons.login,
      'checkOutTime': Icons.logout,
      
      // Company attributes
      'businessType': Icons.business,
      'industry': Icons.category,
      'foundedYear': Icons.calendar_today,
      'services': Icons.build,
      'technologies': Icons.computer,
      'clients': Icons.people,
      'officeSpace': Icons.business_center,
      'meetingRooms': Icons.meeting_room,
      'remoteWork': Icons.home_work,
      'hiring': Icons.work,
      
      // Gold shop attributes
      'shopName': Icons.store,
      'establishedYear': Icons.calendar_today,
      'certified': Icons.verified,
      'hallmarkAvailable': Icons.star,
      'exchangeAvailable': Icons.swap_horiz,
      'customDesign': Icons.design_services,
      'repairsService': Icons.build,
      'goldRate': Icons.monetization_on,
      'silverRate': Icons.monetization_on,
      'makingCharge': Icons.receipt,
      'schemesAvailable': Icons.card_giftcard,
      
      // Common
      'price': Icons.currency_rupee,
      'availableFor': Icons.event_available,
      'workingHours': Icons.access_time,
      'workingDays': Icons.date_range,
      'openingHours': Icons.access_time,
    };

    final List<String> statsKeys = ['bedrooms', 'bathrooms', 'sqft', 'landSize', 'unit', 'landType', 'totalRooms', 'pricePerNight'];
    final List<String> topBarKeys = ['workingHours', 'workingDays', 'openingHours'];

    _attributes!.forEach((key, value) {
      if (value == null) return;

      if ((categoryName == 'companies' || categoryName == 'gold shops') && topBarKeys.contains(key)) {
        return;
      }

      if (key == 'roomTypes' && value is List) {
        features.add({
          'icon': attributeIcons[key] ?? Icons.meeting_room,
          'label': 'Room Types',
          'value': value.join(', '),
          'available': true,
        });
      }
      else if (key == 'checkInTime' || key == 'checkOutTime') {
        features.add({
          'icon': attributeIcons[key] ?? Icons.access_time,
          'label': key == 'checkInTime' ? 'Check-in' : 'Check-out',
          'value': value.toString(),
          'available': true,
        });
      }
      else if (!statsKeys.contains(key)) {
        String label = _formatAttributeLabel(key);
        String displayValue = _formatAttributeValue(key, value);
        bool isAvailable = true;
        
        if (value is bool) {
          isAvailable = value;
          if (!isAvailable) return;
        }

        IconData icon = attributeIcons[key] ?? Icons.info_outline;

        features.add({
          'icon': icon,
          'label': label,
          'value': displayValue,
          'available': isAvailable,
        });
      }
    });

    return features;
  }

  String _formatAttributeLabel(String key) {
    String label = key.replaceAllMapped(RegExp(r'([A-Z])'), (match) => ' ${match[1]}');
    label = label.replaceAll('_', ' ');
    label = label.split(' ').map((word) => 
      word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : ''
    ).join(' ');
    
    // Special cases
    if (label.toLowerCase() == 'sqft') return 'Area';
    if (label.toLowerCase() == 'available for') return 'Availability';
    if (label.toLowerCase() == 'electricity available') return 'Electricity';
    if (label.toLowerCase() == 'water connection') return 'Water';
    if (label.toLowerCase() == 'road facing') return 'Road Access';
    if (label.toLowerCase() == 'farm house built') return 'Farm House';
    if (label.toLowerCase() == 'land size') return 'Land Size';
    if (label.toLowerCase() == 'land type') return 'Land Type';
    if (label.toLowerCase() == 'total rooms') return 'Total Rooms';
    if (label.toLowerCase() == 'price per night') return 'Price/Night';
    if (label.toLowerCase() == 'restaurant available') return 'Restaurant';
    if (label.toLowerCase() == 'breakfast included') return 'Breakfast';
    if (label.toLowerCase() == 'check in time') return 'Check-in';
    if (label.toLowerCase() == 'check out time') return 'Check-out';
    if (label.toLowerCase() == 'room service') return 'Room Service';
    if (label.toLowerCase() == 'business type') return 'Business Type';
    if (label.toLowerCase() == 'founded year') return 'Founded';
    if (label.toLowerCase() == 'office space') return 'Office Space';
    if (label.toLowerCase() == 'meeting rooms') return 'Meeting Rooms';
    if (label.toLowerCase() == 'remote work') return 'Remote Work';
    if (label.toLowerCase() == 'working hours') return 'Working Hours';
    if (label.toLowerCase() == 'working days') return 'Working Days';
    if (label.toLowerCase() == 'opening hours') return 'Opening Hours';
    if (label.toLowerCase() == 'established year') return 'Established';
    if (label.toLowerCase() == 'hallmark available') return 'Hallmark';
    if (label.toLowerCase() == 'exchange available') return 'Exchange';
    if (label.toLowerCase() == 'custom design') return 'Custom Design';
    if (label.toLowerCase() == 'repairs service') return 'Repairs';
    if (label.toLowerCase() == 'gold rate') return 'Gold Rate';
    if (label.toLowerCase() == 'silver rate') return 'Silver Rate';
    if (label.toLowerCase() == 'making charge') return 'Making Charge';
    if (label.toLowerCase() == 'schemes available') return 'Schemes';
    
    return label;
  }

  String _formatAttributeValue(String key, dynamic value) {
    if (value is bool) {
      return value ? 'Yes' : 'No';
    }
    
    if (value is num) {
      if (key.toLowerCase().contains('price') || key == 'goldRate' || key == 'silverRate' || key == 'makingCharge') {
        return _formatPrice(value);
      }
      if (key.toLowerCase().contains('size') || key.toLowerCase().contains('area') || key == 'officeSpace') {
        return value.toStringAsFixed(0);
      }
      if (key == 'foundedYear' || key == 'establishedYear') {
        return value.toStringAsFixed(0);
      }
      return value.toString();
    }
    
    if (value is List) {
      return value.join(', ');
    }
    
    return value.toString();
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
    }
    return price.toString();
  }

  Future<void> _openWhatsApp() async {
    final phoneNumber = _getAgentPhone();
    final formattedPhone = phoneNumber.toString().replaceAll('+', '');
    
    final message = Uri.encodeComponent(
      'Hi, I am interested in the property: ${productData?['name'] ?? 'Property'} '
      'located at ${productData?['address'] ?? 'Unknown location'}. '
      'Price: ${_getFormattedPrice()}'
    );

    final whatsappUrl = Uri.parse('https://wa.me/$formattedPhone?text=$message');

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          _showErrorSnackBar('Could not open WhatsApp');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar('Error: $e');
      }
    }
  }

  Future<void> _makePhoneCall() async {
    final phoneNumber = _getAgentPhone();
    final phoneUrl = Uri.parse('tel:$phoneNumber');

    try {
      if (await canLaunchUrl(phoneUrl)) {
        await launchUrl(phoneUrl);
      } else {
        if (context.mounted) {
          _showErrorSnackBar('Could not make phone call');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar('Error: $e');
      }
    }
  }

  Future<void> _sendEmail() async {
    final email = _getAgentEmail();
    if (email == null) {
      _showErrorSnackBar('No email available');
      return;
    }

    final subject = 'Inquiry about ${productData?['name'] ?? 'Property'}';
    final body = 'Hi, I am interested in the property: ${productData?['name'] ?? 'Property'} '
        'located at ${productData?['address'] ?? 'Unknown location'}. Price: ${_getFormattedPrice()}';
    
    final emailUrl = Uri.parse('mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}');
    
    try {
      if (await canLaunchUrl(emailUrl)) {
        await launchUrl(emailUrl);
      } else {
        if (context.mounted) {
          _showErrorSnackBar('Could not open email app');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar('Error: $e');
      }
    }
  }

  Future<void> _openWebsite() async {
    final website = _getAgentWebsite();
    if (website == null) {
      _showErrorSnackBar('No website available');
      return;
    }

    String urlString = website;
    if (!urlString.startsWith('http://') && !urlString.startsWith('https://')) {
      urlString = 'https://$urlString';
    }

    try {
      final url = Uri.parse(urlString);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          _showErrorSnackBar('Could not open website');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar('Error: $e');
      }
    }
  }

  Future<void> _openMap() async {
    final location = productData?['location'];
    double? lat, lng;
    
    if (location is Map && location.containsKey('coordinates')) {
      final coords = location['coordinates'] as List;
      if (coords.length >= 2) {
        lng = coords[0]?.toDouble();
        lat = coords[1]?.toDouble();
      }
    }

    if (lat != null && lng != null) {
      final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$lat,$lng');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    } else {
      final query = Uri.encodeComponent(productData?['address'] ?? '');
      final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      }
    }
  }

  String _generateShareText() {
    StringBuffer text = StringBuffer();
    final categoryName = _categoryData?['name']?.toString().toLowerCase() ?? '';
    
    text.writeln('🏠 *${productData?['name'] ?? 'Property'}*');
    if (_categoryData != null) {
      text.writeln('📋 *Type:* ${_categoryData!['name']}');
    }
    text.writeln('');
    text.writeln('📍 *Location:* ${productData?['address'] ?? 'Unknown'}');
    
    if (categoryName != 'companies' && categoryName != 'gold shops') {
      text.writeln('💰 *Price:* ${_getFormattedPrice()}');
    }
    text.writeln('');
    
    if (_attributes != null && _attributes!.isNotEmpty) {
      text.writeln('📋 *Property Details:*');
      
      _attributes!.forEach((key, value) {
        if (value == null) return;
        
        String label = _formatAttributeLabel(key);
        String displayValue;
        
        if (value is bool) {
          displayValue = value ? 'Yes' : 'No';
        } else if (value is List) {
          displayValue = value.join(', ');
        } else if (value is num && (key.toLowerCase().contains('price') || key == 'pricePerNight')) {
          if (key == 'pricePerNight') {
            displayValue = '₹${value.toStringAsFixed(0)}/night';
          } else {
            displayValue = _formatPrice(value);
          }
        } else {
          displayValue = value.toString();
        }
        
        String emoji = _getEmojiForKey(key);
        text.writeln('$emoji *$label:* $displayValue');
      });
      
      text.writeln('');
    }
    
    // Add features if exists
    if (_features.isNotEmpty) {
      text.writeln('✨ *Key Features:*');
      for (var feature in _features) {
        if (feature is Map && feature.containsKey('name')) {
          text.writeln('  • ${feature['name']}');
        }
      }
      text.writeln('');
    }
    
    // Add portfolio if exists
    if (_portfolio.isNotEmpty) {
      text.writeln('📁 *Portfolio:*');
      for (var item in _portfolio) {
        text.writeln('  • ${item['name'] ?? 'Project'}');
        if (item['description'] != null && item['description'].toString().isNotEmpty) {
          text.writeln('    ${item['description']}');
        }
      }
      text.writeln('');
    }
    
    // Add previous events if exists
    if (_previousEvents.isNotEmpty) {
      text.writeln('📅 *Previous Events:*');
      for (var event in _previousEvents) {
        text.writeln('  • ${event['title'] ?? 'Event'}');
        if (event['location'] != null && event['location'].toString().isNotEmpty) {
          text.writeln('    Location: ${event['location']}');
        }
        if (event['eventDate'] != null) {
          try {
            final date = DateTime.parse(event['eventDate']);
            text.writeln('    Date: ${date.day}/${date.month}/${date.year}');
          } catch (e) {}
        }
      }
      text.writeln('');
    }
    
    text.writeln('📝 *Description:*');
    text.writeln(productData?['description'] ?? 'Beautiful property located in prime area.');
    text.writeln('');
    text.writeln('📞 *Contact Details:*');
    
    final agentName = _getAgentName();
    final agentPhone = _getAgentPhone();
    final agentEmail = _getAgentEmail();
    final agentWebsite = _getAgentWebsite();
    
    text.writeln('👤 Agent: $agentName');
    text.writeln('📱 Phone: $agentPhone');
    if (agentEmail != null) text.writeln('📧 Email: $agentEmail');
    if (agentWebsite != null) text.writeln('🌐 Website: $agentWebsite');
    text.writeln('💬 WhatsApp: Available');
    text.writeln('');
    text.writeln('Download our app to view more properties!');
    
    return text.toString();
  }

  String _getEmojiForKey(String key) {
    final Map<String, String> keyEmojis = {
      'bedrooms': '🛏️',
      'bathrooms': '🚿',
      'sqft': '📐',
      'area': '📐',
      'floorNumber': '🔢',
      'totalFloors': '🏢',
      'furnishing': '🪑',
      'parking': '🅿️',
      'maintenance': '💰',
      'balcony': '🪟',
      'lift': '🛗',
      'garden': '🌳',
      'floors': '🏠',
      'privatePool': '🏊',
      'landSize': '🌲',
      'unit': '📏',
      'landType': '🏞️',
      'roadFacing': '🛣️',
      'waterConnection': '💧',
      'waterSource': '💧',
      'electricityAvailable': '⚡',
      'farmHouseBuilt': '🏡',
      'boundaryWall': '🧱',
      'borewell': '🪣',
      'crops': '🌾',
      'clubhouse': '🏘️',
      'gym': '🏋️',
      'security': '🛡️',
      'swimmingPool': '🏊',
      'playArea': '🎪',
      'totalRooms': '🏨',
      'roomTypes': '🚪',
      'pricePerNight': '🌙',
      'restaurantAvailable': '🍽️',
      'wifi': '📶',
      'spa': '💆',
      'roomService': '🛎️',
      'breakfastIncluded': '🍳',
      'checkInTime': '⏰',
      'checkOutTime': '⏱️',
      'businessType': '🏢',
      'industry': '🏭',
      'foundedYear': '📅',
      'services': '🔧',
      'technologies': '💻',
      'clients': '👥',
      'officeSpace': '🏢',
      'meetingRooms': '🚪',
      'remoteWork': '🏠',
      'hiring': '💼',
      'workingHours': '⏰',
      'workingDays': '📆',
      'shopName': '🏪',
      'establishedYear': '📅',
      'certified': '✅',
      'hallmarkAvailable': '✨',
      'exchangeAvailable': '🔄',
      'customDesign': '🎨',
      'repairsService': '🔨',
      'goldRate': '💰',
      'silverRate': '💰',
      'makingCharge': '💵',
      'schemesAvailable': '🎁',
      'openingHours': '⏰',
      'price': '💰',
      'availableFor': '📅',
      'availability': '📅',
      'ownership': '📄',
    };
    
    return keyEmojis[key] ?? '•';
  }

  void _shareProperty() async {
    try {
      String shareText = _generateShareText();
      await Share.share(
        shareText,
        subject: 'Check out this property: ${productData?['name']}',
      );
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar('Error sharing: $e');
      }
    }
  }

  void _showContactOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final agentEmail = _getAgentEmail();
        final agentWebsite = _getAgentWebsite();
        
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone, color: Colors.green, size: 24),
                ),
                title: const Text('Call'),
                subtitle: Text(_getAgentPhone()),
                onTap: () {
                  Navigator.pop(context);
                  _makePhoneCall();
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/whatsapp.png',
                    width: 24,
                    height: 24,
                    errorBuilder: (_, __, ___) {
                      return const Icon(Icons.chat, color: Colors.green, size: 24);
                    },
                  ),
                ),
                title: const Text('WhatsApp'),
                subtitle: Text(_getAgentPhone()),
                onTap: () {
                  Navigator.pop(context);
                  _openWhatsApp();
                },
              ),
              if (agentEmail != null)
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.email, color: Colors.red, size: 24),
                  ),
                  title: const Text('Email'),
                  subtitle: Text(agentEmail),
                  onTap: () {
                    Navigator.pop(context);
                    _sendEmail();
                  },
                ),
              if (agentWebsite != null)
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.language, color: Colors.blue, size: 24),
                  ),
                  title: const Text('Website'),
                  subtitle: Text(agentWebsite),
                  onTap: () {
                    Navigator.pop(context);
                    _openWebsite();
                  },
                ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.blue, size: 24),
                ),
                title: const Text('Share'),
                subtitle: const Text('Share property details'),
                onTap: () {
                  Navigator.pop(context);
                  _shareProperty();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                'Loading property details...',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'Failed to load property',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade800),
                ),
                const SizedBox(height: 8),
                Text(
                  errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _fetchProductDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE33629),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final additionalFeatures = _getAdditionalFeatures();
    final String categoryName = _categoryData?['name']?.toString().toLowerCase() ?? '';
    final agentName = _getAgentName();
    final agentPhone = _getAgentPhone();
    final agentEmail = _getAgentEmail();
    final agentWebsite = _getAgentWebsite();
    
    final bool isLandOrFarm = categoryName == 'land' || categoryName == 'farm';
    final bool isHotel = categoryName == 'hotel';
    final bool isCompany = categoryName == 'companies';
    final bool isGoldShop = categoryName == 'gold shops';

    final String? workingHours = _getWorkingHours();
    final String? workingDays = _getWorkingDays();
    final String? openingHours = _getOpeningHours();

    String aboutTitle = 'Features';
    if (isCompany) {
      aboutTitle = 'About Us';
    } else if (isGoldShop) {
      aboutTitle = 'About Shop';
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _PropertyImageHeader(
                  images: _images,
                  title: productData?['name'],
                  categoryName: _categoryData?['name'],
                  isFavorite: isFavorite,
                  currentIndex: _currentImageIndex,
                  onPageChanged: (index) {
                    setState(() {
                      _currentImageIndex = index;
                    });
                  },
                  onFavoriteTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  onShareTap: _showContactOptions,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              productData?['name'] ?? 'Property',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          if (!isCompany && !isGoldShop && _getFormattedPrice().isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE33629).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _getFormattedPrice(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFE33629),
                                ),
                              ),
                            ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Working Hours/Days for Company/Gold Shop
                      if ((isCompany || isGoldShop) && (workingHours != null || workingDays != null))
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.blue.shade700, size: 20),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (isGoldShop && openingHours != null) ...[
                                      Text(
                                        'Opening Hours: $openingHours',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                      if (workingDays != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          'Working Days: $workingDays',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blue.shade700,
                                          ),
                                        ),
                                      ],
                                    ] else if (workingHours != null) ...[
                                      Text(
                                        'Working Hours: $workingHours',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                      if (workingDays != null) ...[
                                        const SizedBox(height: 4),
                                        Text(
                                          'Working Days: $workingDays',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blue.shade700,
                                          ),
                                        ),
                                      ],
                                    ] else if (workingDays != null) ...[
                                      Text(
                                        'Working Days: $workingDays',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Location with Agent Info
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            // Location
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade600),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    productData?['address'] ?? 'Unknown location',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 8),
                            const Divider(height: 1),
                            const SizedBox(height: 8),
                            
                            // Agent Info
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: _userData != null && _userData!['profileImage'] != null
                                      ? NetworkImage(_userData!['profileImage'])
                                      : null,
                                  child: _userData == null || _userData!['profileImage'] == null
                                      ? const Icon(Icons.person, size: 20)
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        agentName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(Icons.phone, size: 12, color: Colors.grey),
                                          const SizedBox(width: 4),
                                          Text(
                                            agentPhone,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey.shade600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (agentEmail != null) ...[
                                        const SizedBox(height: 2),
                                        Row(
                                          children: [
                                            const Icon(Icons.email, size: 12, color: Colors.grey),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                agentEmail,
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
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Verified',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            // Website link
                            if (agentWebsite != null) ...[
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: _openWebsite,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.language, size: 14, color: Colors.blue),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          agentWebsite,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.blue,
                                            decoration: TextDecoration.underline,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Stats Container
                      if (_attributes != null && !isCompany && !isGoldShop)
                        isHotel
                            ? _buildHotelStats()
                            : isLandOrFarm
                                ? _buildLandStats()
                                : _buildResidentialStats(),

                      if (_attributes != null && !isCompany && !isGoldShop)
                        const SizedBox(height: 20),

                      // Description
                      const _SectionTitle("Description"),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          productData?['description'] ??
                              'Beautiful property located in prime area with modern amenities.',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Features Section
                      if (_features.isNotEmpty) ...[
                        _SectionTitle(isCompany ? "Key Services" : "Key Features"),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _features.map((feature) {
                            if (feature is Map && feature.containsKey('name')) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.orange.shade200),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.star, size: 14, color: Colors.orange.shade700),
                                    const SizedBox(width: 6),
                                    Text(
                                      feature['name'],
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox();
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Portfolio Section
                      if (isCompany && _portfolio.isNotEmpty) ...[
                        const _SectionTitle("Portfolio"),
                        const SizedBox(height: 12),
                        ..._portfolio.map((item) => _buildPortfolioItem(item)).toList(),
                        const SizedBox(height: 20),
                      ],

                      // Previous Events Section
                      if ((isCompany || isHotel || isGoldShop) && _previousEvents.isNotEmpty) ...[
                        const _SectionTitle("Previous Events"),
                        const SizedBox(height: 12),
                        ..._previousEvents.map((event) => _buildEventItem(event)).toList(),
                        const SizedBox(height: 20),
                      ],

                      // Additional Features / About Us
                      if (additionalFeatures.isNotEmpty) ...[
                        _SectionTitle(aboutTitle),
                        const SizedBox(height: 12),
                        // Wrap(
                        //   spacing: 8,
                        //   runSpacing: 8,
                        //   children: additionalFeatures.map((feature) {
                        //     return Container(
                        //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        //       decoration: BoxDecoration(
                        //         color: feature['available'] 
                        //             ? Colors.green.shade50 
                        //             : Colors.grey.shade100,
                        //         borderRadius: BorderRadius.circular(20),
                        //         border: Border.all(
                        //           color: feature['available'] 
                        //               ? Colors.green.shade200 
                        //               : Colors.grey.shade300,
                        //         ),
                        //       ),
                        //       child: Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           Icon(
                        //             feature['icon'],
                        //             size: 14,
                        //             color: feature['available'] 
                        //                 ? Colors.green.shade700 
                        //                 : Colors.grey.shade500,
                        //           ),
                        //           const SizedBox(width: 6),
                        //           Text(
                        //             feature['label'],
                        //             style: TextStyle(
                        //               fontSize: 11,
                        //               color: feature['available'] 
                        //                   ? Colors.green.shade700 
                        //                   : Colors.grey.shade600,
                        //               fontWeight: FontWeight.w500,
                        //             ),
                        //           ),
                        //           if (feature['value'] != null && feature['value'].toString().isNotEmpty) ...[
                        //             const SizedBox(width: 4),
                        //             Container(
                        //               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        //               decoration: BoxDecoration(
                        //                 color: feature['available'] 
                        //                     ? Colors.green.shade100 
                        //                     : Colors.grey.shade200,
                        //                 borderRadius: BorderRadius.circular(12),
                        //               ),
                        //               child: Text(
                        //                 feature['value'],
                        //                 style: TextStyle(
                        //                   fontSize: 10,
                        //                   color: feature['available'] 
                        //                       ? Colors.green.shade800 
                        //                       : Colors.grey.shade700,
                        //                   fontWeight: FontWeight.w600,
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ],
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),

                        // Replace your current Wrap with this improved version
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: additionalFeatures.expand((feature) {
    // Check if the value contains commas and should be split
    final value = feature['value']?.toString() ?? '';
    final shouldSplit = value.contains(',') && 
                       (feature['label'].toLowerCase() == 'services' ||
                        feature['label'].toLowerCase() == 'technologies' ||
                        feature['label'].toLowerCase() == 'room types' ||
                        feature['label'].toLowerCase() == 'amenities' ||
                        feature['label'].toLowerCase() == 'crops' ||
                        feature['label'].toLowerCase() == 'animals');
    
    if (shouldSplit) {
      // Split by comma and create a chip for each item
      final items = value.split(',').map((item) => item.trim()).where((item) => item.isNotEmpty).toList();
      
      return items.map((item) {
        return IntrinsicWidth(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.4, // Max 40% of screen
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: feature['available'] 
                  ? Colors.green.shade50 
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: feature['available'] 
                    ? Colors.green.shade200 
                    : Colors.grey.shade300,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  feature['icon'],
                  size: 14,
                  color: feature['available'] 
                      ? Colors.green.shade700 
                      : Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: 11,
                      color: feature['available'] 
                          ? Colors.green.shade700 
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList();
    } else {
      // Original single chip
      return [
        IntrinsicWidth(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: feature['available'] 
                  ? Colors.green.shade50 
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: feature['available'] 
                    ? Colors.green.shade200 
                    : Colors.grey.shade300,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  feature['icon'],
                  size: 14,
                  color: feature['available'] 
                      ? Colors.green.shade700 
                      : Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    feature['label'],
                    style: TextStyle(
                      fontSize: 11,
                      color: feature['available'] 
                          ? Colors.green.shade700 
                          : Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (value.isNotEmpty) ...[
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: feature['available'] 
                          ? Colors.green.shade100 
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      value.length > 10 ? '${value.substring(0, 10)}...' : value,
                      style: TextStyle(
                        fontSize: 10,
                        color: feature['available'] 
                            ? Colors.green.shade800 
                            : Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),
        )
      ];
    }
  }).toList(),
)
                      ],

                      const SizedBox(height: 20),

                      // Map Section
                      const _SectionTitle("Location on Map"),
                      const SizedBox(height: 10),

                      GestureDetector(
                        onTap: _openMap,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            height: 160,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.map, size: 40, color: Colors.grey.shade400),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Tap to open map',
                                        style: TextStyle(color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 4,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.location_on, size: 14, color: Color(0xFFE33629)),
                                        const SizedBox(width: 4),
                                        Text(
                                          productData?['address']?.toString().split(',').first ?? 'View on Map',
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomActionBar(
              onContactTap: _showContactOptions,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortfolioItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          if (item['logo'] != null && item['logo'].toString().isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item['logo'],
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            )
          else
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.image_not_supported, color: Colors.grey.shade400),
            ),
          
          const SizedBox(width: 12),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] ?? 'Project',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (item['description'] != null && item['description'].toString().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    item['description'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (item['playStoreLink'] != null && item['playStoreLink'].toString().isNotEmpty)
                      _buildLinkIcon(
                        icon: Icons.play_arrow,
                        color: Colors.green,
                        onTap: () => _launchUrl(item['playStoreLink']),
                      ),
                    if (item['appStoreLink'] != null && item['appStoreLink'].toString().isNotEmpty)
                      _buildLinkIcon(
                        icon: Icons.apple,
                        color: Colors.black,
                        onTap: () => _launchUrl(item['appStoreLink']),
                      ),
                    if (item['website'] != null && item['website'].toString().isNotEmpty)
                      _buildLinkIcon(
                        icon: Icons.language,
                        color: Colors.blue,
                        onTap: () => _launchUrl(item['website']),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventItem(Map<String, dynamic> event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          if (event['image'] != null && event['image'].toString().isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                event['image'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            )
          else
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.event, color: Colors.grey.shade400),
            ),
          
          const SizedBox(width: 12),
          
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event['title'] ?? 'Event',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (event['description'] != null && event['description'].toString().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    event['description'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (event['location'] != null && event['location'].toString().isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          event['location'],
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (event['eventDate'] != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(event['eventDate']),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkIcon({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      String urlString = url;
      if (!urlString.startsWith('http://') && !urlString.startsWith('https://')) {
        urlString = 'https://$urlString';
      }
      final uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar('Could not open link');
      }
    }
  }

  String _formatDate(dynamic date) {
    try {
      if (date is String) {
        final parsedDate = DateTime.parse(date);
        return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
      } else if (date is DateTime) {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {}
    return date?.toString() ?? '';
  }

  Widget _buildHotelStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (_attributes!.containsKey('totalRooms'))
            Expanded(
              child: _StatItem(
                icon: Icons.hotel,
                label: 'Total Rooms',
                value: _attributes!['totalRooms'].toString(),
              ),
            ),
          
          if (_attributes!.containsKey('totalRooms') && _attributes!.containsKey('pricePerNight'))
            Container(width: 1, height: 30, color: Colors.grey.shade300),
          
          if (_attributes!.containsKey('pricePerNight'))
            Expanded(
              child: _StatItem(
                icon: Icons.nightlife,
                label: 'Per Night',
                value: '₹${_attributes!['pricePerNight']}',
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLandStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (_attributes!.containsKey('landSize'))
            Expanded(
              child: _StatItem(
                icon: Icons.square_foot,
                label: 'Land Size',
                value: '${_attributes!['landSize']} ${_attributes!['unit'] ?? ''}',
              ),
            ),
          
          if (_attributes!.containsKey('landSize') && _attributes!.containsKey('landType'))
            Container(width: 1, height: 30, color: Colors.grey.shade300),
          
          if (_attributes!.containsKey('landType'))
            Expanded(
              child: _StatItem(
                icon: Icons.landscape,
                label: 'Land Type',
                value: _attributes!['landType'],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildResidentialStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (_attributes!.containsKey('bedrooms'))
            Expanded(
              child: _StatItem(
                icon: Icons.bed_outlined,
                label: 'Bedrooms',
                value: '${_attributes!['bedrooms']} Bed',
              ),
            ),
          
          if (_attributes!.containsKey('bedrooms') && _attributes!.containsKey('bathrooms'))
            Container(width: 1, height: 30, color: Colors.grey.shade300),
          
          if (_attributes!.containsKey('bathrooms'))
            Expanded(
              child: _StatItem(
                icon: Icons.bathtub_outlined,
                label: 'Bathrooms',
                value: '${_attributes!['bathrooms']} Bath',
              ),
            ),
          
          if (_attributes!.containsKey('bathrooms') && _attributes!.containsKey('sqft'))
            Container(width: 1, height: 30, color: Colors.grey.shade300),
          
          if (_attributes!.containsKey('sqft'))
            Expanded(
              child: _StatItem(
                icon: Icons.square_foot,
                label: 'Area',
                value: '${_attributes!['sqft']} sqft',
              ),
            ),
        ],
      ),
    );
  }
}

// ── Property Image Header ─────────────────────────────────────────────────
class _PropertyImageHeader extends StatelessWidget {
  final List<dynamic> images;
  final String? title;
  final String? categoryName;
  final bool isFavorite;
  final int currentIndex;
  final Function(int) onPageChanged;
  final VoidCallback onFavoriteTap;
  final VoidCallback onShareTap;

  const _PropertyImageHeader({
    required this.images,
    required this.title,
    required this.categoryName,
    required this.isFavorite,
    required this.currentIndex,
    required this.onPageChanged,
    required this.onFavoriteTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasImages = images.isNotEmpty;

    return Stack(
      children: [
        // Image Gallery
        SizedBox(
          height: 375,
          width: double.infinity,
          child: Stack(
            children: [
              PageView.builder(
                onPageChanged: onPageChanged,
                itemCount: hasImages ? images.length : 1,
                itemBuilder: (context, index) {
                  final imageUrl = hasImages ? images[index].toString() : null;
                  
                  return ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                    child: imageUrl != null && imageUrl.startsWith('http')
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildPlaceholder();
                            },
                          )
                        : _buildPlaceholder(),
                  );
                },
              ),

              // Image Counter
              if (hasImages && images.length > 1)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${currentIndex + 1}/${images.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              // Category Badge
              if (categoryName != null)
                Positioned(
                  top: 44,
                  left: 14,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      categoryName!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Back Button
        Positioned(
          top: 44,
          left: 14,
          child: _CircleIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
        ),

        // Action Icons
        Positioned(
          top: 44,
          right: 14,
          child: Column(
            children: [
              _CircleIconButton(
                icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                onTap: onFavoriteTap,
              ),
              const SizedBox(height: 12),
              _CircleIconButton(
                icon: Icons.share,
                onTap: onShareTap,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported, size: 50, color: Colors.grey.shade500),
            const SizedBox(height: 8),
            Text(
              'No Image',
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Circle Icon Button ───────────────────────────────────────────────────
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: Colors.black87),
      ),
    );
  }
}

// ── Section Title ────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }
}

// ── Stat Item ────────────────────────────────────────────────────────────
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: const Color(0xFFE33629)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

// ── Bottom Action Bar ─────────────────────────────────────────────────────
class _BottomActionBar extends StatelessWidget {
  final VoidCallback onContactTap;

  const _BottomActionBar({
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Map Button
          Expanded(
            child: GestureDetector(
              onTap: () {}, // Map functionality is elsewhere
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_outlined, size: 18, color: Colors.grey.shade700),
                    const SizedBox(width: 6),
                    const Text(
                      "Map",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Contact Button
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onContactTap,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE33629),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.contact_phone, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      "Contact Agent",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}