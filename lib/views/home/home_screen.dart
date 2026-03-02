// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:product_app/views/Buy/buy_screen.dart';
// // // // // import 'package:product_app/views/Notifications/notification_screen.dart';
// // // // // import 'package:product_app/views/category/category_screen.dart';
// // // // // import 'package:product_app/views/location_screen.dart';
// // // // // import 'package:product_app/views/nearesthouses/nearest_houses.dart';
// // // // // import 'package:product_app/views/sell/sell_category.dart';

// // // // // class HomeScreen extends StatefulWidget {
// // // // //   const HomeScreen({super.key});

// // // // //   @override
// // // // //   State<HomeScreen> createState() => _HomeScreenState();
// // // // // }

// // // // // class _HomeScreenState extends State<HomeScreen> {
// // // // //   List<Map<String, dynamic>> products = [
// // // // //     {
// // // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // // //       "tag": "For Sale",
// // // // //       "title": "Modern Apartment in City Center",
// // // // //       "location": "Kakinada",
// // // // //       "price": "₹25,000",
// // // // //       "bed": "4 Bed",
// // // // //       "bath": "2 Bath",
// // // // //       "area": "7,500 sqft"
// // // // //     },
// // // // //     {
// // // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // // //       "tag": "For Sale",
// // // // //       "title": "Luxury Villa with Pool",
// // // // //       "location": "Kakinada",
// // // // //       "price": "₹7,50,000",
// // // // //       "bed": "4 Bed",
// // // // //       "bath": "2 Bath",
// // // // //       "area": "7,500 sqft"
// // // // //     },
// // // // //     {
// // // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // // //       "tag": "For Sale",
// // // // //       "title": "Cozy 2BHK House",
// // // // //       "location": "Kakinada",
// // // // //       "price": "₹18,000",
// // // // //       "bed": "4 Bed",
// // // // //       "bath": "2 Bath",
// // // // //       "area": "7,500 sqft"
// // // // //     },
// // // // //     {
// // // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // // //       "tag": "For Sale",
// // // // //       "title": "Sea View Apartment",
// // // // //       "location": "Kakinada",
// // // // //       "price": "₹32,000",
// // // // //       "bed": "4 Bed",
// // // // //       "bath": "2 Bath",
// // // // //       "area": "7,500 sqft"
// // // // //     },
// // // // //     {
// // // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // // //       "tag": "For Sale",
// // // // //       "title": "Boutique Hotel Space",
// // // // //       "location": "Kakinada",
// // // // //       "price": "₹1,50,000",
// // // // //       "bed": "4 Bed",
// // // // //       "bath": "2 Bath",
// // // // //       "area": "7,500 sqft"
// // // // //     },
// // // // //   ];

// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       backgroundColor: Colors.white,
// // // // //       appBar: AppBar(
// // // // //         backgroundColor: Colors.white,
// // // // //         elevation: 0,
// // // // //         leading: const Padding(
// // // // //           padding: EdgeInsets.only(left: 10),
// // // // //           child: CircleAvatar(
// // // // //             backgroundImage: AssetImage(
// // // // //                 'lib/assets/403079b6b3230e238d25d0e18c175d870e3223de.png'),
// // // // //           ),
// // // // //         ),
// // // // //         title: const Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             Text('Good Morning',
// // // // //                 style: TextStyle(fontSize: 14, color: Colors.black54)),
// // // // //             Text('PMS',
// // // // //                 style: TextStyle(
// // // // //                     fontSize: 16,
// // // // //                     fontWeight: FontWeight.bold,
// // // // //                     color: Colors.black)),
// // // // //           ],
// // // // //         ),
// // // // //         actions: [
// // // // //           GestureDetector(
// // // // //             onTap: () {
// // // // //               Navigator.push(context,
// // // // //                   MaterialPageRoute(builder: (context) => const LocationScreen()));
// // // // //             },
// // // // //             child: Container(
// // // // //                 width: 40,
// // // // //                 height: 40,
// // // // //                 decoration: BoxDecoration(
// // // // //                     borderRadius: BorderRadius.circular(8),
// // // // //                     border: Border.all(color: Colors.grey)),
// // // // //                 child: const Icon(Icons.location_on, color: Colors.black)),
// // // // //           ),
// // // // //           const SizedBox(width: 16),
// // // // //           GestureDetector(
// // // // //             onTap: () {
// // // // //               Navigator.push(
// // // // //                   context,
// // // // //                   MaterialPageRoute(
// // // // //                       builder: (context) => const NotificationScreen()));
// // // // //             },
// // // // //             child: Container(
// // // // //               width: 40,
// // // // //               height: 40,
// // // // //               decoration: BoxDecoration(
// // // // //                   border: Border.all(color: Colors.grey),
// // // // //                   borderRadius: BorderRadius.circular(8)),
// // // // //               child: Stack(
// // // // //                 children: [
// // // // //                   const Center(
// // // // //                     child: Icon(Icons.notifications_none, color: Colors.black),
// // // // //                   ),
// // // // //                   Positioned(
// // // // //                     right: 8,
// // // // //                     top: 8,
// // // // //                     child: Container(
// // // // //                       width: 8,
// // // // //                       height: 8,
// // // // //                       decoration: const BoxDecoration(
// // // // //                         color: Colors.red,
// // // // //                         shape: BoxShape.circle,
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //           const SizedBox(width: 16),
// // // // //         ],
// // // // //       ),
// // // // //       body: SingleChildScrollView(
// // // // //         padding: const EdgeInsets.symmetric(horizontal: 16),
// // // // //         child: Column(
// // // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // // //           children: [
// // // // //             const SizedBox(height: 12),
// // // // //             Row(
// // // // //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// // // // //               children: [
// // // // //                 Expanded(
// // // // //                   child: TextField(
// // // // //                     decoration: InputDecoration(
// // // // //                       hintText: 'Search',
// // // // //                       prefixIcon: const Icon(Icons.search),
// // // // //                       filled: true,
// // // // //                       fillColor: Colors.white,
// // // // //                       enabledBorder: OutlineInputBorder(
// // // // //                         borderRadius: BorderRadius.circular(30),
// // // // //                         borderSide: const BorderSide(
// // // // //                           color: Color.fromARGB(255, 221, 221, 221),
// // // // //                           width: 2,
// // // // //                         ),
// // // // //                       ),
// // // // //                       focusedBorder: OutlineInputBorder(
// // // // //                         borderRadius: BorderRadius.circular(30),
// // // // //                         borderSide: const BorderSide(
// // // // //                           color: Color.fromARGB(255, 217, 216, 216),
// // // // //                           width: 2,
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //                 const SizedBox(width: 10),
// // // // //                 Container(
// // // // //                   width: 44,
// // // // //                   height: 44,
// // // // //                   decoration: const BoxDecoration(
// // // // //                     shape: BoxShape.circle,
// // // // //                     gradient: LinearGradient(
// // // // //                       colors: [
// // // // //                         Color(0xFF00A8E8),
// // // // //                         Color(0xFF2BBBAD),
// // // // //                       ],
// // // // //                       begin: Alignment.topLeft,
// // // // //                       end: Alignment.bottomRight,
// // // // //                     ),
// // // // //                   ),
// // // // //                   child: const Center(
// // // // //                     child: Icon(
// // // // //                       Icons.tune,
// // // // //                       color: Colors.white,
// // // // //                     ),
// // // // //                   ),
// // // // //                 )
// // // // //               ],
// // // // //             ),
// // // // //             const SizedBox(height: 16),
// // // // //             Row(
// // // // //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // //               children: [
// // // // //                 _choiceChip('Listing', false),
// // // // //                 GestureDetector(
// // // // //                     onTap: () {
// // // // //                       Navigator.push(context,
// // // // //                           MaterialPageRoute(builder: (context) => const BuyScreen()));
// // // // //                     },
// // // // //                     child: _choiceChip('Buy', true)),
// // // // //                 GestureDetector(
// // // // //                     onTap: () {
// // // // //                       Navigator.push(
// // // // //                           context,
// // // // //                           MaterialPageRoute(
// // // // //                               builder: (context) => const SellCategory()));
// // // // //                     },
// // // // //                     child: _choiceChip('Sell', false)),
// // // // //               ],
// // // // //             ),
// // // // //             const SizedBox(height: 20),
// // // // //             // Updated Category Container
// // // // //             Container(
// // // // //               padding: const EdgeInsets.all(16),
// // // // //               decoration: BoxDecoration(
// // // // //                 border: Border.all(color: const Color.fromARGB(255, 191, 190, 190)),
// // // // //                 color: Colors.white,
// // // // //                 borderRadius: BorderRadius.circular(16),
// // // // //                 boxShadow: [
// // // // //                   BoxShadow(
// // // // //                     color: Colors.grey.shade200,
// // // // //                     blurRadius: 10,
// // // // //                     offset: const Offset(0, 4),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               child: Column(
// // // // //                 children: [
// // // // //                   Row(
// // // // //                     children: [
// // // // //                       _categoryIcon('House', Icons.house),
// // // // //                       const SizedBox(width: 12),
// // // // //                       _categoryIcon('Villa', Icons.villa),
// // // // //                       const SizedBox(width: 12),
// // // // //                       _categoryIcon('Apart.', Icons.apartment),
// // // // //                       const SizedBox(width: 12),
// // // // //                       _categoryIcon('Hotel', Icons.hotel),
// // // // //                     ],
// // // // //                   ),
// // // // //                   const SizedBox(height: 16),
// // // // //                   GestureDetector(
// // // // //                     onTap: () {
// // // // //                       Navigator.push(
// // // // //                           context,
// // // // //                           MaterialPageRoute(
// // // // //                               builder: (context) => const CategoryScreen()));
// // // // //                     },
// // // // //                     child: Container(
// // // // //                       padding: const EdgeInsets.symmetric(
// // // // //                           horizontal: 16, vertical: 12),
// // // // //                       decoration: BoxDecoration(
// // // // //                         border: Border.all(color: Colors.grey.shade300),
// // // // //                         borderRadius: BorderRadius.circular(25),
// // // // //                       ),
// // // // //                       child:const Row(
// // // // //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // // //                         children: [
// // // // //                           Text(
// // // // //                             'All Category',
// // // // //                             style: TextStyle(
// // // // //                               fontSize: 14,
// // // // //                               color:  Color.fromARGB(255, 41, 41, 41),
// // // // //                             ),
// // // // //                           ),
// // // // //                           Icon(
// // // // //                             Icons.arrow_forward_ios,
// // // // //                             size: 15,
// // // // //                             color:  Color.fromARGB(255, 0, 0, 0),
// // // // //                           ),
// // // // //                         ],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //             ),
// // // // //             const SizedBox(height: 20),
// // // // //             Row(
// // // // //               children: [
// // // // //                 const Text('Nearest Houses',
// // // // //                     style:
// // // // //                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// // // // //                 const Spacer(),
// // // // //                 GestureDetector(
// // // // //                   onTap: () {
// // // // //                     Navigator.push(
// // // // //                         context,
// // // // //                         MaterialPageRoute(
// // // // //                             builder: (context) => const NearestHouses()));
// // // // //                   },
// // // // //                   child: const Text('See All',
// // // // //                       style: TextStyle(color: Colors.black)),
// // // // //                 ),
// // // // //                 const SizedBox(width: 4),
// // // // //                 const Icon(
// // // // //                   Icons.arrow_forward_ios,
// // // // //                   size: 13,
// // // // //                 )
// // // // //               ],
// // // // //             ),
// // // // //             const SizedBox(height: 10),
// // // // //             ListView.builder(
// // // // //               shrinkWrap: true,
// // // // //               physics: const NeverScrollableScrollPhysics(),
// // // // //               itemCount: products.length,
// // // // //               itemBuilder: (context, index) {
// // // // //                 final house = products[index];
// // // // //                 return Container(
// // // // //                   margin: const EdgeInsets.only(bottom: 16),
// // // // //                   padding: const EdgeInsets.all(8),
// // // // //                   decoration: BoxDecoration(
// // // // //                     border: Border.all(
// // // // //                       color: Colors.grey.shade300,
// // // // //                       width: 1,
// // // // //                     ),
// // // // //                     borderRadius: BorderRadius.circular(12),
// // // // //                   ),
// // // // //                   child: Column(
// // // // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                     children: [
// // // // //                       Stack(
// // // // //                         children: [
// // // // //                           GestureDetector(
// // // // //                             onTap: () {
// // // // //                               Navigator.push(
// // // // //                                   context,
// // // // //                                   MaterialPageRoute(
// // // // //                                       builder: (context) =>
// // // // //                                           const NearestHouses()));
// // // // //                             },
// // // // //                             child: ClipRRect(
// // // // //                               borderRadius: BorderRadius.circular(10),
// // // // //                               child: Image.asset(
// // // // //                                 house['imageUrl'],
// // // // //                                 height: 160,
// // // // //                                 width: double.infinity,
// // // // //                                 fit: BoxFit.cover,
// // // // //                               ),
// // // // //                             ),
// // // // //                           ),
// // // // //                           Positioned(
// // // // //                             top: 8,
// // // // //                             left: 8,
// // // // //                             child: Container(
// // // // //                               padding: const EdgeInsets.symmetric(
// // // // //                                   horizontal: 8, vertical: 4),
// // // // //                               decoration: BoxDecoration(
// // // // //                                 color: Colors.white,
// // // // //                                 borderRadius: BorderRadius.circular(20),
// // // // //                               ),
// // // // //                               child: Text(
// // // // //                                 house['tag'],
// // // // //                                 style: const TextStyle(
// // // // //                                     color: Colors.black, fontSize: 12),
// // // // //                               ),
// // // // //                             ),
// // // // //                           ),
// // // // //                           Positioned(
// // // // //                             top: 8,
// // // // //                             right: 8,
// // // // //                             child: CircleAvatar(
// // // // //                               backgroundColor: Colors.white,
// // // // //                               child: IconButton(
// // // // //                                 icon: const Icon(
// // // // //                                   Icons.favorite_border,
// // // // //                                   color: Colors.black,
// // // // //                                 ),
// // // // //                                 onPressed: () {},
// // // // //                               ),
// // // // //                             ),
// // // // //                           )
// // // // //                         ],
// // // // //                       ),
// // // // //                       const SizedBox(height: 8),
// // // // //                       Text(
// // // // //                         house['title'],
// // // // //                         style: const TextStyle(
// // // // //                           fontWeight: FontWeight.w600,
// // // // //                           fontSize: 15,
// // // // //                         ),
// // // // //                       ),
// // // // //                       const SizedBox(height: 6),
// // // // //                       Row(
// // // // //                         children: [
// // // // //                           _iconText(Icons.bed_outlined, house['bed']),
// // // // //                           const SizedBox(width: 8),
// // // // //                           _iconText(Icons.bathtub_outlined, house['bath']),
// // // // //                           const SizedBox(width: 8),
// // // // //                           _iconText(Icons.square_foot, house['area']),
// // // // //                         ],
// // // // //                       ),
// // // // //                       const SizedBox(height: 6),
// // // // //                       Row(
// // // // //                         children: [
// // // // //                           const Icon(Icons.location_on_outlined, size: 16),
// // // // //                           Text(
// // // // //                             house['location'],
// // // // //                             style: const TextStyle(fontSize: 13),
// // // // //                           )
// // // // //                         ],
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 );
// // // // //               },
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _choiceChip(String label, bool selected) {
// // // // //     return Container(
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
// // // // //       decoration: BoxDecoration(
// // // // //         borderRadius: BorderRadius.circular(12),
// // // // //         border: Border.all(
// // // // //           color: selected ? Colors.transparent : Color(0xFF00A8E8),
// // // // //           width: 1,
// // // // //         ),
// // // // //         gradient: selected
// // // // //             ? const LinearGradient(
// // // // //                 colors: [
// // // // //                   Color(0xFF00A8E8),
// // // // //                   Color(0xFF2BBBAD),
// // // // //                 ],
// // // // //               )
// // // // //             : null,
// // // // //         color: selected ? null : Colors.transparent,
// // // // //       ),
// // // // //       child: Text(
// // // // //         label,
// // // // //         style: TextStyle(
// // // // //           color: selected ? Colors.white : Color(0xFF00A8E8),
// // // // //           fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
// // // // //           fontSize: 14,
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _categoryIcon(String label, IconData icon) {
// // // // //     final bool isHouse = label == "House";

// // // // //     return Expanded(
// // // // //       child: Container(
// // // // //         height: 80,
// // // // //         decoration: BoxDecoration(
// // // // //           borderRadius: BorderRadius.circular(16),
// // // // //           color: isHouse ? null : const Color.fromARGB(255, 243, 243, 243),
// // // // //           gradient: isHouse
// // // // //               ? const LinearGradient(
// // // // //                   colors: [
// // // // //                     Color(0xFF00A8E8),
// // // // //                     Color(0xFF2BBBAD),
// // // // //                   ],
// // // // //                   begin: Alignment.topLeft,
// // // // //                   end: Alignment.bottomRight,
// // // // //                 )
// // // // //               : null,
// // // // //         ),
// // // // //         child: Column(
// // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // //           children: [
// // // // //             CircleAvatar(
// // // // //               radius: 20,
// // // // //               backgroundColor: Colors.white,
// // // // //               child: Icon(
// // // // //                 icon,
// // // // //                 color:
// // // // //                     isHouse ? const Color(0xFF00A8E8) : const Color(0xFF2BBBAD),
// // // // //                 size: 20,
// // // // //               ),
// // // // //             ),
// // // // //             const SizedBox(height: 6),
// // // // //             Text(
// // // // //               label,
// // // // //               style: TextStyle(
// // // // //                 fontSize: 12,
// // // // //                 color: isHouse ? Colors.white : Colors.black,
// // // // //                 fontWeight: FontWeight.w600,
// // // // //               ),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _iconText(IconData icon, String label) {
// // // // //     return Container(
// // // // //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// // // // //       decoration: BoxDecoration(
// // // // //         border: Border.all(color: Colors.grey.shade300),
// // // // //         borderRadius: BorderRadius.circular(16),
// // // // //       ),
// // // // //       child: Row(
// // // // //         children: [
// // // // //           Icon(icon, size: 14),
// // // // //           const SizedBox(width: 4),
// // // // //           Text(label, style: const TextStyle(fontSize: 12)),
// // // // //         ],
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'dart:convert';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'package:product_app/views/Buy/buy_screen.dart';
// // // // import 'package:product_app/views/Notifications/notification_screen.dart';
// // // // import 'package:product_app/views/category/category_screen.dart';
// // // // import 'package:product_app/views/location_screen.dart';
// // // // import 'package:product_app/views/nearesthouses/nearest_houses.dart';
// // // // import 'package:product_app/views/sell/sell_category.dart';
// // // // import 'package:product_app/views/widgets/wishlist_manager.dart';

// // // // class HomeScreen extends StatefulWidget {
// // // //   const HomeScreen({super.key});

// // // //   @override
// // // //   State<HomeScreen> createState() => _HomeScreenState();
// // // // }

// // // // class _HomeScreenState extends State<HomeScreen> {
// // // //   final WishlistManager _wishlistManager = WishlistManager();

// // // //   List<Map<String, dynamic>> categories = [];
// // // //   bool isLoadingCategories = true;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     fetchCategories();
// // // //   }

// // // //   Future<void> fetchCategories() async {
// // // //     try {
// // // //       final response = await http.get(
// // // //         Uri.parse('http://31.97.206.144:9174/api/auth/get/MainCategories'),
// // // //       );

// // // //       print('Response status code for get all categories ${response.statusCode}');
// // // //             print('Response status bodyyyyyyyyyyyy for get all categories ${response.body}');

// // // //       if (response.statusCode == 200) {
// // // //         final data = json.decode(response.body);
// // // //         if (data['success'] == true) {
// // // //           setState(() {
// // // //             categories = List<Map<String, dynamic>>.from(
// // // //               data['categories'].map((category) => {
// // // //                 'id': category['_id'],
// // // //                 'name': category['name'],
// // // //                 'image': category['image'],
// // // //               })
// // // //             );
// // // //             isLoadingCategories = false;
// // // //           });
// // // //         }
// // // //       }
// // // //     } catch (e) {
// // // //       print('Error fetching categories: $e');
// // // //       setState(() {
// // // //         isLoadingCategories = false;
// // // //       });
// // // //     }
// // // //   }

// // // //   List<Map<String, dynamic>> products = [
// // // //     {
// // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // //       "tag": "For Sale",
// // // //       "title": "Modern Apartment in City Center",
// // // //       "location": "Kakinada",
// // // //       "price": "₹25,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft"
// // // //     },
// // // //     {
// // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // //       "tag": "For Sale",
// // // //       "title": "Luxury Villa with Pool",
// // // //       "location": "Kakinada",
// // // //       "price": "₹7,50,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft"
// // // //     },
// // // //     {
// // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // //       "tag": "For Sale",
// // // //       "title": "Cozy 2BHK House",
// // // //       "location": "Kakinada",
// // // //       "price": "₹18,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft"
// // // //     },
// // // //     {
// // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // //       "tag": "For Sale",
// // // //       "title": "Sea View Apartment",
// // // //       "location": "Kakinada",
// // // //       "price": "₹32,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft"
// // // //     },
// // // //     {
// // // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // // //       "tag": "For Sale",
// // // //       "title": "Boutique Hotel Space",
// // // //       "location": "Kakinada",
// // // //       "price": "₹1,50,000",
// // // //       "bed": "4 Bed",
// // // //       "bath": "2 Bath",
// // // //       "area": "7,500 sqft"
// // // //     },
// // // //   ];

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       backgroundColor: Colors.white,
// // // //       appBar: AppBar(
// // // //         backgroundColor: Colors.white,
// // // //         elevation: 0,
// // // //         leading: const Padding(
// // // //           padding: EdgeInsets.only(left: 10),
// // // //           child: CircleAvatar(
// // // //             backgroundImage: AssetImage(
// // // //                 'lib/assets/403079b6b3230e238d25d0e18c175d870e3223de.png'),
// // // //           ),
// // // //         ),
// // // //         title: const Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             Text('Good Morning',
// // // //                 style: TextStyle(fontSize: 14, color: Colors.black54)),
// // // //             Text('PMS',
// // // //                 style: TextStyle(
// // // //                     fontSize: 16,
// // // //                     fontWeight: FontWeight.bold,
// // // //                     color: Colors.black)),
// // // //           ],
// // // //         ),
// // // //         actions: [
// // // //           GestureDetector(
// // // //             onTap: () {
// // // //               Navigator.push(context,
// // // //                   MaterialPageRoute(builder: (context) => const LocationScreen()));
// // // //             },
// // // //             child: Container(
// // // //                 width: 40,
// // // //                 height: 40,
// // // //                 decoration: BoxDecoration(
// // // //                     borderRadius: BorderRadius.circular(8),
// // // //                     border: Border.all(color: Colors.grey)),
// // // //                 child: const Icon(Icons.location_on, color: Colors.black)),
// // // //           ),
// // // //           const SizedBox(width: 16),
// // // //           GestureDetector(
// // // //             onTap: () {
// // // //               Navigator.push(
// // // //                   context,
// // // //                   MaterialPageRoute(
// // // //                       builder: (context) => const NotificationScreen()));
// // // //             },
// // // //             child: Container(
// // // //               width: 40,
// // // //               height: 40,
// // // //               decoration: BoxDecoration(
// // // //                   border: Border.all(color: Colors.grey),
// // // //                   borderRadius: BorderRadius.circular(8)),
// // // //               child: Stack(
// // // //                 children: [
// // // //                   const Center(
// // // //                     child: Icon(Icons.notifications_none, color: Colors.black),
// // // //                   ),
// // // //                   Positioned(
// // // //                     right: 8,
// // // //                     top: 8,
// // // //                     child: Container(
// // // //                       width: 8,
// // // //                       height: 8,
// // // //                       decoration: const BoxDecoration(
// // // //                         color: Colors.red,
// // // //                         shape: BoxShape.circle,
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(width: 16),
// // // //         ],
// // // //       ),
// // // //       body: SingleChildScrollView(
// // // //         padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //         child: Column(
// // // //           crossAxisAlignment: CrossAxisAlignment.start,
// // // //           children: [
// // // //             const SizedBox(height: 12),
// // // //             Row(
// // // //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// // // //               children: [
// // // //                 Expanded(
// // // //                   child: TextField(
// // // //                     decoration: InputDecoration(
// // // //                       hintText: 'Search',
// // // //                       prefixIcon: const Icon(Icons.search),
// // // //                       filled: true,
// // // //                       fillColor: Colors.white,
// // // //                       enabledBorder: OutlineInputBorder(
// // // //                         borderRadius: BorderRadius.circular(30),
// // // //                         borderSide: const BorderSide(
// // // //                           color: Color.fromARGB(255, 221, 221, 221),
// // // //                           width: 2,
// // // //                         ),
// // // //                       ),
// // // //                       focusedBorder: OutlineInputBorder(
// // // //                         borderRadius: BorderRadius.circular(30),
// // // //                         borderSide: const BorderSide(
// // // //                           color: Color.fromARGB(255, 217, 216, 216),
// // // //                           width: 2,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //                 const SizedBox(width: 10),
// // // //                 Container(
// // // //                   width: 44,
// // // //                   height: 44,
// // // //                   decoration: const BoxDecoration(
// // // //                     shape: BoxShape.circle,
// // // //                     gradient: LinearGradient(
// // // //                       colors: [
// // // //                         Color(0xFF00A8E8),
// // // //                         Color(0xFF2BBBAD),
// // // //                       ],
// // // //                       begin: Alignment.topLeft,
// // // //                       end: Alignment.bottomRight,
// // // //                     ),
// // // //                   ),
// // // //                   child: const Center(
// // // //                     child: Icon(
// // // //                       Icons.tune,
// // // //                       color: Colors.white,
// // // //                     ),
// // // //                   ),
// // // //                 )
// // // //               ],
// // // //             ),
// // // //             const SizedBox(height: 16),
// // // //             Row(
// // // //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // //               children: [
// // // //                 _choiceChip('Listing', false),
// // // //                 GestureDetector(
// // // //                     onTap: () {
// // // //                       Navigator.push(context,
// // // //                           MaterialPageRoute(builder: (context) => const BuyScreen()));
// // // //                     },
// // // //                     child: _choiceChip('Buy', true)),
// // // //                 GestureDetector(
// // // //                     onTap: () {
// // // //                       Navigator.push(
// // // //                           context,
// // // //                           MaterialPageRoute(
// // // //                               builder: (context) => const SellCategory()));
// // // //                     },
// // // //                     child: _choiceChip('Sell', false)),
// // // //               ],
// // // //             ),
// // // //             const SizedBox(height: 20),
// // // //             Container(
// // // //               padding: const EdgeInsets.all(16),
// // // //               decoration: BoxDecoration(
// // // //                 border: Border.all(color: const Color.fromARGB(255, 191, 190, 190)),
// // // //                 color: Colors.white,
// // // //                 borderRadius: BorderRadius.circular(16),
// // // //                 boxShadow: [
// // // //                   BoxShadow(
// // // //                     color: Colors.grey.shade200,
// // // //                     blurRadius: 10,
// // // //                     offset: const Offset(0, 4),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               child: Column(
// // // //                 children: [
// // // //                       isLoadingCategories
// // // //           ? const Center(
// // // //               child: Padding(
// // // //                 padding: EdgeInsets.all(20.0),
// // // //                 child: CircularProgressIndicator(),
// // // //               ),
// // // //             )
// // // //           : SingleChildScrollView(
// // // //               scrollDirection: Axis.horizontal,
// // // //               child: Row(
// // // //                 children: categories.take(4).map((category) {
// // // //                   return Padding(
// // // //                     padding: const EdgeInsets.only(right: 12),
// // // //                     child: _categoryIconFromApi(
// // // //                       category['name'],
// // // //                       category['image'],
// // // //                     ),
// // // //                   );
// // // //                 }).toList(),
// // // //               ),
// // // //             ),
// // // //                   // Row(
// // // //                   //   children: [
// // // //                   //     _categoryIcon('House', Icons.house),
// // // //                   //     const SizedBox(width: 12),
// // // //                   //     _categoryIcon('Villa', Icons.villa),
// // // //                   //     const SizedBox(width: 12),
// // // //                   //     _categoryIcon('Apart.', Icons.apartment),
// // // //                   //     const SizedBox(width: 12),
// // // //                   //     _categoryIcon('Hotel', Icons.hotel),
// // // //                   //   ],
// // // //                   // ),
// // // //                   const SizedBox(height: 16),
// // // //                   GestureDetector(
// // // //                     onTap: () {
// // // //                       Navigator.push(
// // // //                           context,
// // // //                           MaterialPageRoute(
// // // //                               builder: (context) => const CategoryScreen()));
// // // //                     },
// // // //                     child: Container(
// // // //                       padding: const EdgeInsets.symmetric(
// // // //                           horizontal: 16, vertical: 12),
// // // //                       decoration: BoxDecoration(
// // // //                         border: Border.all(color: Colors.grey.shade300),
// // // //                         borderRadius: BorderRadius.circular(25),
// // // //                       ),
// // // //                       child:const Row(
// // // //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //                         children: [
// // // //                           Text(
// // // //                             'All Category',
// // // //                             style: TextStyle(
// // // //                               fontSize: 14,
// // // //                               color:  Color.fromARGB(255, 41, 41, 41),
// // // //                             ),
// // // //                           ),
// // // //                           Icon(
// // // //                             Icons.arrow_forward_ios,
// // // //                             size: 15,
// // // //                             color:  Color.fromARGB(255, 0, 0, 0),
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     ),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //             const SizedBox(height: 20),
// // // //             Row(
// // // //               children: [
// // // //                 const Text('Nearest Houses',
// // // //                     style:
// // // //                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// // // //                 const Spacer(),
// // // //                 GestureDetector(
// // // //                   onTap: () {
// // // //                     Navigator.push(
// // // //                         context,
// // // //                         MaterialPageRoute(
// // // //                             builder: (context) => const NearestHouses()));
// // // //                   },
// // // //                   child: const Text('See All',
// // // //                       style: TextStyle(color: Colors.black)),
// // // //                 ),
// // // //                 const SizedBox(width: 4),
// // // //                 const Icon(
// // // //                   Icons.arrow_forward_ios,
// // // //                   size: 13,
// // // //                 )
// // // //               ],
// // // //             ),
// // // //             const SizedBox(height: 10),
// // // //             ListView.builder(
// // // //               shrinkWrap: true,
// // // //               physics: const NeverScrollableScrollPhysics(),
// // // //               itemCount: products.length,
// // // //               itemBuilder: (context, index) {
// // // //                 final house = products[index];
// // // //                 return AnimatedBuilder(
// // // //                   animation: _wishlistManager,
// // // //                   builder: (context, child) {
// // // //                     final isInWishlist = _wishlistManager.isInWishlist(house['title']);

// // // //                     return Container(
// // // //                       margin: const EdgeInsets.only(bottom: 16),
// // // //                       padding: const EdgeInsets.all(8),
// // // //                       decoration: BoxDecoration(
// // // //                         border: Border.all(
// // // //                           color: Colors.grey.shade300,
// // // //                           width: 1,
// // // //                         ),
// // // //                         borderRadius: BorderRadius.circular(12),
// // // //                       ),
// // // //                       child: Column(
// // // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // // //                         children: [
// // // //                           Stack(
// // // //                             children: [
// // // //                               GestureDetector(
// // // //                                 onTap: () {
// // // //                                   Navigator.push(
// // // //                                       context,
// // // //                                       MaterialPageRoute(
// // // //                                           builder: (context) =>
// // // //                                               const NearestHouses()));
// // // //                                 },
// // // //                                 child: ClipRRect(
// // // //                                   borderRadius: BorderRadius.circular(10),
// // // //                                   child: Image.asset(
// // // //                                     house['imageUrl'],
// // // //                                     height: 160,
// // // //                                     width: double.infinity,
// // // //                                     fit: BoxFit.cover,
// // // //                                   ),
// // // //                                 ),
// // // //                               ),
// // // //                               Positioned(
// // // //                                 top: 8,
// // // //                                 left: 8,
// // // //                                 child: Container(
// // // //                                   padding: const EdgeInsets.symmetric(
// // // //                                       horizontal: 8, vertical: 4),
// // // //                                   decoration: BoxDecoration(
// // // //                                     color: Colors.white,
// // // //                                     borderRadius: BorderRadius.circular(20),
// // // //                                   ),
// // // //                                   child: Text(
// // // //                                     house['tag'],
// // // //                                     style: const TextStyle(
// // // //                                         color: Colors.black, fontSize: 12),
// // // //                                   ),
// // // //                                 ),
// // // //                               ),
// // // //                               Positioned(
// // // //                                 top: 8,
// // // //                                 right: 8,
// // // //                                 child: CircleAvatar(
// // // //                                   backgroundColor: Colors.white,
// // // //                                   child: IconButton(
// // // //                                     icon: Icon(
// // // //                                       isInWishlist ? Icons.favorite : Icons.favorite_border,
// // // //                                       color: isInWishlist ? Colors.red : Colors.black,
// // // //                                     ),
// // // //                                     onPressed: () {
// // // //                                       _wishlistManager.toggleWishlist(house);
// // // //                                       ScaffoldMessenger.of(context).showSnackBar(
// // // //                                         SnackBar(
// // // //                                           backgroundColor: Colors.green,
// // // //                                           content: Text(
// // // //                                             isInWishlist
// // // //                                               ? 'Removed from wishlist'
// // // //                                               : 'Added to wishlist'
// // // //                                           ),
// // // //                                           duration: const Duration(seconds: 1),
// // // //                                           behavior: SnackBarBehavior.floating,
// // // //                                         ),
// // // //                                       );
// // // //                                     },
// // // //                                   ),
// // // //                                 ),
// // // //                               )
// // // //                             ],
// // // //                           ),
// // // //                           const SizedBox(height: 8),
// // // //                           Text(
// // // //                             house['title'],
// // // //                             style: const TextStyle(
// // // //                               fontWeight: FontWeight.w600,
// // // //                               fontSize: 15,
// // // //                             ),
// // // //                           ),
// // // //                           const SizedBox(height: 6),
// // // //                           Row(
// // // //                             children: [
// // // //                               _iconText(Icons.bed_outlined, house['bed']),
// // // //                               const SizedBox(width: 8),
// // // //                               _iconText(Icons.bathtub_outlined, house['bath']),
// // // //                               const SizedBox(width: 8),
// // // //                               _iconText(Icons.square_foot, house['area']),
// // // //                             ],
// // // //                           ),
// // // //                           const SizedBox(height: 6),
// // // //                           Row(
// // // //                             children: [
// // // //                               const Icon(Icons.location_on_outlined, size: 16),
// // // //                               Text(
// // // //                                 house['location'],
// // // //                                 style: const TextStyle(fontSize: 13),
// // // //                               )
// // // //                             ],
// // // //                           ),
// // // //                         ],
// // // //                       ),
// // // //                     );
// // // //                   },
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _categoryIconFromApi(String label, String imageUrl) {
// // // //   final bool isFirst = categories.isNotEmpty && categories[0]['name'] == label;

// // // //   return Container(
// // // //     width: 80,
// // // //     height: 80,
// // // //     decoration: BoxDecoration(
// // // //       borderRadius: BorderRadius.circular(16),
// // // //       color: isFirst ? null : const Color.fromARGB(255, 243, 243, 243),
// // // //       gradient: isFirst
// // // //           ? const LinearGradient(
// // // //               colors: [
// // // //                 Color(0xFF00A8E8),
// // // //                 Color(0xFF2BBBAD),
// // // //               ],
// // // //               begin: Alignment.topLeft,
// // // //               end: Alignment.bottomRight,
// // // //             )
// // // //           : null,
// // // //     ),
// // // //     child: Column(
// // // //       mainAxisAlignment: MainAxisAlignment.center,
// // // //       children: [
// // // //         CircleAvatar(
// // // //           radius: 20,
// // // //           backgroundColor: Colors.white,
// // // //           child: ClipOval(
// // // //             child: Image.network(
// // // //               imageUrl,
// // // //               width: 20,
// // // //               height: 20,
// // // //               fit: BoxFit.cover,
// // // //               errorBuilder: (context, error, stackTrace) {
// // // //                 return const Icon(
// // // //                   Icons.category,
// // // //                   size: 20,
// // // //                   color: Color(0xFF00A8E8),
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ),
// // // //         ),
// // // //         const SizedBox(height: 6),
// // // //         Text(
// // // //           label.length > 7 ? '${label.substring(0, 7)}.' : label,
// // // //           style: TextStyle(
// // // //             fontSize: 12,
// // // //             color: isFirst ? Colors.white : Colors.black,
// // // //             fontWeight: FontWeight.w600,
// // // //           ),
// // // //           overflow: TextOverflow.ellipsis,
// // // //         ),
// // // //       ],
// // // //     ),
// // // //   );
// // // // }

// // // //   Widget _choiceChip(String label, bool selected) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
// // // //       decoration: BoxDecoration(
// // // //         borderRadius: BorderRadius.circular(12),
// // // //         border: Border.all(
// // // //           color: selected ? Colors.transparent : Color(0xFF00A8E8),
// // // //           width: 1,
// // // //         ),
// // // //         gradient: selected
// // // //             ? const LinearGradient(
// // // //                 colors: [
// // // //                   Color(0xFF00A8E8),
// // // //                   Color(0xFF2BBBAD),
// // // //                 ],
// // // //               )
// // // //             : null,
// // // //         color: selected ? null : Colors.transparent,
// // // //       ),
// // // //       child: Text(
// // // //         label,
// // // //         style: TextStyle(
// // // //           color: selected ? Colors.white : Color(0xFF00A8E8),
// // // //           fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
// // // //           fontSize: 14,
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _categoryIcon(String label, IconData icon) {
// // // //     final bool isHouse = label == "House";

// // // //     return Expanded(
// // // //       child: Container(
// // // //         height: 80,
// // // //         decoration: BoxDecoration(
// // // //           borderRadius: BorderRadius.circular(16),
// // // //           color: isHouse ? null : const Color.fromARGB(255, 243, 243, 243),
// // // //           gradient: isHouse
// // // //               ? const LinearGradient(
// // // //                   colors: [
// // // //                     Color(0xFF00A8E8),
// // // //                     Color(0xFF2BBBAD),
// // // //                   ],
// // // //                   begin: Alignment.topLeft,
// // // //                   end: Alignment.bottomRight,
// // // //                 )
// // // //               : null,
// // // //         ),
// // // //         child: Column(
// // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // //           children: [
// // // //             CircleAvatar(
// // // //               radius: 20,
// // // //               backgroundColor: Colors.white,
// // // //               child: Icon(
// // // //                 icon,
// // // //                 color:
// // // //                     isHouse ? const Color(0xFF00A8E8) : const Color(0xFF2BBBAD),
// // // //                 size: 20,
// // // //               ),
// // // //             ),
// // // //             const SizedBox(height: 6),
// // // //             Text(
// // // //               label,
// // // //               style: TextStyle(
// // // //                 fontSize: 12,
// // // //                 color: isHouse ? Colors.white : Colors.black,
// // // //                 fontWeight: FontWeight.w600,
// // // //               ),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _iconText(IconData icon, String label) {
// // // //     return Container(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// // // //       decoration: BoxDecoration(
// // // //         border: Border.all(color: Colors.grey.shade300),
// // // //         borderRadius: BorderRadius.circular(16),
// // // //       ),
// // // //       child: Row(
// // // //         children: [
// // // //           Icon(icon, size: 14),
// // // //           const SizedBox(width: 4),
// // // //           Text(label, style: const TextStyle(fontSize: 12)),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:product_app/Provider/location/location_provider.dart';
// // // import 'package:product_app/helper/helper_function.dart';
// // // import 'package:product_app/views/Buy/buy_screen.dart';
// // // import 'package:product_app/views/Notifications/notification_screen.dart';
// // // import 'package:product_app/views/category/category_screen.dart';
// // // import 'package:product_app/views/location/location_screen.dart';
// // // import 'package:product_app/views/nearesthouses/nearest_houses.dart';
// // // import 'package:product_app/views/sell/sell_category.dart';
// // // import 'package:product_app/views/widgets/wishlist_manager.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:geocoding/geocoding.dart' as geocoding;

// // // class HomeScreen extends StatefulWidget {
// // //   const HomeScreen({super.key});

// // //   @override
// // //   State<HomeScreen> createState() => _HomeScreenState();
// // // }

// // // class _HomeScreenState extends State<HomeScreen> {
// // //   final WishlistManager _wishlistManager = WishlistManager();

// // //   List<Map<String, dynamic>> categories = [];
// // //   bool isLoadingCategories = true;
// // //   String? currentAddress;
// // //   bool isLoadingAddress = false;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     fetchCategories();
// // //     _loadCurrentLocation();
// // //   }

// // //   Future<void> _loadCurrentLocation() async {
// // //     setState(() {
// // //       isLoadingAddress = true;
// // //     });

// // //     try {
// // //       final locationProvider =
// // //           Provider.of<LocationProvider>(context, listen: false);

// // //       // Check if location is already available
// // //       if (locationProvider.latitude != null &&
// // //           locationProvider.longitude != null) {
// // //         await _getAddressFromCoordinates(
// // //           locationProvider.latitude!,
// // //           locationProvider.longitude!,
// // //         );
// // //       }
// // //     } catch (e) {
// // //       print('Error loading location: $e');
// // //     } finally {
// // //       setState(() {
// // //         isLoadingAddress = false;
// // //       });
// // //     }
// // //   }

// // //   Future<void> _getAddressFromCoordinates(
// // //       double latitude, double longitude) async {
// // //     try {
// // //       List<geocoding.Placemark> placemarks =
// // //           await geocoding.placemarkFromCoordinates(
// // //         latitude,
// // //         longitude,
// // //       );

// // //       if (placemarks.isNotEmpty) {
// // //         final place = placemarks.first;
// // //         setState(() {
// // //           currentAddress = [
// // //             place.locality,
// // //             place.administrativeArea,
// // //           ].where((e) => e != null && e.isNotEmpty).take(2).join(', ');
// // //         });
// // //       }
// // //     } catch (e) {
// // //       print('Error getting address: $e');
// // //       setState(() {
// // //         currentAddress = 'Location unavailable';
// // //       });
// // //     }
// // //   }

// // //   Future<void> _handleLocationUpdate() async {
// // //     final userId = SharedPrefHelper.getUserId();
// // //     if (userId == null) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text('User not logged in')),
// // //       );
// // //       return;
// // //     }

// // //     final result = await Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// // //           builder: (context) => LocationFetchScreen(
// // //                 userId: userId,
// // //               )),
// // //     );

// // //     if (result != null && result is Map<String, dynamic>) {
// // //       setState(() {
// // //         currentAddress = result['address'] as String?;
// // //       });

// // //       // // Update location provider
// // //       // final locationProvider = Provider.of<LocationProvider>(context, listen: false);
// // //       // locationProvider.latitude = result['latitude'] as double?;
// // //       // locationProvider.longitude = result['longitude'] as double?;

// // //       final locationProvider =
// // //           Provider.of<LocationProvider>(context, listen: false);

// // //       locationProvider.setManualLocation(
// // //         latitude: result['latitude'] as double,
// // //         longitude: result['longitude'] as double,
// // //       );
// // //     }
// // //   }

// // //   Future<void> fetchCategories() async {
// // //     try {
// // //       final response = await http.get(
// // //         Uri.parse('http://31.97.206.144:9174/api/auth/get/MainCategories'),
// // //       );

// // //       print(
// // //           'Response status code for get all categories ${response.statusCode}');
// // //       print(
// // //           'Response status bodyyyyyyyyyyyy for get all categories ${response.body}');

// // //       if (response.statusCode == 200) {
// // //         final data = json.decode(response.body);
// // //         if (data['success'] == true) {
// // //           setState(() {
// // //             categories = List<Map<String, dynamic>>.from(
// // //                 data['categories'].map((category) => {
// // //                       'id': category['_id'],
// // //                       'name': category['name'],
// // //                       'image': category['image'],
// // //                     }));
// // //             isLoadingCategories = false;
// // //           });
// // //         }
// // //       }
// // //     } catch (e) {
// // //       print('Error fetching categories: $e');
// // //       setState(() {
// // //         isLoadingCategories = false;
// // //       });
// // //     }
// // //   }

// // //   List<Map<String, dynamic>> products = [
// // //     {
// // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // //       "tag": "For Sale",
// // //       "title": "Modern Apartment in City Center",
// // //       "location": "Kakinada",
// // //       "price": "₹25,000",
// // //       "bed": "4 Bed",
// // //       "bath": "2 Bath",
// // //       "area": "7,500 sqft"
// // //     },
// // //     {
// // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // //       "tag": "For Sale",
// // //       "title": "Luxury Villa with Pool",
// // //       "location": "Kakinada",
// // //       "price": "₹7,50,000",
// // //       "bed": "4 Bed",
// // //       "bath": "2 Bath",
// // //       "area": "7,500 sqft"
// // //     },
// // //     {
// // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // //       "tag": "For Sale",
// // //       "title": "Cozy 2BHK House",
// // //       "location": "Kakinada",
// // //       "price": "₹18,000",
// // //       "bed": "4 Bed",
// // //       "bath": "2 Bath",
// // //       "area": "7,500 sqft"
// // //     },
// // //     {
// // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // //       "tag": "For Sale",
// // //       "title": "Sea View Apartment",
// // //       "location": "Kakinada",
// // //       "price": "₹32,000",
// // //       "bed": "4 Bed",
// // //       "bath": "2 Bath",
// // //       "area": "7,500 sqft"
// // //     },
// // //     {
// // //       "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// // //       "tag": "For Sale",
// // //       "title": "Boutique Hotel Space",
// // //       "location": "Kakinada",
// // //       "price": "₹1,50,000",
// // //       "bed": "4 Bed",
// // //       "bath": "2 Bath",
// // //       "area": "7,500 sqft"
// // //     },
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.white,
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         leading: const Padding(
// // //           padding: EdgeInsets.only(left: 10),
// // //           child: CircleAvatar(
// // //             backgroundImage: AssetImage(
// // //                 'lib/assets/403079b6b3230e238d25d0e18c175d870e3223de.png'),
// // //           ),
// // //         ),
// // //         title: const Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             Text('Good Morning',
// // //                 style: TextStyle(fontSize: 14, color: Colors.black54)),
// // //             Text('PMS',
// // //                 style: TextStyle(
// // //                     fontSize: 16,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.black)),
// // //           ],
// // //         ),
// // //         actions: [
// // //           GestureDetector(
// // //             onTap: _handleLocationUpdate,
// // //             child: Container(
// // //                 width: 40,
// // //                 height: 40,
// // //                 decoration: BoxDecoration(
// // //                     borderRadius: BorderRadius.circular(8),
// // //                     border: Border.all(color: Colors.grey)),
// // //                 child: const Icon(Icons.location_on, color: Colors.black)),
// // //           ),
// // //           const SizedBox(width: 16),
// // //           GestureDetector(
// // //             onTap: () {
// // //               Navigator.push(
// // //                   context,
// // //                   MaterialPageRoute(
// // //                       builder: (context) => const NotificationScreen()));
// // //             },
// // //             child: Container(
// // //               width: 40,
// // //               height: 40,
// // //               decoration: BoxDecoration(
// // //                   border: Border.all(color: Colors.grey),
// // //                   borderRadius: BorderRadius.circular(8)),
// // //               child: Stack(
// // //                 children: [
// // //                   const Center(
// // //                     child: Icon(Icons.notifications_none, color: Colors.black),
// // //                   ),
// // //                   Positioned(
// // //                     right: 8,
// // //                     top: 8,
// // //                     child: Container(
// // //                       width: 8,
// // //                       height: 8,
// // //                       decoration: const BoxDecoration(
// // //                         color: Colors.red,
// // //                         shape: BoxShape.circle,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(width: 16),
// // //         ],
// // //       ),
// // //       body: SingleChildScrollView(
// // //         padding: const EdgeInsets.symmetric(horizontal: 16),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             const SizedBox(height: 12),

// // //             // Location Display Container
// // //             _buildLocationContainer(),

// // //             const SizedBox(height: 16),

// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// // //               children: [
// // //                 Expanded(
// // //                   child: TextField(
// // //                     decoration: InputDecoration(
// // //                       hintText: 'Search',
// // //                       prefixIcon: const Icon(Icons.search),
// // //                       filled: true,
// // //                       fillColor: Colors.white,
// // //                       enabledBorder: OutlineInputBorder(
// // //                         borderRadius: BorderRadius.circular(30),
// // //                         borderSide: const BorderSide(
// // //                           color: Color.fromARGB(255, 221, 221, 221),
// // //                           width: 2,
// // //                         ),
// // //                       ),
// // //                       focusedBorder: OutlineInputBorder(
// // //                         borderRadius: BorderRadius.circular(30),
// // //                         borderSide: const BorderSide(
// // //                           color: Color.fromARGB(255, 217, 216, 216),
// // //                           width: 2,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 10),
// // //                 Container(
// // //                   width: 44,
// // //                   height: 44,
// // //                   decoration: const BoxDecoration(
// // //                     shape: BoxShape.circle,
// // //                     gradient: LinearGradient(
// // //                       colors: [
// // //                         Color(0xFF00A8E8),
// // //                         Color(0xFF2BBBAD),
// // //                       ],
// // //                       begin: Alignment.topLeft,
// // //                       end: Alignment.bottomRight,
// // //                     ),
// // //                   ),
// // //                   child: const Center(
// // //                     child: Icon(
// // //                       Icons.tune,
// // //                       color: Colors.white,
// // //                     ),
// // //                   ),
// // //                 )
// // //               ],
// // //             ),
// // //             const SizedBox(height: 16),
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //               children: [
// // //                 _choiceChip('Listing', false),
// // //                 GestureDetector(
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                               builder: (context) => const BuyScreen()));
// // //                     },
// // //                     child: _choiceChip('Buy', true)),
// // //                 GestureDetector(
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                               builder: (context) => const SellCategory()));
// // //                     },
// // //                     child: _choiceChip('Sell', false)),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 20),
// // //             Container(
// // //               padding: const EdgeInsets.all(16),
// // //               decoration: BoxDecoration(
// // //                 border:
// // //                     Border.all(color: const Color.fromARGB(255, 191, 190, 190)),
// // //                 color: Colors.white,
// // //                 borderRadius: BorderRadius.circular(16),
// // //                 boxShadow: [
// // //                   BoxShadow(
// // //                     color: Colors.grey.shade200,
// // //                     blurRadius: 10,
// // //                     offset: const Offset(0, 4),
// // //                   ),
// // //                 ],
// // //               ),
// // //               child: Column(
// // //                 children: [
// // //                   isLoadingCategories
// // //                       ? const Center(
// // //                           child: Padding(
// // //                             padding: EdgeInsets.all(20.0),
// // //                             child: CircularProgressIndicator(),
// // //                           ),
// // //                         )
// // //                       : SingleChildScrollView(
// // //                           scrollDirection: Axis.horizontal,
// // //                           child: Row(
// // //                             children: categories.take(4).map((category) {
// // //                               return Padding(
// // //                                 padding: const EdgeInsets.only(right: 12),
// // //                                 child: _categoryIconFromApi(
// // //                                   category['name'],
// // //                                   category['image'],
// // //                                 ),
// // //                               );
// // //                             }).toList(),
// // //                           ),
// // //                         ),
// // //                   const SizedBox(height: 16),
// // //                   GestureDetector(
// // //                     onTap: () {
// // //                       Navigator.push(
// // //                           context,
// // //                           MaterialPageRoute(
// // //                               builder: (context) => const CategoryScreen()));
// // //                     },
// // //                     child: Container(
// // //                       padding: const EdgeInsets.symmetric(
// // //                           horizontal: 16, vertical: 12),
// // //                       decoration: BoxDecoration(
// // //                         border: Border.all(color: Colors.grey.shade300),
// // //                         borderRadius: BorderRadius.circular(25),
// // //                       ),
// // //                       child: const Row(
// // //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                         children: [
// // //                           Text(
// // //                             'All Category',
// // //                             style: TextStyle(
// // //                               fontSize: 14,
// // //                               color: Color.fromARGB(255, 41, 41, 41),
// // //                             ),
// // //                           ),
// // //                           Icon(
// // //                             Icons.arrow_forward_ios,
// // //                             size: 15,
// // //                             color: Color.fromARGB(255, 0, 0, 0),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //             const SizedBox(height: 20),
// // //             Row(
// // //               children: [
// // //                 const Text('Nearest Houses',
// // //                     style:
// // //                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// // //                 const Spacer(),
// // //                 GestureDetector(
// // //                   onTap: () {
// // //                     Navigator.push(
// // //                         context,
// // //                         MaterialPageRoute(
// // //                             builder: (context) => const NearestHouses()));
// // //                   },
// // //                   child: const Text('See All',
// // //                       style: TextStyle(color: Colors.black)),
// // //                 ),
// // //                 const SizedBox(width: 4),
// // //                 const Icon(
// // //                   Icons.arrow_forward_ios,
// // //                   size: 13,
// // //                 )
// // //               ],
// // //             ),
// // //             const SizedBox(height: 10),
// // //             ListView.builder(
// // //               shrinkWrap: true,
// // //               physics: const NeverScrollableScrollPhysics(),
// // //               itemCount: products.length,
// // //               itemBuilder: (context, index) {
// // //                 final house = products[index];
// // //                 return AnimatedBuilder(
// // //                   animation: _wishlistManager,
// // //                   builder: (context, child) {
// // //                     final isInWishlist =
// // //                         _wishlistManager.isInWishlist(house['title']);

// // //                     return Container(
// // //                       margin: const EdgeInsets.only(bottom: 16),
// // //                       padding: const EdgeInsets.all(8),
// // //                       decoration: BoxDecoration(
// // //                         border: Border.all(
// // //                           color: Colors.grey.shade300,
// // //                           width: 1,
// // //                         ),
// // //                         borderRadius: BorderRadius.circular(12),
// // //                       ),
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           Stack(
// // //                             children: [
// // //                               GestureDetector(
// // //                                 onTap: () {
// // //                                   Navigator.push(
// // //                                       context,
// // //                                       MaterialPageRoute(
// // //                                           builder: (context) =>
// // //                                               const NearestHouses()));
// // //                                 },
// // //                                 child: ClipRRect(
// // //                                   borderRadius: BorderRadius.circular(10),
// // //                                   child: Image.asset(
// // //                                     house['imageUrl'],
// // //                                     height: 160,
// // //                                     width: double.infinity,
// // //                                     fit: BoxFit.cover,
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                               Positioned(
// // //                                 top: 8,
// // //                                 left: 8,
// // //                                 child: Container(
// // //                                   padding: const EdgeInsets.symmetric(
// // //                                       horizontal: 8, vertical: 4),
// // //                                   decoration: BoxDecoration(
// // //                                     color: Colors.white,
// // //                                     borderRadius: BorderRadius.circular(20),
// // //                                   ),
// // //                                   child: Text(
// // //                                     house['tag'],
// // //                                     style: const TextStyle(
// // //                                         color: Colors.black, fontSize: 12),
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                               Positioned(
// // //                                 top: 8,
// // //                                 right: 8,
// // //                                 child: CircleAvatar(
// // //                                   backgroundColor: Colors.white,
// // //                                   child: IconButton(
// // //                                     icon: Icon(
// // //                                       isInWishlist
// // //                                           ? Icons.favorite
// // //                                           : Icons.favorite_border,
// // //                                       color: isInWishlist
// // //                                           ? Colors.red
// // //                                           : Colors.black,
// // //                                     ),
// // //                                     onPressed: () {
// // //                                       _wishlistManager.toggleWishlist(house);
// // //                                       ScaffoldMessenger.of(context)
// // //                                           .showSnackBar(
// // //                                         SnackBar(
// // //                                           backgroundColor: Colors.green,
// // //                                           content: Text(isInWishlist
// // //                                               ? 'Removed from wishlist'
// // //                                               : 'Added to wishlist'),
// // //                                           duration: const Duration(seconds: 1),
// // //                                           behavior: SnackBarBehavior.floating,
// // //                                         ),
// // //                                       );
// // //                                     },
// // //                                   ),
// // //                                 ),
// // //                               )
// // //                             ],
// // //                           ),
// // //                           const SizedBox(height: 8),
// // //                           Text(
// // //                             house['title'],
// // //                             style: const TextStyle(
// // //                               fontWeight: FontWeight.w600,
// // //                               fontSize: 15,
// // //                             ),
// // //                           ),
// // //                           const SizedBox(height: 6),
// // //                           Row(
// // //                             children: [
// // //                               _iconText(Icons.bed_outlined, house['bed']),
// // //                               const SizedBox(width: 8),
// // //                               _iconText(Icons.bathtub_outlined, house['bath']),
// // //                               const SizedBox(width: 8),
// // //                               _iconText(Icons.square_foot, house['area']),
// // //                             ],
// // //                           ),
// // //                           const SizedBox(height: 6),
// // //                           Row(
// // //                             children: [
// // //                               const Icon(Icons.location_on_outlined, size: 16),
// // //                               Text(
// // //                                 house['location'],
// // //                                 style: const TextStyle(fontSize: 13),
// // //                               )
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     );
// // //                   },
// // //                 );
// // //               },
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildLocationContainer() {
// // //     return GestureDetector(
// // //       onTap: _handleLocationUpdate,
// // //       child: Container(
// // //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //         decoration: BoxDecoration(
// // //           gradient: const LinearGradient(
// // //             colors: [
// // //               Color(0xFF00A8E8),
// // //               Color(0xFF2BBBAD),
// // //             ],
// // //             begin: Alignment.centerLeft,
// // //             end: Alignment.centerRight,
// // //           ),
// // //           borderRadius: BorderRadius.circular(12),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: const Color(0xFF00A8E8).withOpacity(0.3),
// // //               blurRadius: 8,
// // //               offset: const Offset(0, 4),
// // //             ),
// // //           ],
// // //         ),
// // //         child: Row(
// // //           children: [
// // //             Container(
// // //               padding: const EdgeInsets.all(8),
// // //               decoration: BoxDecoration(
// // //                 color: Colors.white.withOpacity(0.2),
// // //                 borderRadius: BorderRadius.circular(8),
// // //               ),
// // //               child: const Icon(
// // //                 Icons.location_on,
// // //                 color: Colors.white,
// // //                 size: 20,
// // //               ),
// // //             ),
// // //             const SizedBox(width: 12),
// // //             Expanded(
// // //               child: Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.start,
// // //                 children: [
// // //                   const Text(
// // //                     'Current Location',
// // //                     style: TextStyle(
// // //                       color: Colors.white70,
// // //                       fontSize: 11,
// // //                       fontWeight: FontWeight.w500,
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 2),
// // //                   isLoadingAddress
// // //                       ? const SizedBox(
// // //                           height: 16,
// // //                           width: 16,
// // //                           child: CircularProgressIndicator(
// // //                             strokeWidth: 2,
// // //                             valueColor:
// // //                                 AlwaysStoppedAnimation<Color>(Colors.white),
// // //                           ),
// // //                         )
// // //                       : Text(
// // //                           currentAddress ?? 'Set your location',
// // //                           style: const TextStyle(
// // //                             color: Colors.white,
// // //                             fontSize: 14,
// // //                             fontWeight: FontWeight.w600,
// // //                           ),
// // //                           maxLines: 1,
// // //                           overflow: TextOverflow.ellipsis,
// // //                         ),
// // //                 ],
// // //               ),
// // //             ),
// // //             const Icon(
// // //               Icons.arrow_forward_ios,
// // //               color: Colors.white,
// // //               size: 16,
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _categoryIconFromApi(String label, String imageUrl) {
// // //     final bool isFirst =
// // //         categories.isNotEmpty && categories[0]['name'] == label;

// // //     return Container(
// // //       width: 80,
// // //       height: 80,
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(16),
// // //         color: isFirst ? null : const Color.fromARGB(255, 243, 243, 243),
// // //         gradient: isFirst
// // //             ? const LinearGradient(
// // //                 colors: [
// // //                   Color(0xFF00A8E8),
// // //                   Color(0xFF2BBBAD),
// // //                 ],
// // //                 begin: Alignment.topLeft,
// // //                 end: Alignment.bottomRight,
// // //               )
// // //             : null,
// // //       ),
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           CircleAvatar(
// // //             radius: 20,
// // //             backgroundColor: Colors.white,
// // //             child: ClipOval(
// // //               child: Image.network(
// // //                 imageUrl,
// // //                 width: 20,
// // //                 height: 20,
// // //                 fit: BoxFit.cover,
// // //                 errorBuilder: (context, error, stackTrace) {
// // //                   return const Icon(
// // //                     Icons.category,
// // //                     size: 20,
// // //                     color: Color(0xFF00A8E8),
// // //                   );
// // //                 },
// // //               ),
// // //             ),
// // //           ),
// // //           const SizedBox(height: 6),
// // //           Text(
// // //             label.length > 7 ? '${label.substring(0, 7)}.' : label,
// // //             style: TextStyle(
// // //               fontSize: 12,
// // //               color: isFirst ? Colors.white : Colors.black,
// // //               fontWeight: FontWeight.w600,
// // //             ),
// // //             overflow: TextOverflow.ellipsis,
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _choiceChip(String label, bool selected) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(12),
// // //         border: Border.all(
// // //           color: selected ? Colors.transparent : const Color(0xFF00A8E8),
// // //           width: 1,
// // //         ),
// // //         gradient: selected
// // //             ? const LinearGradient(
// // //                 colors: [
// // //                   Color(0xFF00A8E8),
// // //                   Color(0xFF2BBBAD),
// // //                 ],
// // //               )
// // //             : null,
// // //         color: selected ? null : Colors.transparent,
// // //       ),
// // //       child: Text(
// // //         label,
// // //         style: TextStyle(
// // //           color: selected ? Colors.white : const Color(0xFF00A8E8),
// // //           fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
// // //           fontSize: 14,
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _iconText(IconData icon, String label) {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// // //       decoration: BoxDecoration(
// // //         border: Border.all(color: Colors.grey.shade300),
// // //         borderRadius: BorderRadius.circular(16),
// // //       ),
// // //       child: Row(
// // //         children: [
// // //           Icon(icon, size: 14),
// // //           const SizedBox(width: 4),
// // //           Text(label, style: const TextStyle(fontSize: 12)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:product_app/Provider/location/location_provider.dart';
// // import 'package:product_app/Provider/profile/profile_provider.dart';
// // import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
// // import 'package:product_app/helper/helper_function.dart';
// // import 'package:product_app/profile/edit_profile.dart';
// // import 'package:product_app/views/Buy/buy_screen.dart';
// // import 'package:product_app/views/Listing/listing_screen.dart';
// // import 'package:product_app/views/Notifications/notification_screen.dart';
// // import 'package:product_app/views/category/category_screen.dart';
// // import 'package:product_app/views/location/location_screen.dart';
// // import 'package:product_app/views/nearesthouses/nearest_houses.dart';
// // import 'package:product_app/views/sell/sell_category.dart';
// // import 'package:provider/provider.dart';
// // import 'package:geocoding/geocoding.dart' as geocoding;

// // class HomeScreen extends StatefulWidget {
// //   const HomeScreen({super.key});

// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   List<Map<String, dynamic>> categories = [];
// //   bool isLoadingCategories = true;
// //   String? currentAddress;
// //   bool isLoadingAddress = false;

// //   int selectedIndex = 0;

// //   String getGreeting() {
// //     final hour = DateTime.now().hour;

// //     if (hour >= 5 && hour < 12) {
// //       return 'Good Morning';
// //     } else if (hour >= 12 && hour < 17) {
// //       return 'Good Afternoon';
// //     } else if (hour >= 17 && hour < 21) {
// //       return 'Good Evening';
// //     } else {
// //       return 'Good Night';
// //     }
// //   }

// //   List<Map<String, dynamic>> nearestProducts = [];
// //   bool isLoadingNearestProducts = true;

// //   @override
// //   void initState() {
// //     super.initState();

// //     final userId = SharedPrefHelper.getUserId();
// //     if (userId != null) {
// //       Future.microtask(() {
// //         Provider.of<ProfileProvider>(context, listen: false)
// //             .fetchProfile(userId);
// //         // Fetch wishlist on app start
// //         Provider.of<WishlistProvider>(context, listen: false).fetchWishlist();
// //       });
// //     }
// //     fetchCategories();
// //     _loadCurrentLocation();
// //   }

// //   // Future<void> _loadCurrentLocation() async {
// //   //   setState(() {
// //   //     isLoadingAddress = true;
// //   //   });

// //   //   try {
// //   //     final locationProvider =
// //   //         Provider.of<LocationProvider>(context, listen: false);

// //   //     // Check if location is already available
// //   //     if (locationProvider.latitude != null &&
// //   //         locationProvider.longitude != null) {
// //   //       await _getAddressFromCoordinates(
// //   //         locationProvider.latitude!,
// //   //         locationProvider.longitude!,
// //   //       );
// //   //       // Fetch nearest products after location is loaded
// //   //       await fetchNearestProducts();
// //   //     }
// //   //   } catch (e) {
// //   //     print('Error loading location: $e');
// //   //   } finally {
// //   //     setState(() {
// //   //       isLoadingAddress = false;
// //   //     });
// //   //   }
// //   // }

// // // Update this method in your HomeScreen

// //   Future<void> _loadCurrentLocation() async {
// //     setState(() {
// //       isLoadingAddress = true;
// //     });

// //     try {
// //       final locationProvider =
// //           Provider.of<LocationProvider>(context, listen: false);

// //       await locationProvider.loadSavedLocation();

// //       if (locationProvider.latitude != null &&
// //           locationProvider.longitude != null) {
// //         await _getAddressFromCoordinates(
// //           locationProvider.latitude!,
// //           locationProvider.longitude!,
// //         );
// //         await fetchNearestProducts();
// //       } else {
// //         setState(() {
// //           currentAddress = 'Set your location';
// //         });
// //       }
// //     } catch (e) {
// //       print('Error loading location: $e');
// //       setState(() {
// //         currentAddress = 'Location unavailable';
// //       });
// //     } finally {
// //       setState(() {
// //         isLoadingAddress = false;
// //       });
// //     }
// //   }

// //   Future<void> _getAddressFromCoordinates(
// //       double latitude, double longitude) async {
// //     try {
// //       List<geocoding.Placemark> placemarks =
// //           await geocoding.placemarkFromCoordinates(
// //         latitude,
// //         longitude,
// //       );

// //       if (placemarks.isNotEmpty) {
// //         final place = placemarks.first;
// //         setState(() {
// //           currentAddress = [
// //             place.locality,
// //             place.administrativeArea,
// //           ].where((e) => e != null && e.isNotEmpty).take(2).join(', ');
// //         });
// //       }
// //     } catch (e) {
// //       print('Error getting address: $e');
// //       setState(() {
// //         currentAddress = 'Location unavailable';
// //       });
// //     }
// //   }

// //   Future<void> _handleLocationUpdate() async {
// //     final userId = SharedPrefHelper.getUserId();
// //     if (userId == null) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('User not logged in')),
// //       );
// //       return;
// //     }

// //     final result = await Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //           builder: (context) => LocationFetchScreen(
// //                 userId: userId,
// //               )),
// //     );

// //     if (result != null && result is Map<String, dynamic>) {
// //       setState(() {
// //         currentAddress = result['address'] as String?;
// //       });

// //       final locationProvider =
// //           Provider.of<LocationProvider>(context, listen: false);

// //       locationProvider.setManualLocation(
// //         latitude: result['latitude'] as double,
// //         longitude: result['longitude'] as double,
// //       );

// //       // Fetch nearest products after location update
// //       await fetchNearestProducts();
// //     }
// //   }

// //   // New method to fetch nearest products
// //   // Future<void> fetchNearestProducts() async {
// //   //   final userId = SharedPrefHelper.getUserId();
// //   //   if (userId == null) {
// //   //     print('User ID not found');
// //   //     setState(() {
// //   //       isLoadingNearestProducts = false;
// //   //     });
// //   //     return;
// //   //   }

// //   //   setState(() {
// //   //     isLoadingNearestProducts = true;
// //   //   });

// //   //   try {
// //   //     final response = await http.get(
// //   //       Uri.parse('http://31.97.206.144:9174/api/nearest/user/$userId'),
// //   //     );

// //   //     print(
// //   //         'Response status code for nearest products: ${response.statusCode}');
// //   //     print('Response body for nearest products: ${response.body}');

// //   //     if (response.statusCode == 200) {
// //   //       final data = json.decode(response.body);
// //   //       if (data['success'] == true && data['products'] != null) {
// //   //         setState(() {
// //   //           nearestProducts = (data['products'] as List).map((product) {
// //   //             // Extract features
// //   //             String bed = '';
// //   //             String bath = '';
// //   //             String area = '';

// //   //             if (product['features'] != null) {
// //   //               for (var feature in product['features']) {
// //   //                 String name = feature['name'].toString().toLowerCase();
// //   //                 if (name.contains('bedroom') || name.contains('bed')) {
// //   //                   bed = feature['name'];
// //   //                 } else if (name.contains('bathroom') ||
// //   //                     name.contains('bath')) {
// //   //                   bath = feature['name'];
// //   //                 } else if (name.contains('sqft') || name.contains('sq')) {
// //   //                   area = feature['name'];
// //   //                 }
// //   //               }
// //   //             }

// //   //             return {
// //   //               'id': product['_id'],
// //   //               'imageUrl': product['image'],
// //   //               'tag': product['type'] ?? 'For Sale',
// //   //               'title': product['name'],
// //   //               'location': product['address'] ?? 'Unknown',
// //   //               'price': '₹25,000',
// //   //               'bed': bed.isNotEmpty ? bed : '4 Bed',
// //   //               'bath': bath.isNotEmpty ? bath : '2 Bath',
// //   //               'area': area.isNotEmpty ? area : '7,500 sqft',
// //   //             };
// //   //           }).toList();
// //   //           isLoadingNearestProducts = false;
// //   //         });
// //   //       }
// //   //     } else {
// //   //       throw Exception('Failed to load nearest products');
// //   //     }
// //   //   } catch (e) {
// //   //     print('Error fetching nearest products: $e');
// //   //     setState(() {
// //   //       isLoadingNearestProducts = false;
// //   //     });
// //   //   }
// //   // }

// //   // Replace your fetchNearestProducts method with this fixed version:

// // Future<void> fetchNearestProducts() async {
// //   final userId = SharedPrefHelper.getUserId();
// //   if (userId == null) {
// //     print('User ID not found');
// //     setState(() {
// //       isLoadingNearestProducts = false;
// //     });
// //     return;
// //   }

// //   setState(() {
// //     isLoadingNearestProducts = true;
// //   });

// //   try {
// //     final response = await http.get(
// //       Uri.parse('http://31.97.206.144:9174/api/nearest/user/$userId'),
// //     );

// //     print('Response status code for nearest products: ${response.statusCode}');
// //     print('Response body for nearest products: ${response.body}');

// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //       if (data['success'] == true && data['products'] != null) {
// //         setState(() {
// //           nearestProducts = (data['products'] as List).map((product) {
// //             // Extract features with null safety
// //             String bed = '';
// //             String bath = '';
// //             String area = '';

// //             if (product['features'] != null) {
// //               for (var feature in product['features']) {
// //                 String name = (feature['name']?.toString() ?? '').toLowerCase();
// //                 if (name.contains('bedroom') || name.contains('bed')) {
// //                   bed = feature['name']?.toString() ?? '';
// //                 } else if (name.contains('bathroom') || name.contains('bath')) {
// //                   bath = feature['name']?.toString() ?? '';
// //                 } else if (name.contains('sqft') || name.contains('sq')) {
// //                   area = feature['name']?.toString() ?? '';
// //                 }
// //               }
// //             }

// //             return {
// //               'id': product['_id']?.toString() ?? '',
// //               'imageUrl': product['image']?.toString() ?? '',
// //               'tag': product['type']?.toString() ?? 'For Sale',
// //               'title': product['name']?.toString() ?? 'Unnamed Property',
// //               'location': product['address']?.toString() ?? 'Unknown',
// //               'price': '₹25,000', // You might want to get this from API too
// //               'bed': bed.isNotEmpty ? bed : '4 Bed',
// //               'bath': bath.isNotEmpty ? bath : '2 Bath',
// //               'area': area.isNotEmpty ? area : '7,500 sqft',
// //             };
// //           }).toList();
// //           isLoadingNearestProducts = false;
// //         });
// //       } else {
// //         setState(() {
// //           nearestProducts = [];
// //           isLoadingNearestProducts = false;
// //         });
// //       }
// //     } else {
// //       throw Exception('Failed to load nearest products');
// //     }
// //   } catch (e) {
// //     print('Error fetching nearest products: $e');
// //     setState(() {
// //       nearestProducts = [];
// //       isLoadingNearestProducts = false;
// //     });
// //   }
// // }

// //   // Future<void> fetchCategories() async {
// //   //   try {
// //   //     final response = await http.get(
// //   //       Uri.parse('http://31.97.206.144:9174/api/auth/get/MainCategories'),
// //   //     );

// //   //     print(
// //   //         'Response status code for get all categories ${response.statusCode}');
// //   //     print('Response body for get all categories ${response.body}');

// //   //     if (response.statusCode == 200) {
// //   //       final data = json.decode(response.body);
// //   //       if (data['success'] == true) {
// //   //         setState(() {
// //   //           categories = List<Map<String, dynamic>>.from(
// //   //               data['categories'].map((category) => {
// //   //                     'id': category['_id'],
// //   //                     'name': category['name'],
// //   //                     'image': category['image'],
// //   //                   }));
// //   //           isLoadingCategories = false;
// //   //         });
// //   //       }
// //   //     }
// //   //   } catch (e) {
// //   //     print('Error fetching categories: $e');
// //   //     setState(() {
// //   //       isLoadingCategories = false;
// //   //     });
// //   //   }
// //   // }

// //   Future<void> fetchCategories() async {
// //     try {
// //       final response = await http.get(
// //         Uri.parse('http://31.97.206.144:9174/api/auth/sub/all'),
// //       );

// //       print('Response status code: ${response.statusCode}');
// //       print('Response body: ${response.body}');

// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);

// //         if (data['success'] == true) {
// //           setState(() {
// //             categories = List<Map<String, dynamic>>.from(
// //               data['subCategories'].map((subCategory) => {
// //                     'id': subCategory['_id'],
// //                     'name': subCategory['name'],
// //                     'image': subCategory['image'],
// //                     // Optional but useful
// //                     'mainCategoryId': subCategory['category']['_id'],
// //                     'mainCategoryName': subCategory['category']['name'],
// //                   }),
// //             );

// //             isLoadingCategories = false;
// //           });
// //         } else {
// //           isLoadingCategories = false;
// //         }
// //       } else {
// //         isLoadingCategories = false;
// //       }
// //     } catch (e) {
// //       print('Error fetching sub categories: $e');
// //       setState(() {
// //         isLoadingCategories = false;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final displayProducts = nearestProducts.isNotEmpty ? nearestProducts : [];

// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         leading: Padding(
// //           padding: const EdgeInsets.only(left: 10),
// //           child: Consumer<ProfileProvider>(
// //             builder: (context, profileProvider, _) {
// //               final imageUrl = profileProvider.profileImageUrl;

// //               return GestureDetector(
// //                 onTap: () {
// //                   Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                           builder: (context) => const EditProfile()));
// //                 },
// //                 child: CircleAvatar(
// //                   radius: 20,
// //                   backgroundColor: Colors.grey.shade200,
// //                   backgroundImage: imageUrl != null && imageUrl.isNotEmpty
// //                       ? NetworkImage(imageUrl)
// //                       : const AssetImage(
// //                           'lib/assets/403079b6b3230e238d25d0e18c175d870e3223de.png',
// //                         ) as ImageProvider,
// //                   child: imageUrl == null || imageUrl.isEmpty
// //                       ? const Icon(Icons.person, color: Colors.grey)
// //                       : null,
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //         title: Consumer<ProfileProvider>(
// //           builder: (context, profileProvider, _) {
// //             final userName = profileProvider.name ?? 'User';

// //             return Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   getGreeting(),
// //                   style: const TextStyle(fontSize: 14, color: Colors.black54),
// //                 ),
// //                 Text(
// //                   userName,
// //                   style: const TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.black,
// //                   ),
// //                 ),
// //               ],
// //             );
// //           },
// //         ),
// //         actions: [
// //           GestureDetector(
// //             onTap: _handleLocationUpdate,
// //             child: Container(
// //                 width: 40,
// //                 height: 40,
// //                 decoration: BoxDecoration(
// //                     borderRadius: BorderRadius.circular(8),
// //                     border: Border.all(color: Colors.grey)),
// //                 child: const Icon(Icons.location_on, color: Colors.black)),
// //           ),
// //           const SizedBox(width: 16),
// //           GestureDetector(
// //             onTap: () {
// //               Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                       builder: (context) => const NotificationScreen()));
// //             },
// //             child: Container(
// //               width: 40,
// //               height: 40,
// //               decoration: BoxDecoration(
// //                   border: Border.all(color: Colors.grey),
// //                   borderRadius: BorderRadius.circular(8)),
// //               child: Stack(
// //                 children: [
// //                   const Center(
// //                     child: Icon(Icons.notifications_none, color: Colors.black),
// //                   ),
// //                   Positioned(
// //                     right: 8,
// //                     top: 8,
// //                     child: Container(
// //                       width: 8,
// //                       height: 8,
// //                       decoration: const BoxDecoration(
// //                         color: Colors.red,
// //                         shape: BoxShape.circle,
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           const SizedBox(width: 16),
// //         ],
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.symmetric(horizontal: 16),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             const SizedBox(height: 12),

// //             // Location Display Container
// //             _buildLocationContainer(),

// //             const SizedBox(height: 16),

// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// //               children: [
// //                 Expanded(
// //                   child: TextField(
// //                     decoration: InputDecoration(
// //                       hintText: 'Search',
// //                       prefixIcon: const Icon(Icons.search),
// //                       filled: true,
// //                       fillColor: Colors.white,
// //                       enabledBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(30),
// //                         borderSide: const BorderSide(
// //                           color: Color.fromARGB(255, 221, 221, 221),
// //                           width: 2,
// //                         ),
// //                       ),
// //                       focusedBorder: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(30),
// //                         borderSide: const BorderSide(
// //                           color: Color.fromARGB(255, 217, 216, 216),
// //                           width: 2,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 const SizedBox(width: 10),
// //                 Container(
// //                   width: 44,
// //                   height: 44,
// //                   decoration: const BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     gradient: LinearGradient(
// //                       colors: [
// //                         Color(0xFF00A8E8),
// //                         Color(0xFF2BBBAD),
// //                       ],
// //                       begin: Alignment.topLeft,
// //                       end: Alignment.bottomRight,
// //                     ),
// //                   ),
// //                   child: const Center(
// //                     child: Icon(
// //                       Icons.tune,
// //                       color: Colors.white,
// //                     ),
// //                   ),
// //                 )
// //               ],
// //             ),
// //             const SizedBox(height: 16),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: [
// //                 GestureDetector(
// //                     onTap: () {

// //                     },
// //                     child: _choiceChip('Listora', true)),
// //                 // GestureDetector(
// //                 //     onTap: () {
// //                 //       Navigator.push(
// //                 //           context,
// //                 //           MaterialPageRoute(
// //                 //               builder: (context) => const BuyScreen()));
// //                 //     },
// //                 //     child: _choiceChip('Buy', true)),
// //                 // GestureDetector(
// //                 //     onTap: () {
// //                 //       Navigator.push(
// //                 //           context,
// //                 //           MaterialPageRoute(
// //                 //               builder: (context) => const SellCategory()));
// //                 //     },
// //                 //     child: _choiceChip('Sell', false)),
// //               ],
// //             ),
// //             const SizedBox(height: 20),
// //             Container(
// //               padding: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 border:
// //                     Border.all(color: const Color.fromARGB(255, 191, 190, 190)),
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.shade200,
// //                     blurRadius: 10,
// //                     offset: const Offset(0, 4),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 children: [
// //                   isLoadingCategories
// //                       ? const Center(
// //                           child: Padding(
// //                             padding: EdgeInsets.all(20.0),
// //                             child: CircularProgressIndicator(),
// //                           ),
// //                         )
// //                       : SingleChildScrollView(
// //                           scrollDirection: Axis.horizontal,
// //                           child: Row(
// //                             // children: categories.take(4).map((category) {

// //                             //   return Padding(
// //                             //     padding: const EdgeInsets.only(right: 12),
// //                             //     child: _categoryIconFromApi(
// //                             //       category['name'],
// //                             //       category['image'],
// //                             //     ),
// //                             //   );
// //                             // }).toList(),

// //                             children: List.generate(
// //                               categories.take(4).length,
// //                               (index) {
// //                                 final category = categories[index];

// //                                 return Padding(
// //                                   padding: const EdgeInsets.only(right: 12),
// //                                   child: _categoryIconFromApi(
// //                                     isSelected: selectedIndex == index,
// //                                     label: category['name'],
// //                                     imageUrl: category['image'],
// //                                     onTap: () {
// //                                       Navigator.push(context,MaterialPageRoute(builder: (context)=>CreateListingScreen(subcategoryId: category['id'],)));
// //                                       print('selected indexx $selectedIndex');
// //                                       print(
// //                                           'selected category ${category['name']}');
// //                                       setState(() {
// //                                         selectedIndex = index;
// //                                       });
// //                                     },
// //                                   ),
// //                                 );
// //                               },
// //                             ),
// //                           ),
// //                         ),
// //                   const SizedBox(height: 16),
// //                   GestureDetector(
// //                     onTap: () {
// //                       Navigator.push(
// //                           context,
// //                           MaterialPageRoute(
// //                               builder: (context) => const CategoryScreen()));
// //                     },
// //                     child: Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 16, vertical: 12),
// //                       decoration: BoxDecoration(
// //                         border: Border.all(color: Colors.grey.shade300),
// //                         borderRadius: BorderRadius.circular(25),
// //                       ),
// //                       child: const Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Text(
// //                             'All Category',
// //                             style: TextStyle(
// //                               fontSize: 14,
// //                               color: Color.fromARGB(255, 41, 41, 41),
// //                             ),
// //                           ),
// //                           Icon(
// //                             Icons.arrow_forward_ios,
// //                             size: 15,
// //                             color: Color.fromARGB(255, 0, 0, 0),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Row(
// //               children: [
// //                 const Text('Nearest Houses',
// //                     style:
// //                         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //                 const Spacer(),
// //                 GestureDetector(
// //                   onTap: () {
// //                     Navigator.push(
// //                         context,
// //                         MaterialPageRoute(
// //                             builder: (context) =>  NearestHouses()));
// //                   },
// //                   child: const Text('See All',
// //                       style: TextStyle(color: Colors.black)),
// //                 ),
// //                 const SizedBox(width: 4),
// //                 const Icon(
// //                   Icons.arrow_forward_ios,
// //                   size: 13,
// //                 )
// //               ],
// //             ),
// //             const SizedBox(height: 10),

// //             // Show loading indicator while fetching data
// //             isLoadingNearestProducts
// //                 ? const Center(
// //                     child: Padding(
// //                       padding: EdgeInsets.all(40.0),
// //                       child: Text(
// //                         'No nearest Houses found nearby',
// //                         style: TextStyle(fontWeight: FontWeight.bold),
// //                       ),
// //                     ),
// //                   )
// //                 : displayProducts.isEmpty
// //                     ? Center(
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(40.0),
// //                           child: Column(
// //                             children: [
// //                               Icon(
// //                                 Icons.location_off,
// //                                 size: 64,
// //                                 color: Colors.grey.shade400,
// //                               ),
// //                               const SizedBox(height: 16),
// //                               Text(
// //                                 'No nearby properties found',
// //                                 style: TextStyle(
// //                                   fontSize: 16,
// //                                   color: Colors.grey.shade600,
// //                                 ),
// //                               ),
// //                               const SizedBox(height: 8),
// //                               Text(
// //                                 'Try updating your location',
// //                                 style: TextStyle(
// //                                   fontSize: 14,
// //                                   color: Colors.grey.shade500,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       )
// //                     : ListView.builder(
// //                         shrinkWrap: true,
// //                         physics: const NeverScrollableScrollPhysics(),
// //                         itemCount: displayProducts.length,
// //                         itemBuilder: (context, index) {
// //                           final house = displayProducts[index];
// //                           return Consumer<WishlistProvider>(
// //                             builder: (context, wishlistProvider, child) {

// //                               final isInWishlist =
// //                                   wishlistProvider.isInWishlist(house['id']);

// //                               return Container(
// //                                 margin: const EdgeInsets.only(bottom: 16),
// //                                 padding: const EdgeInsets.all(8),
// //                                 decoration: BoxDecoration(
// //                                   border: Border.all(
// //                                     color: Colors.grey.shade300,
// //                                     width: 1,
// //                                   ),
// //                                   borderRadius: BorderRadius.circular(12),
// //                                 ),
// //                                 child: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     Stack(
// //                                       children: [
// //                                         GestureDetector(
// //                                           onTap: () {
// //                                             Navigator.push(
// //                                                 context,
// //                                                 MaterialPageRoute(
// //                                                     builder: (context) =>
// //                                                         const NearestHouses()));
// //                                           },
// //                                           child: ClipRRect(
// //                                             borderRadius:
// //                                                 BorderRadius.circular(10),
// //                                             child: Image.network(
// //                                               house['imageUrl'],
// //                                               height: 160,
// //                                               width: double.infinity,
// //                                               fit: BoxFit.cover,
// //                                               errorBuilder:
// //                                                   (context, error, stackTrace) {
// //                                                 return Container(
// //                                                   height: 160,
// //                                                   width: double.infinity,
// //                                                   color: Colors.grey.shade300,
// //                                                   child: const Icon(
// //                                                     Icons.home,
// //                                                     size: 64,
// //                                                     color: Colors.grey,
// //                                                   ),
// //                                                 );
// //                                               },
// //                                               loadingBuilder: (context, child,
// //                                                   loadingProgress) {
// //                                                 if (loadingProgress == null) {
// //                                                   return child;
// //                                                 }
// //                                                 return Container(
// //                                                   height: 160,
// //                                                   width: double.infinity,
// //                                                   color: Colors.grey.shade200,
// //                                                   child: const Center(
// //                                                     child:
// //                                                         CircularProgressIndicator(),
// //                                                   ),
// //                                                 );
// //                                               },
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Positioned(
// //                                           top: 8,
// //                                           left: 8,
// //                                           child: Container(
// //                                             padding: const EdgeInsets.symmetric(
// //                                                 horizontal: 8, vertical: 4),
// //                                             decoration: BoxDecoration(
// //                                               color: Colors.white,
// //                                               borderRadius:
// //                                                   BorderRadius.circular(20),
// //                                             ),
// //                                             child: Text(
// //                                               house['tag'],
// //                                               style: const TextStyle(
// //                                                   color: Colors.black,
// //                                                   fontSize: 12),
// //                                             ),
// //                                           ),
// //                                         ),
// //                                         Positioned(
// //                                           top: 8,
// //                                           right: 8,
// //                                           child: CircleAvatar(
// //                                             backgroundColor: Colors.white,
// //                                             child: wishlistProvider.isToggling
// //                                                 ? const SizedBox(
// //                                                     width: 20,
// //                                                     height: 20,
// //                                                     child:
// //                                                         CircularProgressIndicator(
// //                                                       strokeWidth: 2,
// //                                                       valueColor:
// //                                                           AlwaysStoppedAnimation<
// //                                                                   Color>(
// //                                                               Colors.red),
// //                                                     ),
// //                                                   )
// //                                                 : IconButton(
// //                                                     icon: Icon(
// //                                                       isInWishlist
// //                                                           ? Icons.favorite
// //                                                           : Icons
// //                                                               .favorite_border,
// //                                                       color: isInWishlist
// //                                                           ? Colors.red
// //                                                           : Colors.black,
// //                                                     ),
// //                                                     onPressed: () async {
// //                                                       final success =
// //                                                           await wishlistProvider
// //                                                               .toggleWishlist(
// //                                                                   house['id']);

// //                                                       if (context.mounted) {
// //                                                         ScaffoldMessenger.of(
// //                                                                 context)
// //                                                             .showSnackBar(
// //                                                           SnackBar(
// //                                                             backgroundColor:
// //                                                                 success
// //                                                                     ? Colors
// //                                                                         .green
// //                                                                     : Colors
// //                                                                         .red,
// //                                                             content: Text(
// //                                                               success
// //                                                                   ? (isInWishlist
// //                                                                       ? 'Removed from wishlist'
// //                                                                       : 'Added to wishlist')
// //                                                                   : (wishlistProvider
// //                                                                           .errorMessage ??
// //                                                                       'Failed to update wishlist'),
// //                                                             ),
// //                                                             duration:
// //                                                                 const Duration(
// //                                                                     seconds: 2),
// //                                                             behavior:
// //                                                                 SnackBarBehavior
// //                                                                     .floating,
// //                                                           ),
// //                                                         );
// //                                                       }
// //                                                     },
// //                                                   ),
// //                                           ),
// //                                         )
// //                                       ],
// //                                     ),
// //                                     const SizedBox(height: 8),
// //                                     Text(
// //                                       house['title'],
// //                                       style: const TextStyle(
// //                                         fontWeight: FontWeight.w600,
// //                                         fontSize: 15,
// //                                       ),
// //                                     ),
// //                                     const SizedBox(height: 6),
// //                                     Row(
// //                                       children: [
// //                                         _iconText(
// //                                             Icons.bed_outlined, house['bed']),
// //                                         const SizedBox(width: 8),
// //                                         _iconText(Icons.bathtub_outlined,
// //                                             house['bath']),
// //                                         const SizedBox(width: 8),
// //                                         _iconText(
// //                                             Icons.square_foot, house['area']),
// //                                       ],
// //                                     ),
// //                                     const SizedBox(height: 6),
// //                                     Row(
// //                                       children: [
// //                                         const Icon(Icons.location_on_outlined,
// //                                             size: 16),
// //                                         Expanded(
// //                                           child: Text(
// //                                             house['location'],
// //                                             style:
// //                                                 const TextStyle(fontSize: 13),
// //                                             overflow: TextOverflow.ellipsis,
// //                                           ),
// //                                         )
// //                                       ],
// //                                     ),
// //                                   ],
// //                                 ),
// //                               );
// //                             },
// //                           );
// //                         },
// //                       ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildLocationContainer() {
// //     return GestureDetector(
// //       onTap: _handleLocationUpdate,
// //       child: Container(
// //         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //         decoration: BoxDecoration(
// //           gradient: const LinearGradient(
// //             colors: [
// //               Color(0xFF00A8E8),
// //               Color(0xFF2BBBAD),
// //             ],
// //             begin: Alignment.centerLeft,
// //             end: Alignment.centerRight,
// //           ),
// //           borderRadius: BorderRadius.circular(12),
// //           boxShadow: [
// //             BoxShadow(
// //               color: const Color(0xFF00A8E8).withOpacity(0.3),
// //               blurRadius: 8,
// //               offset: const Offset(0, 4),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                 color: Colors.white.withOpacity(0.2),
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //               child: const Icon(
// //                 Icons.location_on,
// //                 color: Colors.white,
// //                 size: 20,
// //               ),
// //             ),
// //             const SizedBox(width: 12),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Text(
// //                     'Current Location',
// //                     style: TextStyle(
// //                       color: Colors.white70,
// //                       fontSize: 11,
// //                       fontWeight: FontWeight.w500,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 2),
// //                   isLoadingAddress
// //                       ? const SizedBox(
// //                           height: 16,
// //                           width: 16,
// //                           child: CircularProgressIndicator(
// //                             strokeWidth: 2,
// //                             valueColor:
// //                                 AlwaysStoppedAnimation<Color>(Colors.white),
// //                           ),
// //                         )
// //                       : Text(
// //                           currentAddress ?? 'Set your location',
// //                           style: const TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                           maxLines: 1,
// //                           overflow: TextOverflow.ellipsis,
// //                         ),
// //                 ],
// //               ),
// //             ),
// //             const Icon(
// //               Icons.arrow_forward_ios,
// //               color: Colors.white,
// //               size: 16,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Widget _categoryIconFromApi(String label, String imageUrl) {
// //   //   final bool isFirst =
// //   //       categories.isNotEmpty && categories[0]['name'] == label;

// //   //   return Container(
// //   //     width: 80,
// //   //     height: 80,
// //   //     decoration: BoxDecoration(
// //   //       borderRadius: BorderRadius.circular(16),
// //   //       color: isFirst ? null : const Color.fromARGB(255, 243, 243, 243),
// //   //       gradient: isFirst
// //   //           ? const LinearGradient(
// //   //               colors: [
// //   //                 Color(0xFF00A8E8),
// //   //                 Color(0xFF2BBBAD),
// //   //               ],
// //   //               begin: Alignment.topLeft,
// //   //               end: Alignment.bottomRight,
// //   //             )
// //   //           : null,
// //   //     ),
// //   //     child: Column(
// //   //       mainAxisAlignment: MainAxisAlignment.center,
// //   //       children: [
// //   //         CircleAvatar(
// //   //           radius: 20,
// //   //           backgroundColor: Colors.white,
// //   //           child: ClipOval(
// //   //             child: Image.network(
// //   //               imageUrl,
// //   //               width: 20,
// //   //               height: 20,
// //   //               fit: BoxFit.cover,
// //   //               errorBuilder: (context, error, stackTrace) {
// //   //                 return const Icon(
// //   //                   Icons.category,
// //   //                   size: 20,
// //   //                   color: Color(0xFF00A8E8),
// //   //                 );
// //   //               },
// //   //             ),
// //   //           ),
// //   //         ),
// //   //         const SizedBox(height: 6),
// //   //         Text(
// //   //           label.length > 7 ? '${label.substring(0, 7)}.' : label,
// //   //           style: TextStyle(
// //   //             fontSize: 12,
// //   //             color: isFirst ? Colors.white : Colors.black,
// //   //             fontWeight: FontWeight.w600,
// //   //           ),
// //   //           overflow: TextOverflow.ellipsis,
// //   //         ),
// //   //       ],
// //   //     ),
// //   //   );
// //   // }

// //   Widget _categoryIconFromApi({
// //     required bool isSelected,
// //     required String label,
// //     required String imageUrl,
// //     required VoidCallback onTap,
// //   }) {
// //     return GestureDetector(
// //       onTap: onTap,
// //       child: Container(
// //         width: 80,
// //         height: 80,
// //         decoration: BoxDecoration(
// //           borderRadius: BorderRadius.circular(16),
// //           color: isSelected ? null : const Color.fromARGB(255, 243, 243, 243),
// //           gradient: isSelected
// //               ? const LinearGradient(
// //                   colors: [
// //                     Color(0xFF00A8E8),
// //                     Color(0xFF2BBBAD),
// //                   ],
// //                   begin: Alignment.topLeft,
// //                   end: Alignment.bottomRight,
// //                 )
// //               : null,
// //         ),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             CircleAvatar(
// //               radius: 20,
// //               backgroundColor: Colors.white,
// //               child: ClipOval(
// //                 child: Image.network(
// //                   imageUrl,
// //                   width: 20,
// //                   height: 20,
// //                   fit: BoxFit.cover,
// //                   errorBuilder: (_, __, ___) {
// //                     return Icon(
// //                       Icons.category,
// //                       size: 20,
// //                       color:
// //                           isSelected ? Colors.white : const Color(0xFF00A8E8),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 6),
// //             Text(
// //               label.length > 7 ? '${label.substring(0, 7)}.' : label,
// //               style: TextStyle(
// //                 fontSize: 12,
// //                 color: isSelected ? Colors.white : Colors.black,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //               overflow: TextOverflow.ellipsis,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _choiceChip(String label, bool selected) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(12),
// //         border: Border.all(
// //           color: selected ? Colors.transparent : const Color(0xFF00A8E8),
// //           width: 1,
// //         ),
// //         gradient: selected
// //             ? const LinearGradient(
// //                 colors: [
// //                   Color(0xFF00A8E8),
// //                   Color(0xFF2BBBAD),
// //                 ],
// //               )
// //             : null,
// //         color: selected ? null : Colors.transparent,
// //       ),
// //       child: Text(
// //         label,
// //         style: TextStyle(
// //           color: selected ? Colors.white : const Color(0xFF00A8E8),
// //           fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
// //           fontSize: 14,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _iconText(IconData icon, String label) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
// //       decoration: BoxDecoration(
// //         border: Border.all(color: Colors.grey.shade300),
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       child: Row(
// //         children: [
// //           Icon(icon, size: 12),
// //           const SizedBox(width: 4),
// //           Text(label, style: const TextStyle(fontSize: 12)),
// //         ],
// //       ),
// //     );
// //   }
// // }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'package:product_app/Provider/location/location_provider.dart';
// import 'package:product_app/Provider/profile/profile_provider.dart';
// import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'package:product_app/profile/edit_profile.dart';
// import 'package:product_app/views/Buy/buy_screen.dart';
// import 'package:product_app/views/Listing/listing_screen.dart';
// import 'package:product_app/views/Notifications/notification_screen.dart';
// import 'package:product_app/views/category/category_screen.dart';
// import 'package:product_app/views/location/location_screen.dart';
// import 'package:product_app/views/nearesthouses/nearest_houses.dart';
// import 'package:product_app/views/search/filter_screen.dart';
// import 'package:product_app/views/search/search_screen.dart';
// import 'package:product_app/views/sell/sell_category.dart';
// import 'package:provider/provider.dart';
// import 'package:geocoding/geocoding.dart' as geocoding;

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Map<String, dynamic>> categories = [];
//   bool isLoadingCategories = true;
//   String? currentAddress;
//   bool isLoadingAddress = false;

//   int selectedIndex = 0;

//   String getGreeting() {
//     final hour = DateTime.now().hour;

//     if (hour >= 5 && hour < 12) {
//       return 'Good Morning';
//     } else if (hour >= 12 && hour < 17) {
//       return 'Good Afternoon';
//     } else if (hour >= 17 && hour < 21) {
//       return 'Good Evening';
//     } else {
//       return 'Good Night';
//     }
//   }

//   List<Map<String, dynamic>> nearestProducts = [];
//   bool isLoadingNearestProducts = true;

//   @override
//   void initState() {
//     super.initState();

//     final userId = SharedPrefHelper.getUserId();
//     if (userId != null) {
//       Future.microtask(() {
//         Provider.of<ProfileProvider>(context, listen: false)
//             .fetchProfile(userId);
//         Provider.of<WishlistProvider>(context, listen: false).fetchWishlist();
//       });
//     }
//     fetchCategories();
//     _loadCurrentLocation();
//   }

//   // Future<void> _loadCurrentLocation() async {
//   //   setState(() {
//   //     isLoadingAddress = true;
//   //   });

//   //   try {
//   //     final locationProvider =
//   //         Provider.of<LocationProvider>(context, listen: false);

//   //     await locationProvider.loadSavedLocation();

//   //     if (locationProvider.latitude != null &&
//   //         locationProvider.longitude != null) {
//   //       await _getAddressFromCoordinates(
//   //         locationProvider.latitude!,
//   //         locationProvider.longitude!,
//   //       );
//   //       await fetchNearestProducts();
//   //     } else {
//   //       setState(() {
//   //         currentAddress = 'Set your location';
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print('Error loading location: $e');
//   //     setState(() {
//   //       currentAddress = 'Location unavailable';
//   //     });
//   //   } finally {
//   //     setState(() {
//   //       isLoadingAddress = false;
//   //     });
//   //   }
//   // }



//   Future<void> _loadCurrentLocation() async {
//   setState(() {
//     isLoadingAddress = true;
//   });

//   try {
//     final locationProvider = Provider.of<LocationProvider>(context, listen: false);

//     // Check if location permission is granted
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       setState(() {
//         currentAddress = 'Location services are disabled';
//         isLoadingAddress = false;
//       });
//       return;
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           currentAddress = 'Location permission denied';
//           isLoadingAddress = false;
//         });
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(() {
//         currentAddress = 'Location permission permanently denied';
//         isLoadingAddress = false;
//       });
//       return;
//     }

//     // Get current position automatically
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     // Save location to provider
//     locationProvider.setManualLocation(
//       latitude: position.latitude,
//       longitude: position.longitude,
//     );

//     // Get address from coordinates
//     await _getAddressFromCoordinates(position.latitude, position.longitude);

//     // Fetch nearest products
//     await fetchNearestProducts();

//   } catch (e) {
//     print('Error loading location: $e');
//     setState(() {
//       currentAddress = 'Location unavailable';
//     });
//   } finally {
//     setState(() {
//       isLoadingAddress = false;
//     });
//   }
// }

//   // Future<void> _getAddressFromCoordinates(
//   //     double latitude, double longitude) async {
//   //   try {
//   //     List<geocoding.Placemark> placemarks =
//   //         await geocoding.placemarkFromCoordinates(
//   //       latitude,
//   //       longitude,
//   //     );

//   //     if (placemarks.isNotEmpty) {
//   //       final place = placemarks.first;
//   //       setState(() {
//   //         currentAddress = [
//   //           place.locality,
//   //           place.administrativeArea,
//   //         ].where((e) => e != null && e.isNotEmpty).take(2).join(', ');
//   //       });
//   //     }
//   //   } catch (e) {
//   //     print('Error getting address: $e');
//   //     setState(() {
//   //       currentAddress = 'Location unavailable';
//   //     });
//   //   }
//   // }



//   Future<void> _getAddressFromCoordinates(double latitude, double longitude) async {
//   try {
//     List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
//       latitude,
//       longitude,
//     );

//     if (placemarks.isNotEmpty) {
//       final place = placemarks.first;
//       setState(() {
//         currentAddress = [
//           place.locality,
//           place.administrativeArea,
//         ].where((e) => e != null && e.isNotEmpty).take(2).join(', ');
//       });
//     }
//   } catch (e) {
//     print('Error getting address: $e');
//     setState(() {
//       currentAddress = 'Location unavailable';
//     });
//   }
// }

//   Future<void> _handleLocationUpdate() async {
//     final userId = SharedPrefHelper.getUserId();
//     if (userId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('User not logged in')),
//       );
//       return;
//     }

//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => LocationFetchScreen(
//                 userId: userId,
//               )),
//     );

//     if (result != null && result is Map<String, dynamic>) {
//       setState(() {
//         currentAddress = result['address'] as String?;
//       });

//       final locationProvider =
//           Provider.of<LocationProvider>(context, listen: false);

//       locationProvider.setManualLocation(
//         latitude: result['latitude'] as double,
//         longitude: result['longitude'] as double,
//       );

//       await fetchNearestProducts();
//     }
//   }

//   // Future<void> fetchNearestProducts() async {
//   //   final userId = SharedPrefHelper.getUserId();
//   //   if (userId == null) {
//   //     print('User ID not found');
//   //     setState(() {
//   //       isLoadingNearestProducts = false;
//   //     });
//   //     return;
//   //   }

//   //   setState(() {
//   //     isLoadingNearestProducts = true;
//   //   });

//   //   try {
//   //     final response = await http.get(
//   //       Uri.parse('http://31.97.206.144:9174/api/nearest/user/$userId'),
//   //     );

//   //     print(
//   //         'Response status code for nearest products: ${response.statusCode}');
//   //     print('Response body for nearest products: ${response.body}');

//   //     if (response.statusCode == 200) {
//   //       final data = json.decode(response.body);
//   //       if (data['success'] == true && data['products'] != null) {
//   //         setState(() {
//   //           nearestProducts = (data['products'] as List).map((product) {
//   //             String bed = '';
//   //             String bath = '';
//   //             String area = '';

//   //             if (product['features'] != null) {
//   //               for (var feature in product['features']) {
//   //                 String name =
//   //                     (feature['name']?.toString() ?? '').toLowerCase();
//   //                 if (name.contains('bedroom') || name.contains('bed')) {
//   //                   bed = feature['name']?.toString() ?? '';
//   //                 } else if (name.contains('bathroom') ||
//   //                     name.contains('bath')) {
//   //                   bath = feature['name']?.toString() ?? '';
//   //                 } else if (name.contains('sqft') || name.contains('sq')) {
//   //                   area = feature['name']?.toString() ?? '';
//   //                 }
//   //               }
//   //             }

//   //             return {
//   //               'id': product['_id']?.toString() ?? '',
//   //               'imageUrl': product['image']?.toString() ?? '',
//   //               'tag': product['type']?.toString() ?? 'For Sale',
//   //               'title': product['name']?.toString() ?? 'Unnamed Property',
//   //               'location': product['address']?.toString() ?? 'Unknown',
//   //               'price': '₹25,000',
//   //               'bed': bed.isNotEmpty ? bed : '4 Bed',
//   //               'bath': bath.isNotEmpty ? bath : '2 Bath',
//   //               'area': area.isNotEmpty ? area : '7,500 sqft',
//   //             };
//   //           }).toList();
//   //           isLoadingNearestProducts = false;
//   //         });
//   //       } else {
//   //         setState(() {
//   //           nearestProducts = [];
//   //           isLoadingNearestProducts = false;
//   //         });
//   //       }
//   //     } else {
//   //       throw Exception('Failed to load nearest products');
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching nearest products: $e');
//   //     setState(() {
//   //       nearestProducts = [];
//   //       isLoadingNearestProducts = false;
//   //     });
//   //   }
//   // }




//   Future<void> fetchNearestProducts() async {
//   final userId = SharedPrefHelper.getUserId();
//   if (userId == null) {
//     print('User ID not found');
//     setState(() {
//       isLoadingNearestProducts = false;
//     });
//     return;
//   }

//   setState(() {
//     isLoadingNearestProducts = true;
//   });

//   try {
//     final response = await http.get(
//       Uri.parse('http://31.97.206.144:9174/api/nearest/user/$userId'),
//     );

//     print('Response status code for nearest products: ${response.statusCode}');
//     print('Response body for nearest products: ${response.body}');

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['success'] == true && data['products'] != null) {
//         setState(() {
//           nearestProducts = (data['products'] as List).map((product) {
//             String bed = '';
//             String bath = '';
//             String area = '';

//             if (product['features'] != null) {
//               for (var feature in product['features']) {
//                 String name = (feature['name']?.toString() ?? '').toLowerCase();
//                 if (name.contains('bedroom') || name.contains('bed')) {
//                   bed = feature['name']?.toString() ?? '';
//                 } else if (name.contains('bathroom') || name.contains('bath')) {
//                   bath = feature['name']?.toString() ?? '';
//                 } else if (name.contains('sqft') || name.contains('sq')) {
//                   area = feature['name']?.toString() ?? '';
//                 }
//               }
//             }

//             // FIX: Changed from 'image' to 'images' and get the first image
//             String imageUrl = '';
//             if (product['images'] != null && (product['images'] as List).isNotEmpty) {
//               imageUrl = product['images'][0].toString();
//             }

//             return {
//               'id': product['_id']?.toString() ?? '',
//               'imageUrl': imageUrl,  // Now using the correct field
//               'tag': product['type']?.toString() ?? 'For Sale',
//               'title': product['name']?.toString() ?? 'Unnamed Property',
//               'location': product['address']?.toString() ?? 'Unknown',
//               'price': '₹25,000',
//               'bed': bed.isNotEmpty ? bed : '4 Bed',
//               'bath': bath.isNotEmpty ? bath : '2 Bath',
//               'area': area.isNotEmpty ? area : '7,500 sqft',
//             };
//           }).toList();
//           isLoadingNearestProducts = false;
//         });
//       } else {
//         setState(() {
//           nearestProducts = [];
//           isLoadingNearestProducts = false;
//         });
//       }
//     } else {
//       throw Exception('Failed to load nearest products');
//     }
//   } catch (e) {
//     print('Error fetching nearest products: $e');
//     setState(() {
//       nearestProducts = [];
//       isLoadingNearestProducts = false;
//     });
//   }
// }

//   Future<void> fetchCategories() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:9174/api/auth/sub/all'),
//       );

//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['success'] == true) {
//           setState(() {
//             categories = List<Map<String, dynamic>>.from(
//               data['subCategories'].map((subCategory) => {
//                     'id': subCategory['_id'],
//                     'name': subCategory['name'],
//                     'image': subCategory['image'],
//                     'mainCategoryId': subCategory['category']['_id'],
//                     'mainCategoryName': subCategory['category']['name'],
//                   }),
//             );

//             isLoadingCategories = false;
//           });
//         } else {
//           isLoadingCategories = false;
//         }
//       } else {
//         isLoadingCategories = false;
//       }
//     } catch (e) {
//       print('Error fetching sub categories: $e');
//       setState(() {
//         isLoadingCategories = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final displayProducts = nearestProducts.isNotEmpty ? nearestProducts : [];
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isWeb = screenWidth > 600;
//     final maxWidth = isWeb ? 1200.0 : double.infinity;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         centerTitle: isWeb,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 10),
//           child: Consumer<ProfileProvider>(
//             builder: (context, profileProvider, _) {
//               final imageUrl = profileProvider.profileImageUrl;

//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const EditProfile()));
//                 },
//                 child: CircleAvatar(
//                   radius: 20,
//                   backgroundColor: Colors.grey.shade200,
//                   backgroundImage: imageUrl != null && imageUrl.isNotEmpty
//                       ? NetworkImage(imageUrl)
//                       : const AssetImage(
//                           'lib/assets/403079b6b3230e238d25d0e18c175d870e3223de.png',
//                         ) as ImageProvider,
//                   child: imageUrl == null || imageUrl.isEmpty
//                       ? const Icon(Icons.person, color: Colors.grey)
//                       : null,
//                 ),
//               );
//             },
//           ),
//         ),
//         title: Consumer<ProfileProvider>(
//           builder: (context, profileProvider, _) {
//             final userName = profileProvider.name ?? 'User';

//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   getGreeting(),
//                   style: const TextStyle(fontSize: 14, color: Colors.black54),
//                 ),
//                 Text(
//                   userName,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         actions: [
//           GestureDetector(
//             onTap: _handleLocationUpdate,
//             child: Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     border: Border.all(color: Colors.grey)),
//                 child: const Icon(Icons.location_on, color: Colors.black)),
//           ),
//           const SizedBox(width: 16),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const NotificationScreen()));
//             },
//             child: Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8)),
//               child: Stack(
//                 children: [
//                   const Center(
//                     child: Icon(Icons.notifications_none, color: Colors.black),
//                   ),
//                   Positioned(
//                     right: 8,
//                     top: 8,
//                     child: Container(
//                       width: 8,
//                       height: 8,
//                       decoration: const BoxDecoration(
//                         color: Colors.red,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 16),
//         ],
//       ),
//       body: Center(
//         child: ConstrainedBox(
//           constraints: BoxConstraints(maxWidth: maxWidth),
//           child: SingleChildScrollView(
//             padding: EdgeInsets.symmetric(horizontal: isWeb ? 24 : 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 12),
//                 _buildLocationContainer(),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         readOnly: true,
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const SearchScreen(),
//                             ),
//                           );
//                         },
//                         decoration: InputDecoration(
//                           hintText: 'Search',
//                           prefixIcon: const Icon(Icons.search),
//                           filled: true,
//                           fillColor: Colors.white,
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 221, 221, 221),
//                               width: 2,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 217, 216, 216),
//                               width: 2,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),

//                     // Expanded(
//                     //   child: TextField(
//                     //     decoration: InputDecoration(
//                     //       hintText: 'Search',
//                     //       prefixIcon: const Icon(Icons.search),
//                     //       filled: true,
//                     //       fillColor: Colors.white,
//                     //       enabledBorder: OutlineInputBorder(
//                     //         borderRadius: BorderRadius.circular(30),
//                     //         borderSide: const BorderSide(
//                     //           color: Color.fromARGB(255, 221, 221, 221),
//                     //           width: 2,
//                     //         ),
//                     //       ),
//                     //       focusedBorder: OutlineInputBorder(
//                     //         borderRadius: BorderRadius.circular(30),
//                     //         borderSide: const BorderSide(
//                     //           color: Color.fromARGB(255, 217, 216, 216),
//                     //           width: 2,
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   ),
//                     // ),
//                     const SizedBox(width: 10),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => FilterScreen()));
//                       },
//                       child: Container(
//                         width: 44,
//                         height: 44,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: LinearGradient(
//                             colors: [
//                               Color(0xFF00A8E8),
//                               Color(0xFF2BBBAD),
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                         ),
//                         child: const Center(
//                           child: Icon(
//                             Icons.tune,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 // const SizedBox(height: 16),
//                 // Center(
//                 //   child: GestureDetector(
//                 //       onTap: () {}, child: _choiceChip('Listora', true)),
//                 // ),
//                 const SizedBox(height: 20),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                         color: const Color.fromARGB(255, 191, 190, 190)),
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.shade200,
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       isLoadingCategories
//                           ? const Center(
//                               child: Padding(
//                                 padding: EdgeInsets.all(20.0),
//                                 child: CircularProgressIndicator(),
//                               ),
//                             )
//                           : isWeb
//                               ? Wrap(
//                                   spacing: 12,
//                                   runSpacing: 12,
//                                   alignment: WrapAlignment.center,
//                                   children: List.generate(
//                                     categories.take(4).length,
//                                     (index) {
//                                       final category = categories[index];

//                                       return _categoryIconFromApi(
//                                         isSelected: selectedIndex == index,
//                                         label: category['name'],
//                                         imageUrl: category['image'],
//                                         onTap: () {
//                                           Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   CreateListingScreen(
//                                                 subcategoryId: category['id'],
//                                                 name: category['name'],
//                                               ),
//                                             ),
//                                           );
//                                           // Navigator.push(
//                                           //     context,
//                                           //     MaterialPageRoute(
//                                           //         builder: (context) =>
//                                           //             CreateListingScreen(
//                                           //               subcategoryId:
//                                           //                   category['id'],
//                                           //                   name: category['name'],
//                                           //             )));
//                                           setState(() {
//                                             selectedIndex = index;
//                                           });
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 )
//                               : SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Row(
//                                     children: List.generate(
//                                       categories.take(4).length,
//                                       (index) {
//                                         final category = categories[index];

//                                         return Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 12),
//                                           child: _categoryIconFromApi(
//                                             isSelected: selectedIndex == index,
//                                             label: category['name'],
//                                             imageUrl: category['image'],
//                                             onTap: () {
//                                               Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                       builder: (context) =>
//                                                           CreateListingScreen(
//                                                             subcategoryId:
//                                                                 category['id'],
//                                                             name: category[
//                                                                 'name'],
//                                                           )));
//                                               setState(() {
//                                                 selectedIndex = index;
//                                               });
//                                             },
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                       const SizedBox(height: 16),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const CategoryScreen()));
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 16, vertical: 12),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey.shade300),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           child: const Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 'All Category',
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Color.fromARGB(255, 41, 41, 41),
//                                 ),
//                               ),
//                               Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 15,
//                                 color: Color.fromARGB(255, 0, 0, 0),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     const Text('Nearest Houses',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold)),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => NearestHouses()));
//                       },
//                       child: const Text('See All',
//                           style: TextStyle(color: Colors.black)),
//                     ),
//                     const SizedBox(width: 4),
//                     const Icon(
//                       Icons.arrow_forward_ios,
//                       size: 13,
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 isLoadingNearestProducts
//                     ? const Center(
//                         child: Padding(
//                           padding: EdgeInsets.all(40.0),
//                           child: Text(
//                             'No nearest Houses found nearby',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       )
//                     : displayProducts.isEmpty
//                         ? Center(
//                             child: Padding(
//                               padding: const EdgeInsets.all(40.0),
//                               child: Column(
//                                 children: [
//                                   Icon(
//                                     Icons.location_off,
//                                     size: 64,
//                                     color: Colors.grey.shade400,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   Text(
//                                     'No nearby properties found',
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Colors.grey.shade600,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     'Try updating your location',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey.shade500,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         : isWeb
//                             ? GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: screenWidth > 900 ? 3 : 2,
//                                   childAspectRatio: 0.75,
//                                   crossAxisSpacing: 16,
//                                   mainAxisSpacing: 16,
//                                 ),
//                                 itemCount: displayProducts.length,
//                                 itemBuilder: (context, index) {
//                                   final house = displayProducts[index];
//                                   return _buildPropertyCard(house);
//                                 },
//                               )
//                             : ListView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 itemCount: displayProducts.length,
//                                 itemBuilder: (context, index) {
//                                   final house = displayProducts[index];
//                                   return _buildPropertyCard(house);
//                                 },
//                               ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildPropertyCard(Map<String, dynamic> house) {
//     return Consumer<WishlistProvider>(
//       builder: (context, wishlistProvider, child) {
//         final isInWishlist = wishlistProvider.isInWishlist(house['id']);

//         return Container(
//           margin: const EdgeInsets.only(bottom: 16),
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.grey.shade300,
//               width: 1,
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const NearestHouses()));
//                     },
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(
//                         house['imageUrl'],
//                         height: 160,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             height: 160,
//                             width: double.infinity,
//                             color: Colors.grey.shade300,
//                             child: const Icon(
//                               Icons.home,
//                               size: 64,
//                               color: Colors.grey,
//                             ),
//                           );
//                         },
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) {
//                             return child;
//                           }
//                           return Container(
//                             height: 160,
//                             width: double.infinity,
//                             color: Colors.grey.shade200,
//                             child: const Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         house['tag'],
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 12),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 8,
//                     right: 8,
//                     child: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       child: wishlistProvider.isToggling
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 strokeWidth: 2,
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.red),
//                               ),
//                             )
//                           : IconButton(
//                               icon: Icon(
//                                 isInWishlist
//                                     ? Icons.favorite
//                                     : Icons.favorite_border,
//                                 color: isInWishlist ? Colors.red : Colors.black,
//                               ),
//                               onPressed: () async {
//                                 final success = await wishlistProvider
//                                     .toggleWishlist(house['id']);

//                                 if (context.mounted) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       backgroundColor:
//                                           success ? Colors.green : Colors.red,
//                                       content: Text(
//                                         success
//                                             ? (isInWishlist
//                                                 ? 'Removed from wishlist'
//                                                 : 'Added to wishlist')
//                                             : (wishlistProvider.errorMessage ??
//                                                 'Failed to update wishlist'),
//                                       ),
//                                       duration: const Duration(seconds: 2),
//                                       behavior: SnackBarBehavior.floating,
//                                     ),
//                                   );
//                                 }
//                               },
//                             ),
//                     ),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 house['title'],
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 15,
//                 ),
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const SizedBox(height: 6),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 4,
//                 children: [
//                   _iconText(Icons.bed_outlined, house['bed']),
//                   _iconText(Icons.bathtub_outlined, house['bath']),
//                   _iconText(Icons.square_foot, house['area']),
//                 ],
//               ),
//               const SizedBox(height: 6),
//               Row(
//                 children: [
//                   const Icon(Icons.location_on_outlined, size: 16),
//                   Expanded(
//                     child: Text(
//                       house['location'],
//                       style: const TextStyle(fontSize: 13),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildLocationContainer() {
//     return GestureDetector(
//       onTap: _handleLocationUpdate,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               Color(0xFF00A8E8),
//               Color(0xFF2BBBAD),
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFF00A8E8).withOpacity(0.3),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Icon(
//                 Icons.location_on,
//                 color: Colors.white,
//                 size: 20,
//               ),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Current Location',
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 11,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   isLoadingAddress
//                       ? const SizedBox(
//                           height: 16,
//                           width: 16,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor:
//                                 AlwaysStoppedAnimation<Color>(Colors.white),
//                           ),
//                         )
//                       : Text(
//                           currentAddress ?? 'Set your location',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                 ],
//               ),
//             ),
//             const Icon(
//               Icons.arrow_forward_ios,
//               color: Colors.white,
//               size: 16,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _categoryIconFromApi({
//     required bool isSelected,
//     required String label,
//     required String imageUrl,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 80,
//         height: 80,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(16),
//           color: isSelected ? null : const Color.fromARGB(255, 243, 243, 243),
//           gradient: isSelected
//               ? const LinearGradient(
//                   colors: [
//                     Color(0xFF00A8E8),
//                     Color(0xFF2BBBAD),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 )
//               : null,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.white,
//               child: ClipOval(
//                 child: Image.network(
//                   imageUrl,
//                   width: 20,
//                   height: 20,
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) {
//                     return Icon(
//                       Icons.category,
//                       size: 20,
//                       color:
//                           isSelected ? Colors.white : const Color(0xFF00A8E8),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 6),
//             Text(
//               label.length > 7 ? '${label.substring(0, 7)}.' : label,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: isSelected ? Colors.white : Colors.black,
//                 fontWeight: FontWeight.w600,
//               ),
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _choiceChip(String label, bool selected) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: selected ? Colors.transparent : const Color(0xFF00A8E8),
//           width: 1,
//         ),
//         gradient: selected
//             ? const LinearGradient(
//                 colors: [
//                   Color(0xFF00A8E8),
//                   Color(0xFF2BBBAD),
//                 ],
//               )
//             : null,
//         color: selected ? null : Colors.transparent,
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: selected ? Colors.white : const Color(0xFF00A8E8),
//           fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
//           fontSize: 14,
//         ),
//       ),
//     );
//   }

//   Widget _iconText(IconData icon, String label) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(icon, size: 12),
//           const SizedBox(width: 4),
//           Text(label, style: const TextStyle(fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }















import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/Provider/location/location_provider.dart';
import 'package:product_app/Provider/profile/profile_provider.dart';
import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/profile/edit_profile.dart';
import 'package:product_app/views/Buy/buy_screen.dart';
import 'package:product_app/views/Listing/listing_screen.dart';
import 'package:product_app/views/Notifications/notification_screen.dart';
import 'package:product_app/views/category/category_screen.dart';
import 'package:product_app/views/location/location_screen.dart';
import 'package:product_app/views/nearesthouses/nearest_houses.dart';
import 'package:product_app/views/search/filter_screen.dart';
import 'package:product_app/views/search/search_screen.dart';
import 'package:product_app/views/sell/sell_category.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

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
  int selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

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
    _loadCurrentLocation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadCurrentLocation() async {
    setState(() {
      isLoadingAddress = true;
    });

    try {
      final locationProvider = Provider.of<LocationProvider>(context, listen: false);

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          currentAddress = 'Location services are disabled';
          isLoadingAddress = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            currentAddress = 'Location permission denied';
            isLoadingAddress = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          currentAddress = 'Location permission permanently denied';
          isLoadingAddress = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      locationProvider.setManualLocation(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      await _getAddressFromCoordinates(position.latitude, position.longitude);
      await fetchNearestProducts();
    } catch (e) {
      print('Error loading location: $e');
      setState(() {
        currentAddress = 'Location unavailable';
      });
    } finally {
      setState(() {
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
        setState(() {
          currentAddress = [
            place.locality,
            place.administrativeArea,
          ].where((e) => e != null && e.isNotEmpty).take(2).join(', ');
        });
      }
    } catch (e) {
      print('Error getting address: $e');
      setState(() {
        currentAddress = 'Location unavailable';
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
      locationProvider.setManualLocation(
        latitude: result['latitude'] as double,
        longitude: result['longitude'] as double,
      );

      await fetchNearestProducts();
    }
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
      );

      print('Response status code for nearest products: ${response.statusCode}');
      print('Response body for nearest products: ${response.body}');

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
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> displayProducts = nearestProducts.isNotEmpty ? nearestProducts : [];
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 600;
    final maxWidth = isWeb ? 1200.0 : double.infinity;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: CustomScrollView(
                slivers: [
                  // Custom App Bar
                  SliverToBoxAdapter(
                    child: _buildCustomAppBar(),
                  ),
                  
                  // Location Banner
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isWeb ? 24 : 16, vertical: 12),
                      child: _buildModernLocationBanner(),
                    ),
                  ),
                  
                  // Search and Filter
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isWeb ? 24 : 16),
                      child: _buildSearchSection(),
                    ),
                  ),
                  
                  // Quick Stats
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isWeb ? 24 : 16, vertical: 20),
                      child: _buildQuickStatsSection(),
                    ),
                  ),
                  
                  // Categories Section
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isWeb ? 24 : 16),
                      child: _buildCategoriesSection(isWeb),
                    ),
                  ),
                  
                  // Featured Properties Header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(isWeb ? 24 : 16, 32, isWeb ? 24 : 16, 16),
                      child: _buildSectionHeader(
                        title: 'Featured Properties',
                        subtitle: 'Discover homes near you',
                        onSeeAll: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NearestHouses()),
                          );
                        },
                      ),
                    ),
                  ),
                  
                  // Properties Grid/List
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: isWeb ? 24 : 16),
                    sliver: _buildPropertiesSection(displayProducts, isWeb, screenWidth),
                  ),
                  
                  // Bottom Spacing
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
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
      child: Row(
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
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF00A8E8),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                        ? NetworkImage(imageUrl)
                        : null,
                    child: imageUrl == null || imageUrl.isEmpty
                        ? const Icon(Icons.person, color: Colors.grey, size: 28)
                        : null,
                  ),
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
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
          ),
          
          // Notification Icon
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F8FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Stack(
                children: [
                  const Icon(
                    Icons.notifications_outlined,
                    color: Color(0xFF00A8E8),
                    size: 26,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B6B),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotificationScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernLocationBanner() {
    return GestureDetector(
      onTap: _handleLocationUpdate,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00A8E8), Color(0xFF2BBBAD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00A8E8).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Location',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  isLoadingAddress
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          currentAddress ?? 'Set your location',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
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
                hintText: 'Search properties, locations...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14,
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: Colors.grey.shade600,
                  size: 24,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF00A8E8), Color(0xFF2BBBAD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00A8E8).withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.tune_rounded, color: Colors.white, size: 24),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterScreen()),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStatsSection() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.home_work_outlined,
            count: nearestProducts.length.toString(),
            label: 'Properties',
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.favorite_border,
            count: '${Provider.of<WishlistProvider>(context).wishlistCount}',
            label: 'Favorites',
            gradient: const LinearGradient(
              colors: [Color(0xFF4FACFE), Color(0xFF00F2FE)],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.visibility_outlined,
            count: '${categories.length}',
            label: 'Categories',
            gradient: const LinearGradient(
              colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String count,
    required String label,
    required Gradient gradient,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(bool isWeb) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          title: 'Explore Categories',
          subtitle: 'Find your perfect property type',
          onSeeAll: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CategoryScreen()),
            );
          },
        ),
        const SizedBox(height: 16),
        isLoadingCategories
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: CircularProgressIndicator(),
                ),
              )
            : isWeb
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: categories.take(8).length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return _buildModernCategoryCard(
                        category: category,
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateListingScreen(
                                subcategoryId: category['id'],
                                name: category['name'],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.take(8).length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            right: 12,
                            left: index == 0 ? 0 : 0,
                          ),
                          child: _buildModernCategoryCard(
                            category: category,
                            isSelected: selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateListingScreen(
                                    subcategoryId: category['id'],
                                    name: category['name'],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
      ],
    );
  }

  Widget _buildModernCategoryCard({
    required Map<String, dynamic> category,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00A8E8) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF00A8E8) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? const Color(0xFF00A8E8).withOpacity(0.3)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.2) : const Color(0xFFF0F8FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                category['image'],
                width: 32,
                height: 32,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) {
                  return Icon(
                    Icons.category_rounded,
                    size: 32,
                    color: isSelected ? Colors.white : const Color(0xFF00A8E8),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category['name'],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : const Color(0xFF1A1A1A),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    required VoidCallback onSeeAll,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onSeeAll,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F8FF),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00A8E8),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xFF00A8E8),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertiesSection(
    List<Map<String, dynamic>> displayProducts,
    bool isWeb,
    double screenWidth,
  ) {
    if (isLoadingNearestProducts) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    if (displayProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F8FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.home_work_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'No properties found nearby',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Try updating your location to discover properties',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (isWeb) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth > 900 ? 3 : 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _buildModernPropertyCard(displayProducts[index]);
          },
          childCount: displayProducts.length,
        ),
      );
    } else {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildModernPropertyCard(displayProducts[index]),
            );
          },
          childCount: displayProducts.length,
        ),
      );
    }
  }

  Widget _buildModernPropertyCard(Map<String, dynamic> house) {
    return Consumer<WishlistProvider>(
      builder: (context, wishlistProvider, child) {
        final isInWishlist = wishlistProvider.isInWishlist(house['id']);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NearestHouses()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
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
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Image.network(
                        house['imageUrl'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade200,
                                  Colors.grey.shade300,
                                ],
                              ),
                            ),
                            child: Icon(
                              Icons.home_work_outlined,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Tag
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00A8E8), Color(0xFF2BBBAD)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00A8E8).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          house['tag'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    // Wishlist Button
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
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
                        child: wishlistProvider.isToggling
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                  ),
                                ),
                              )
                            : IconButton(
                                icon: Icon(
                                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                                  color: isInWishlist ? Colors.red : Colors.grey.shade700,
                                ),
                                onPressed: () async {
                                  final success = await wishlistProvider.toggleWishlist(house['id']);
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
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },
                              ),
                      ),
                    ),
                  ],
                ),
                
                // Details Section
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        house['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A1A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              house['location'],
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildPropertyFeature(Icons.bed_outlined, house['bed']),
                          const SizedBox(width: 12),
                          _buildPropertyFeature(Icons.bathtub_outlined, house['bath']),
                          const SizedBox(width: 12),
                          _buildPropertyFeature(Icons.square_foot, house['area']),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Container(
                      //   padding: const EdgeInsets.all(12),
                      //   decoration: BoxDecoration(
                      //     color: const Color(0xFFF0F8FF),
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       Text(
                      //         house['price'],
                      //         style: const TextStyle(
                      //           fontSize: 18,
                      //           fontWeight: FontWeight.bold,
                      //           color: Color(0xFF00A8E8),
                      //         ),
                      //       ),
                      //       const Text(
                      //         '/month',
                      //         style: TextStyle(
                      //           fontSize: 12,
                      //           color: Color(0xFF00A8E8),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
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

  Widget _buildPropertyFeature(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}