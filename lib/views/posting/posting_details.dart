// // // ignore_for_file: deprecated_member_use

// // import 'package:flutter/material.dart';
// // import 'package:product_app/views/Buy/mobile_detail_screen.dart';
// // import 'package:product_app/views/Details/nearest_house_detail.dart';

// // class PostingDetails extends StatelessWidget {
// //   const PostingDetails({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //       length: 2,
// //       child: Scaffold(
// //         backgroundColor: Colors.white,
// //         appBar: AppBar(
// //           backgroundColor: Colors.white,
// //           elevation: 0,
// //           leading: IconButton(
// //             icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
// //             onPressed: () {
// //               Navigator.pop(context);
// //             },
// //           ),
// //           title: const Text(
// //             'My Postings',
// //             style: TextStyle(
// //               color: Colors.black,
// //               fontSize: 20,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           centerTitle: true,
// //           bottom: PreferredSize(
// //             preferredSize: const Size.fromHeight(60),
// //             child: Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //               height: 44,
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(25),
// //                 border: Border.all(color: Colors.grey.shade300, width: 1),
// //               ),
// //               child: TabBar(
// //                 indicator: BoxDecoration(
// //                   color: const Color(0xFF00BCD4),
// //                   borderRadius: BorderRadius.circular(25),
// //                 ),
// //                 indicatorSize: TabBarIndicatorSize.tab,
// //                 labelColor: Colors.white,
// //                 unselectedLabelColor: Colors.black87,
// //                 labelStyle: const TextStyle(
// //                   fontWeight: FontWeight.w600,
// //                   fontSize: 14,
// //                 ),
// //                 unselectedLabelStyle: const TextStyle(
// //                   fontWeight: FontWeight.w500,
// //                   fontSize: 14,
// //                 ),
// //                 dividerColor: Colors.transparent,
// //                 tabs: const [
// //                   Tab(
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(Icons.home_outlined, size: 18),
// //                         SizedBox(width: 6),
// //                         Text('Listings'),
// //                       ],
// //                     ),
// //                   ),
// //                   Tab(
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(Icons.grid_view_outlined, size: 18),
// //                         SizedBox(width: 6),
// //                         Text('Products'),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //         body: TabBarView(
// //           children: [
// //             _buildListingsTab(),
// //             _buildProductsTab(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   // Listings Tab (Favourite Screen UI)
// //   Widget _buildListingsTab() {
// //     final List<Map<String, dynamic>> houseList = List.generate(3, (_) {
// //       return {
// //         "title": "Luxury House LakeView Estate",
// //         "location": "Kakinada",
// //         "price": "₹4,00,000",
// //         "beds": "4 Bed",
// //         "baths": "3 Bath",
// //         "area": "7,500 sqft",
// //         "image": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// //       };
// //     });

// //     return ListView.builder(
// //       padding: const EdgeInsets.all(12),
// //       itemCount: houseList.length,
// //       itemBuilder: (context, index) {
// //         final house = houseList[index];
// //         return GestureDetector(
// //           onTap: () {
// //             Navigator.push(context, MaterialPageRoute(builder: (context)=>NearestHouseDetail()));
// //           },
// //           child: Container(
// //             margin: const EdgeInsets.only(bottom: 16),
// //             padding: const EdgeInsets.all(8),
// //             decoration: BoxDecoration(
// //               border: Border.all(
// //                 color: Colors.grey.shade300,
// //                 width: 1,
// //               ),
// //               borderRadius: BorderRadius.circular(12),
// //             ),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Stack(
// //                   children: [
// //                     ClipRRect(
// //                       borderRadius: BorderRadius.circular(10),
// //                       child: Image.asset(
// //                         house['image'],
// //                         height: 160,
// //                         width: double.infinity,
// //                         fit: BoxFit.cover,
// //                         errorBuilder: (context, error, stackTrace) {
// //                           return Container(
// //                             height: 160,
// //                             color: Colors.grey.shade300,
// //                             child: const Icon(Icons.image, size: 60),
// //                           );
// //                         },
// //                       ),
// //                     ),
// //                     Positioned(
// //                       top: 8,
// //                       left: 8,
// //                       child: Container(
// //                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(20),
// //                         ),
// //                         child: const Text(
// //                           "For Sale",
// //                           style: TextStyle(color: Colors.black, fontSize: 12),
// //                         ),
// //                       ),
// //                     ),
// //                     Positioned(
// //                       bottom: 1,
// //                       right: 1,
// //                       child: Container(
// //                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                         child: Text(
// //                           house['price'],
// //                           style: const TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 14,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     Positioned(
// //                       top: 8,
// //                       right: 8,
// //                       child: Container(
// //                         padding: const EdgeInsets.all(4),
// //                         decoration: const BoxDecoration(
// //                           color: Colors.white,
// //                           shape: BoxShape.circle,
// //                         ),
// //                         child: const Icon(
// //                           Icons.more_vert,
// //                           size: 20,
// //                           color: Colors.black,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 8),
// //                 Text(
// //                   house['title'],
// //                   style: const TextStyle(
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 15,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 6),
// //                 Row(
// //                   children: [
// //                     _iconText(Icons.bed_outlined, house['beds']),
// //                     const SizedBox(width: 8),
// //                     _iconText(Icons.bathtub_outlined, house['baths']),
// //                     const SizedBox(width: 8),
// //                     _iconText(Icons.square_foot, house['area']),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 6),
// //                 Row(
// //                   children: [
// //                     const Icon(Icons.location_on_outlined, size: 16, color: Colors.blue),
// //                     const SizedBox(width: 10),
// //                     Text(
// //                       house['location'],
// //                       style: const TextStyle(fontSize: 13),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   // Products Tab (Mobile Screen UI)
// //   Widget _buildProductsTab() {
// //     return GridView.builder(
// //       padding: const EdgeInsets.all(12),
// //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //         crossAxisCount: 2,
// //         childAspectRatio: 0.58,
// //         crossAxisSpacing: 12,
// //         mainAxisSpacing: 12,
// //       ),
// //       itemCount: 6,
// //       itemBuilder: (context, index) {
// //         final isRed = index % 2 == 1;
// //         return GestureDetector(
// //           onTap: () {
// //             Navigator.push(context, MaterialPageRoute(builder: (context)=>MobileDetailScreen()));
// //           },
// //           child: _buildProductCard(isRed));
// //       },
// //     );
// //   }

// //   Widget _buildProductCard(bool isRed) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.grey.withOpacity(0.1),
// //             spreadRadius: 1,
// //             blurRadius: 4,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Stack(
// //             children: [
// //               Container(
// //                 height: 150,
// //                 decoration: BoxDecoration(
// //                   color: isRed ? const Color(0xFFE8E8E8) : const Color(0xFFF5F5F5),
// //                   borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// //                 ),
// //                 child: Center(
// //                   child: isRed
// //                       ? Image.asset(
// //                           'lib/assets/iphone14pro.jpg',
// //                           height: 130,
// //                           fit: BoxFit.contain,
// //                           errorBuilder: (context, error, stackTrace) {
// //                             return Container(
// //                               width: 90,
// //                               height: 130,
// //                               decoration: BoxDecoration(
// //                                 color: Colors.red.shade900.withOpacity(0.3),
// //                                 borderRadius: BorderRadius.circular(20),
// //                               ),
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   Container(
// //                                     width: 35,
// //                                     height: 35,
// //                                     decoration: BoxDecoration(
// //                                       color: Colors.red.shade900.withOpacity(0.5),
// //                                       borderRadius: BorderRadius.circular(8),
// //                                     ),
// //                                   ),
// //                                   const SizedBox(height: 8),
// //                                   Container(
// //                                     width: 30,
// //                                     height: 30,
// //                                     decoration: BoxDecoration(
// //                                       color: Colors.red.shade900.withOpacity(0.5),
// //                                       shape: BoxShape.circle,
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             );
// //                           },
// //                         )
// //                       : Image.asset(
// //                           'lib/assets/iphone13.jpg',
// //                           height: 130,
// //                           fit: BoxFit.contain,
// //                           errorBuilder: (context, error, stackTrace) {
// //                             return Container(
// //                               width: 75,
// //                               height: 130,
// //                               decoration: BoxDecoration(
// //                                 color: Colors.grey.shade700,
// //                                 borderRadius: BorderRadius.circular(20),
// //                               ),
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.start,
// //                                 children: [
// //                                   const SizedBox(height: 12),
// //                                   Container(
// //                                     width: 28,
// //                                     height: 28,
// //                                     decoration: BoxDecoration(
// //                                       color: Colors.grey.shade800,
// //                                       borderRadius: BorderRadius.circular(8),
// //                                     ),
// //                                   ),
// //                                 ],
// //                               ),
// //                             );
// //                           },
// //                         ),
// //                 ),
// //               ),
// //               Positioned(
// //                 top: 8,
// //                 right: 8,
// //                 child: Container(
// //                   padding: const EdgeInsets.all(6),
// //                   decoration: const BoxDecoration(
// //                     color: Colors.white,
// //                     shape: BoxShape.circle,
// //                   ),
// //                   child: const Icon(
// //                     Icons.more_vert,
// //                     size: 16,
// //                     color: Colors.black,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.all(10.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   isRed ? 'Iphone 14 Pro Max' : 'Iphone 16 Pro Max',
// //                   style: const TextStyle(
// //                     fontSize: 13,
// //                     fontWeight: FontWeight.w500,
// //                     color: Colors.black87,
// //                   ),
// //                   maxLines: 1,
// //                   overflow: TextOverflow.ellipsis,
// //                 ),
// //                 const SizedBox(height: 3),
// //                 const Text(
// //                   '₹40000',
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontWeight: FontWeight.w700,
// //                     color: Colors.black,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 6),
// //                 Row(
// //                   children: [
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
// //                       decoration: BoxDecoration(
// //                         color: Colors.grey.shade200,
// //                         borderRadius: BorderRadius.circular(4),
// //                       ),
// //                       child: const Text(
// //                         'New',
// //                         style: TextStyle(
// //                           fontSize: 10,
// //                           color: Colors.black87,
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 6),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
// //                       decoration: BoxDecoration(
// //                         color: Colors.grey.shade200,
// //                         borderRadius: BorderRadius.circular(4),
// //                       ),
// //                       child: const Text(
// //                         '10/10',
// //                         style: TextStyle(
// //                           fontSize: 10,
// //                           color: Colors.black87,
// //                           fontWeight: FontWeight.w500,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 const SizedBox(height: 6),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     const Flexible(
// //                       child: Text(
// //                         'Hyderabad',
// //                         style: TextStyle(
// //                           fontSize: 11,
// //                           color: Colors.black54,
// //                         ),
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                     ),
// //                     Text(
// //                       '22 Sep',
// //                       style: TextStyle(
// //                         fontSize: 11,
// //                         color: Colors.grey.shade600,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
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
// //           Icon(icon, size: 14),
// //           const SizedBox(width: 4),
// //           Text(label, style: const TextStyle(fontSize: 12)),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:product_app/views/Buy/mobile_detail_screen.dart';
// import 'package:product_app/views/Details/nearest_house_detail.dart';

// class PostingDetails extends StatelessWidget {
//   const PostingDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//           title: const Text(
//             'My Postings',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(60),
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               height: 44,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: Colors.grey.shade300, width: 1),
//               ),
//               child: TabBar(
//                 indicator: BoxDecoration(
//                   color: const Color(0xFF00BCD4),
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.black87,
//                 labelStyle: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//                 unselectedLabelStyle: const TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                 ),
//                 dividerColor: Colors.transparent,
//                 tabs: const [
//                   Tab(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.schedule_outlined, size: 18),
//                         SizedBox(width: 6),
//                         Text('Pending'),
//                       ],
//                     ),
//                   ),
//                   Tab(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.check_circle_outline, size: 18),
//                         SizedBox(width: 6),
//                         Text('Approved'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             _buildListingsTab(),
//             _buildProductsTab(),
//           ],
//         ),
//       ),
//     );
//   }

//   // Listings Tab (Favourite Screen UI)
//   Widget _buildListingsTab() {
//     final List<Map<String, dynamic>> houseList = List.generate(3, (_) {
//       return {
//         "title": "Luxury House LakeView Estate",
//         "location": "Kakinada",
//         "price": "₹4,00,000",
//         "beds": "4 Bed",
//         "baths": "3 Bath",
//         "area": "7,500 sqft",
//         "image": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
//       };
//     });

//     return ListView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: houseList.length,
//       itemBuilder: (context, index) {
//         final house = houseList[index];
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>NearestHouseDetail()));
//           },
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 16),
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: Colors.grey.shade300,
//                 width: 1,
//               ),
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Stack(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.asset(
//                         house['image'],
//                         height: 160,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             height: 160,
//                             color: Colors.grey.shade300,
//                             child: const Icon(Icons.image, size: 60),
//                           );
//                         },
//                       ),
//                     ),
//                     Positioned(
//                       top: 8,
//                       left: 8,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: const Text(
//                           "For Sale",
//                           style: TextStyle(color: Colors.black, fontSize: 12),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 1,
//                       right: 1,
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           house['price'],
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 8,
//                       right: 8,
//                       child: Container(
//                         padding: const EdgeInsets.all(4),
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.more_vert,
//                           size: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   house['title'],
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 15,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     _iconText(Icons.bed_outlined, house['beds']),
//                     const SizedBox(width: 8),
//                     _iconText(Icons.bathtub_outlined, house['baths']),
//                     const SizedBox(width: 8),
//                     _iconText(Icons.square_foot, house['area']),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     const Icon(Icons.location_on_outlined, size: 16, color: Colors.blue),
//                     const SizedBox(width: 10),
//                     Text(
//                       house['location'],
//                       style: const TextStyle(fontSize: 13),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Products Tab (Mobile Screen UI)
//   Widget _buildProductsTab() {
//     return GridView.builder(
//       padding: const EdgeInsets.all(12),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         childAspectRatio: 0.58,
//         crossAxisSpacing: 12,
//         mainAxisSpacing: 12,
//       ),
//       itemCount: 6,
//       itemBuilder: (context, index) {
//         final isRed = index % 2 == 1;
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context)=>MobileDetailScreen()));
//           },
//           child: _buildProductCard(isRed));
//       },
//     );
//   }

//   Widget _buildProductCard(bool isRed) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//               Container(
//                 height: 150,
//                 decoration: BoxDecoration(
//                   color: isRed ? const Color(0xFFE8E8E8) : const Color(0xFFF5F5F5),
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 ),
//                 child: Center(
//                   child: isRed
//                       ? Image.asset(
//                           'lib/assets/iphone14pro.jpg',
//                           height: 130,
//                           fit: BoxFit.contain,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: 90,
//                               height: 130,
//                               decoration: BoxDecoration(
//                                 color: Colors.red.shade900.withOpacity(0.3),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     width: 35,
//                                     height: 35,
//                                     decoration: BoxDecoration(
//                                       color: Colors.red.shade900.withOpacity(0.5),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Container(
//                                     width: 30,
//                                     height: 30,
//                                     decoration: BoxDecoration(
//                                       color: Colors.red.shade900.withOpacity(0.5),
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         )
//                       : Image.asset(
//                           'lib/assets/iphone13.jpg',
//                           height: 130,
//                           fit: BoxFit.contain,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               width: 75,
//                               height: 130,
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade700,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 12),
//                                   Container(
//                                     width: 28,
//                                     height: 28,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade800,
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 right: 8,
//                 child: Container(
//                   padding: const EdgeInsets.all(6),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.more_vert,
//                     size: 16,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   isRed ? 'Iphone 14 Pro Max' : 'Iphone 16 Pro Max',
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black87,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 3),
//                 const Text(
//                   '₹40000',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.black,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: const Text(
//                         'New',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 6),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: const Text(
//                         '10/10',
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.black87,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Flexible(
//                       child: Text(
//                         'Hyderabad',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.black54,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Text(
//                       '22 Sep',
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
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
//         children: [
//           Icon(icon, size: 14),
//           const SizedBox(width: 4),
//           Text(label, style: const TextStyle(fontSize: 12)),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/views/Buy/mobile_detail_screen.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:product_app/views/Details/product_detail_screen.dart';

class PostingDetails extends StatefulWidget {
  const PostingDetails({super.key});

  @override
  State<PostingDetails> createState() => _PostingDetailsState();
}

class _PostingDetailsState extends State<PostingDetails> {
  List<dynamic> pendingProducts = [];
  List<dynamic> approvedProducts = [];
  bool isPendingLoading = true;
  bool isApprovedLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final userId = SharedPrefHelper.getUserId();
    final token = SharedPrefHelper.getToken();

    if (userId == null || token == null) {
      setState(() {
        errorMessage = 'User not authenticated';
        isPendingLoading = false;
        isApprovedLoading = false;
      });
      return;
    }

    // Load both pending and approved products
    await Future.wait([
      _fetchProducts(userId, token, isPending: true),
      _fetchProducts(userId, token, isPending: false),
    ]);
  }

  Future<void> _fetchProducts(String userId, String token,
      {required bool isPending}) async {
    final endpoint = isPending ? 'pending' : 'approved';
    final url =
        'http://31.97.206.144:9174/api/auth/products/user/$userId/$endpoint';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          if (isPending) {
            pendingProducts = data['products'] ?? [];
            isPendingLoading = false;
          } else {
            approvedProducts = data['products'] ?? [];
            isApprovedLoading = false;
          }
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load products';
          if (isPending) {
            isPendingLoading = false;
          } else {
            isApprovedLoading = false;
          }
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        if (isPending) {
          isPendingLoading = false;
        } else {
          isApprovedLoading = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'My Postings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color(0xFF00BCD4),
                  borderRadius: BorderRadius.circular(25),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black87,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.schedule_outlined, size: 18),
                        SizedBox(width: 6),
                        Text('Pending'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, size: 18),
                        SizedBox(width: 6),
                        Text('Approved'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildPendingTab(),
            _buildApprovedTab(),
          ],
        ),
      ),
    );
  }

  // Pending Tab
  Widget _buildPendingTab() {
    if (isPendingLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (pendingProducts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No pending products'),
          ],
        ),
      );
    }

    // Check if products are houses or mobiles based on subcategory
    final isHouseCategory =
        pendingProducts.first['subCategory']?['name'] == 'Houses' ||
            pendingProducts.first['subCategory']?['name'] == 'Real Estate';

    if (isHouseCategory) {
      return _buildListingsTab(pendingProducts);
    } else {
      return _buildProductsTab(pendingProducts);
    }
  }

  // Approved Tab
  Widget _buildApprovedTab() {
    if (isApprovedLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadProducts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (approvedProducts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No approved products'),
          ],
        ),
      );
    }

    // Check if products are houses or mobiles based on subcategory
    final isHouseCategory =
        approvedProducts.first['subCategory']?['name'] == 'Houses' ||
            approvedProducts.first['subCategory']?['name'] == 'Real Estate';

    if (isHouseCategory) {
      return _buildListingsTab(approvedProducts);
    } else {
      return _buildProductsTab(approvedProducts);
    }
  }

  // Listings Tab (House View)
  Widget _buildListingsTab(List<dynamic> products) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final images = product['images'] as List<dynamic>? ?? [];
        final imageUrl = images.isNotEmpty ? images[0] : '';

        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => NearestHouseDetail()),
            // );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 160,
                                  color: Colors.grey.shade300,
                                  child: const Icon(Icons.image, size: 60),
                                );
                              },
                            )
                          : Container(
                              height: 160,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.image, size: 60),
                            ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "For ${product['type'] ?? 'Sale'}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.more_vert,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  product['name'] ?? 'No Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                if (product['features'] != null &&
                    (product['features'] as List).isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: (product['features'] as List).map((feature) {
                      return _iconText(Icons.info_outline, feature.toString());
                    }).toList(),
                  ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 16, color: Colors.blue),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        product['address'] ?? 'No location',
                        style: const TextStyle(fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Products Tab (Mobile/Product Grid View)
  Widget _buildProductsTab(List<dynamic> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                        product: product,
                      )),
            );
          },
          child: _buildProductCard(product),
        );
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final images = product['images'] as List<dynamic>? ?? [];
    final imageUrl = images.isNotEmpty ? images[0] : '';
    final createdAt = product['createdAt'] as String?;
    String formattedDate = '';

    if (createdAt != null) {
      try {
        final date = DateTime.parse(createdAt);
        formattedDate = '${date.day} ${_getMonthName(date.month)}';
      } catch (e) {
        formattedDate = '';
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          height: 130,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 75,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(Icons.image, size: 40),
                            );
                          },
                        )
                      : Container(
                          width: 75,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(Icons.image, size: 40),
                        ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'] ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  product['price'] != null ? '₹${product['price']}' : '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        product['type'] ?? 'Sale',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    if (product['subCategory'] != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product['subCategory']['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        product['address'] ?? 'No location',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (formattedDate.isNotEmpty)
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
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
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  Widget _iconText(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
















// lib/views/postings/posting_details.dart

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:product_app/Provider/product/product_provider.dart';
// import 'package:product_app/model/product_model.dart';
// import 'package:product_app/views/Details/nearest_house_detail.dart';
// import 'package:product_app/views/Buy/mobile_detail_screen.dart';

// class PostingDetails extends StatefulWidget {
//   const PostingDetails({super.key});

//   @override
//   State<PostingDetails> createState() => _PostingDetailsState();
// }

// class _PostingDetailsState extends State<PostingDetails> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch user's products when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<ProductProvider>().fetchUserProducts();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: const Text(
//             'My Postings',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.refresh, color: Colors.black),
//               onPressed: () {
//                 context.read<ProductProvider>().fetchUserProducts();
//               },
//             ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(60),
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               height: 44,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: Colors.grey.shade300, width: 1),
//               ),
//               child: TabBar(
//                 indicator: BoxDecoration(
//                   color: const Color(0xFF00BCD4),
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 labelColor: Colors.white,
//                 unselectedLabelColor: Colors.black87,
//                 labelStyle: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 14,
//                 ),
//                 unselectedLabelStyle: const TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                 ),
//                 dividerColor: Colors.transparent,
//                 tabs: const [
//                   Tab(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.schedule_outlined, size: 18),
//                         SizedBox(width: 6),
//                         Text('Pending'),
//                       ],
//                     ),
//                   ),
//                   Tab(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.check_circle_outline, size: 18),
//                         SizedBox(width: 6),
//                         Text('Approved'),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         body: Consumer<ProductProvider>(
//           builder: (context, provider, child) {
//             if (provider.isLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   color: Color(0xFF00BCD4),
//                 ),
//               );
//             }

//             if (provider.hasError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.error_outline, size: 60, color: Colors.red),
//                     const SizedBox(height: 16),
//                     Text(
//                       provider.errorMessage ?? 'Failed to load postings',
//                       style: const TextStyle(fontSize: 16),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () => provider.fetchUserProducts(),
//                       child: const Text('Retry'),
//                     ),
//                   ],
//                 ),
//               );
//             }

//             return TabBarView(
//               children: [
//                 _buildPendingListings(provider.products),
//                 _buildApprovedListings(provider.products),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // Pending Listings (Not Approved)
//   Widget _buildPendingListings(List<Product> allProducts) {
//     final pendingProducts = allProducts.where((p) => !p.isApproved).toList();

//     if (pendingProducts.isEmpty) {
//       return _buildEmptyState('No pending listings', Icons.schedule_outlined);
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: pendingProducts.length,
//       itemBuilder: (context, index) {
//         final product = pendingProducts[index];
//         return _buildProductCard(product, isPending: true);
//       },
//     );
//   }

//   // Approved Listings
//   Widget _buildApprovedListings(List<Product> allProducts) {
//     final approvedProducts = allProducts.where((p) => p.isApproved).toList();

//     if (approvedProducts.isEmpty) {
//       return _buildEmptyState('No approved listings', Icons.check_circle_outline);
//     }

//     return ListView.builder(
//       padding: const EdgeInsets.all(12),
//       itemCount: approvedProducts.length,
//       itemBuilder: (context, index) {
//         final product = approvedProducts[index];
//         return _buildProductCard(product, isPending: false);
//       },
//     );
//   }

//   Widget _buildProductCard(Product product, {required bool isPending}) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to product detail screen
//         context.read<ProductProvider>().selectProduct(product);
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => NearestHouseDetail(),
//           ),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isPending ? Colors.orange.shade300 : Colors.grey.shade300,
//             width: 1.5,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: product.images.isNotEmpty
//                       ? Image.network(
//                           product.images.first,
//                           height: 160,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               height: 160,
//                               color: Colors.grey.shade300,
//                               child: const Icon(Icons.image, size: 60),
//                             );
//                           },
//                           loadingBuilder: (context, child, loadingProgress) {
//                             if (loadingProgress == null) return child;
//                             return Container(
//                               height: 160,
//                               color: Colors.grey.shade200,
//                               child: const Center(
//                                 child: CircularProgressIndicator(),
//                               ),
//                             );
//                           },
//                         )
//                       : Container(
//                           height: 160,
//                           color: Colors.grey.shade300,
//                           child: const Icon(Icons.image, size: 60),
//                         ),
//                 ),
//                 // Status Badge
//                 Positioned(
//                   top: 8,
//                   left: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: isPending ? Colors.orange : Colors.green,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       isPending ? "Pending" : "Approved",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Type Badge (Sale/Rent)
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       "For ${product.type}",
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ),
//                 // More Options
//                 Positioned(
//                   bottom: 8,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: () => _showOptionsMenu(context, product),
//                     child: Container(
//                       padding: const EdgeInsets.all(4),
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         shape: BoxShape.circle,
//                       ),
//                       child: const Icon(
//                         Icons.more_vert,
//                         size: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               product.name,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: 15,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               product.description,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey.shade600,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//             // Features
//             if (product.features.isNotEmpty)
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 4,
//                 children: product.features.take(3).map((feature) {
//                   return _iconText(Icons.check_circle_outline, feature.name);
//                 }).toList(),
//               ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.location_on_outlined, size: 16, color: Colors.blue),
//                 const SizedBox(width: 4),
//                 Expanded(
//                   child: Text(
//                     product.address,
//                     style: const TextStyle(fontSize: 13),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 4),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Posted on ${_formatDate(product.createdAt)}',
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: product.isActive ? Colors.green.shade50 : Colors.red.shade50,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     product.isActive ? 'Active' : 'Inactive',
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: product.isActive ? Colors.green.shade700 : Colors.red.shade700,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(String message, IconData icon) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 80, color: Colors.grey.shade400),
//           const SizedBox(height: 16),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey.shade600,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Create a new listing to get started',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey.shade500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showOptionsMenu(BuildContext context, Product product) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.edit, color: Color(0xFF00BCD4)),
//                 title: const Text('Edit Listing'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   // TODO: Navigate to edit screen
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Edit feature coming soon')),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   product.isActive ? Icons.visibility_off : Icons.visibility,
//                   color: Colors.orange,
//                 ),
//                 title: Text(product.isActive ? 'Deactivate' : 'Activate'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   // TODO: Toggle active status
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         product.isActive
//                             ? 'Deactivate feature coming soon'
//                             : 'Activate feature coming soon',
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.delete, color: Colors.red),
//                 title: const Text('Delete Listing'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   _confirmDelete(context, product);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _confirmDelete(BuildContext context, Product product) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Delete Listing'),
//           content: Text('Are you sure you want to delete "${product.name}"?'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 // TODO: Implement delete functionality
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Delete feature coming soon')),
//                 );
//               },
//               style: TextButton.styleFrom(foregroundColor: Colors.red),
//               child: const Text('Delete'),
//             ),
//           ],
//         );
//       },
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
//           Icon(icon, size: 14, color: Colors.grey.shade700),
//           const SizedBox(width: 4),
//           Text(
//             label,
//             style: const TextStyle(fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatDate(DateTime date) {
//     final now = DateTime.now();
//     final difference = now.difference(date);

//     if (difference.inDays == 0) {
//       return 'Today';
//     } else if (difference.inDays == 1) {
//       return 'Yesterday';
//     } else if (difference.inDays < 7) {
//       return '${difference.inDays} days ago';
//     } else {
//       return '${date.day}/${date.month}/${date.year}';
//     }
//   }
// }