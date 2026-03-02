// import 'package:flutter/material.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final Map<String, dynamic> product;

//   const ProductDetailScreen({super.key, required this.product});

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   int _currentImageIndex = 0;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   String _formatDate(String? dateStr) {
//     if (dateStr == null) return '';
//     try {
//       final date = DateTime.parse(dateStr);
//       const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
//       return '${date.day} ${months[date.month - 1]} ${date.year}';
//     } catch (e) {
//       return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final images = widget.product['images'] as List<dynamic>? ?? [];
//     final imageUrls = images.map((e) => e.toString()).toList();
//     final isHouseCategory = widget.product['subCategory']?['name'] == 'Houses' ||
//         widget.product['subCategory']?['name'] == 'Real Estate';

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: CustomScrollView(
//         slivers: [
//           // App Bar with Image Carousel
//           SliverAppBar(
//             expandedHeight: 300,
//             pinned: true,
//             backgroundColor: Colors.white,
//             leading: IconButton(
//               icon: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
//               ),
//               onPressed: () => Navigator.pop(context),
//             ),
//             actions: [
//               // IconButton(
//               //   icon: Container(
//               //     padding: const EdgeInsets.all(8),
//               //     decoration: BoxDecoration(
//               //       color: Colors.white,
//               //       shape: BoxShape.circle,
//               //       boxShadow: [
//               //         BoxShadow(
//               //           color: Colors.black.withOpacity(0.1),
//               //           blurRadius: 8,
//               //           offset: const Offset(0, 2),
//               //         ),
//               //       ],
//               //     ),
//               //     child: const Icon(Icons.share_outlined, size: 18, color: Colors.black),
//               //   ),
//               //   onPressed: () {},
//               // ),
//               const SizedBox(width: 8),
//             ],
//             flexibleSpace: FlexibleSpaceBar(
//               background: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   if (imageUrls.isNotEmpty)
//                     PageView.builder(
//                       controller: _pageController,
//                       onPageChanged: (index) {
//                         setState(() {
//                           _currentImageIndex = index;
//                         });
//                       },
//                       itemCount: imageUrls.length,
//                       itemBuilder: (context, index) {
//                         return Image.network(
//                           imageUrls[index],
//                           fit: BoxFit.cover,
//                           errorBuilder: (context, error, stackTrace) {
//                             return Container(
//                               color: Colors.grey.shade200,
//                               child: const Center(
//                                 child: Icon(Icons.image_outlined, size: 80, color: Colors.grey),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     )
//                   else
//                     Container(
//                       color: Colors.grey.shade200,
//                       child: const Center(
//                         child: Icon(Icons.image_outlined, size: 80, color: Colors.grey),
//                       ),
//                     ),
//                   // Image indicator
//                   if (imageUrls.length > 1)
//                     Positioned(
//                       bottom: 16,
//                       left: 0,
//                       right: 0,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                           imageUrls.length,
//                           (index) => Container(
//                             margin: const EdgeInsets.symmetric(horizontal: 3),
//                             width: 8,
//                             height: 8,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: _currentImageIndex == index
//                                   ? Colors.white
//                                   : Colors.white.withOpacity(0.4),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),

//           // Content
//           SliverToBoxAdapter(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Price and Title Section
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFF00BCD4).withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                               border: Border.all(color: const Color(0xFF00BCD4)),
//                             ),
//                             child: Text(
//                               widget.product['type'] ?? 'Sale',
//                               style: const TextStyle(
//                                 color: Color(0xFF00BCD4),
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           if (widget.product['status'] != null)
//                             Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                               decoration: BoxDecoration(
//                                 color: widget.product['status'] == 'approved'
//                                     ? Colors.green.withOpacity(0.1)
//                                     : Colors.orange.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 widget.product['status'] ?? '',
//                                 style: TextStyle(
//                                   color: widget.product['status'] == 'approved'
//                                       ? Colors.green
//                                       : Colors.orange,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         widget.product['name'] ?? 'Product Name',
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         widget.product['price'] != null
//                             ? '₹${widget.product['price']}'
//                             : 'Price not available',
//                         style: const TextStyle(
//                           fontSize: 26,
//                           fontWeight: FontWeight.w700,
//                           color: Color(0xFF00BCD4),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           const Icon(Icons.access_time, size: 16, color: Colors.grey),
//                           const SizedBox(width: 6),
//                           Text(
//                             'Posted on ${_formatDate(widget.product['createdAt'])}',
//                             style: TextStyle(
//                               fontSize: 13,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Divider(height: 1, thickness: 1),

//                 // Location Section
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Location',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           Icon(Icons.location_on, size: 20, color: Colors.red.shade400),
//                           const SizedBox(width: 8),
//                           Expanded(
//                             child: Text(
//                               widget.product['address'] ?? 'Location not specified',
//                               style: const TextStyle(
//                                 fontSize: 15,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 const Divider(height: 1, thickness: 1),

//                 // Description Section
//                 if (widget.product['description'] != null && 
//                     widget.product['description'].toString().isNotEmpty)
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Description',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           widget.product['description'] ?? '',
//                           style: const TextStyle(
//                             fontSize: 15,
//                             color: Colors.black87,
//                             height: 1.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                 if (widget.product['description'] != null && 
//                     widget.product['description'].toString().isNotEmpty)
//                   const Divider(height: 1, thickness: 1),

//                 // Features Section (for houses)
//                 if (isHouseCategory && 
//                     widget.product['features'] != null && 
//                     (widget.product['features'] as List).isNotEmpty)
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Features',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children: (widget.product['features'] as List).map((feature) {
//                             return Container(
//                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                               decoration: BoxDecoration(
//                                 color: Colors.grey.shade100,
//                                 borderRadius: BorderRadius.circular(20),
//                                 border: Border.all(color: Colors.grey.shade300),
//                               ),
//                               child: Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(Icons.check_circle, size: 16, color: Colors.green.shade600),
//                                   const SizedBox(width: 6),
//                                   Text(
//                                     feature.toString(),
//                                     style: const TextStyle(
//                                       fontSize: 13,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     ),
//                   ),

//                 if (isHouseCategory && 
//                     widget.product['features'] != null && 
//                     (widget.product['features'] as List).isNotEmpty)
//                   const Divider(height: 1, thickness: 1),

//                 // Details Section
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         'Details',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       _buildDetailRow('Category', widget.product['category']?['name'] ?? 'N/A'),
//                       _buildDetailRow('Sub Category', widget.product['subCategory']?['name'] ?? 'N/A'),
//                       if (widget.product['brand'] != null)
//                         _buildDetailRow('Brand', widget.product['brand']),
//                       if (widget.product['model'] != null)
//                         _buildDetailRow('Model', widget.product['model']),
//                       if (widget.product['condition'] != null)
//                         _buildDetailRow('Condition', widget.product['condition']),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 80),
//               ],
//             ),
//           ),
//         ],
//       ),
//       // bottomNavigationBar: Container(
//       //   padding: const EdgeInsets.all(16),
//       //   decoration: BoxDecoration(
//       //     color: Colors.white,
//       //     boxShadow: [
//       //       BoxShadow(
//       //         color: Colors.black.withOpacity(0.05),
//       //         blurRadius: 10,
//       //         offset: const Offset(0, -5),
//       //       ),
//       //     ],
//       //   ),
//       //   child: Row(
//       //     children: [
//       //       Expanded(
//       //         child: OutlinedButton(
//       //           onPressed: () {
//       //             // Edit functionality
//       //           },
//       //           style: OutlinedButton.styleFrom(
//       //             padding: const EdgeInsets.symmetric(vertical: 14),
//       //             side: const BorderSide(color: Color(0xFF00BCD4), width: 2),
//       //             shape: RoundedRectangleBorder(
//       //               borderRadius: BorderRadius.circular(12),
//       //             ),
//       //           ),
//       //           child: const Text(
//       //             'Edit',
//       //             style: TextStyle(
//       //               color: Color(0xFF00BCD4),
//       //               fontSize: 16,
//       //               fontWeight: FontWeight.w600,
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //       const SizedBox(width: 12),
//       //       Expanded(
//       //         child: ElevatedButton(
//       //           onPressed: () {
//       //             // Delete functionality
//       //             _showDeleteDialog(context);
//       //           },
//       //           style: ElevatedButton.styleFrom(
//       //             backgroundColor: Colors.red,
//       //             padding: const EdgeInsets.symmetric(vertical: 14),
//       //             shape: RoundedRectangleBorder(
//       //               borderRadius: BorderRadius.circular(12),
//       //             ),
//       //             elevation: 0,
//       //           ),
//       //           child: const Text(
//       //             'Delete',
//       //             style: TextStyle(
//       //               color: Colors.white,
//       //               fontSize: 16,
//       //               fontWeight: FontWeight.w600,
//       //             ),
//       //           ),
//       //         ),
//       //       ),
//       //     ],
//       //   ),
//       // ),
//     );
//   }

//   Widget _buildDetailRow(String label, String? value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: 120,
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value ?? 'N/A',
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.black87,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showDeleteDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: const Text(
//             'Delete Product',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           content: const Text(
//             'Are you sure you want to delete this product? This action cannot be undone.',
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//                 // Implement delete functionality here
//                 // You can call your delete API
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text(
//                 'Delete',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }























import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentImageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.product['images'] as List<dynamic>? ?? [];
    final imageUrls = images.map((e) => e.toString()).toList();
    final isHouseCategory = widget.product['subCategory']?['name'] == 'Houses' ||
        widget.product['subCategory']?['name'] == 'Real Estate';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Modern Image Carousel Header
              SliverAppBar(
                expandedHeight: 380,
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.black87),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white.withOpacity(0.95),
                  //       shape: BoxShape.circle,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.15),
                  //           blurRadius: 12,
                  //           offset: const Offset(0, 4),
                  //         ),
                  //       ],
                  //     ),
                  //     child: IconButton(
                  //       icon: const Icon(Icons.favorite_border, size: 22, color: Colors.black87),
                  //       onPressed: () {},
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (imageUrls.isNotEmpty)
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              imageUrls[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.grey.shade200,
                                        Colors.grey.shade300,
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.image_outlined, size: 100, color: Colors.grey.shade400),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey.shade200,
                                Colors.grey.shade300,
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(Icons.image_outlined, size: 100, color: Colors.grey.shade400),
                          ),
                        ),
                      // Gradient overlay at bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Image counter
                      if (imageUrls.length > 1)
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: Text(
                              '${_currentImageIndex + 1}/${imageUrls.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      // Image indicators
                      if (imageUrls.length > 1)
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  imageUrls.length > 5 ? 5 : imageUrls.length,
                                  (index) => Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 3),
                                    width: _currentImageIndex == index ? 24 : 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: _currentImageIndex == index
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Price Card with elegant design
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tags Row
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF00BCD4), Color(0xFF00ACC1)],
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF00BCD4).withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  widget.product['type'] ?? 'Sale',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              if (widget.product['status'] != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: widget.product['status'] == 'approved'
                                        ? const Color(0xFF4CAF50)
                                        : const Color(0xFFFF9800),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (widget.product['status'] == 'approved'
                                                ? const Color(0xFF4CAF50)
                                                : const Color(0xFFFF9800))
                                            .withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        widget.product['status'] == 'approved'
                                            ? Icons.verified
                                            : Icons.access_time,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        widget.product['status'] ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          // Product Title
                          Text(
                            widget.product['name'] ?? 'Product Name',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1A1A1A),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Price with better styling
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          //   decoration: BoxDecoration(
                          //     gradient: LinearGradient(
                          //       colors: [
                          //         const Color(0xFF00BCD4).withOpacity(0.1),
                          //         const Color(0xFF00ACC1).withOpacity(0.05),
                          //       ],
                          //     ),
                          //     borderRadius: BorderRadius.circular(12),
                          //     border: Border.all(
                          //       color: const Color(0xFF00BCD4).withOpacity(0.3),
                          //       width: 1.5,
                          //     ),
                          //   ),
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       const Icon(
                          //         Icons.currency_rupee,
                          //         color: Color(0xFF00BCD4),
                          //         size: 28,
                          //       ),
                          //       Text(
                          //         widget.product['price'] != null
                          //             ? '${widget.product['price']}'
                          //             : 'Price not available',
                          //         style: const TextStyle(
                          //           fontSize: 32,
                          //           fontWeight: FontWeight.w800,
                          //           color: Color(0xFF00BCD4),
                          //           letterSpacing: -0.5,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          const SizedBox(height: 14),
                          // Posted date
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(Icons.schedule, size: 16, color: Colors.grey.shade700),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Posted on ${_formatDate(widget.product['createdAt'])}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Location Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.red.shade400,
                                      Colors.red.shade600,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.place, size: 18, color: Colors.grey.shade700),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    widget.product['address'] ?? 'Location not specified',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF424242),
                                      fontWeight: FontWeight.w500,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Description Card
                    if (widget.product['description'] != null && 
                        widget.product['description'].toString().isNotEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.purple.shade400,
                                        Colors.purple.shade600,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.description,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Description',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Text(
                                widget.product['description'] ?? '',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF424242),
                                  height: 1.6,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (widget.product['description'] != null && 
                        widget.product['description'].toString().isNotEmpty)
                      const SizedBox(height: 16),

                    // Features Card (for houses)
                    if (isHouseCategory && 
                        widget.product['features'] != null && 
                        (widget.product['features'] as List).isNotEmpty)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.green.shade400,
                                        Colors.green.shade600,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Features',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A1A1A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: (widget.product['features'] as List).map((feature) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.green.shade50,
                                        Colors.green.shade100,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(25),
                                    border: Border.all(color: Colors.green.shade300, width: 1.5),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check_circle, size: 18, color: Colors.green.shade700),
                                      const SizedBox(width: 8),
                                      Text(
                                        feature.toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green.shade900,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                    if (isHouseCategory && 
                        widget.product['features'] != null && 
                        (widget.product['features'] as List).isNotEmpty)
                      const SizedBox(height: 16),

                    // Details Card
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.shade400,
                                      Colors.blue.shade600,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.info_outline,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A1A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildDetailRow('Category', widget.product['category']?['name'] ?? 'N/A'),
                          _buildDetailRow('Sub Category', widget.product['subCategory']?['name'] ?? 'N/A'),
                          if (widget.product['brand'] != null)
                            _buildDetailRow('Brand', widget.product['brand']),
                          if (widget.product['model'] != null)
                            _buildDetailRow('Model', widget.product['model']),
                          if (widget.product['condition'] != null)
                            _buildDetailRow('Condition', widget.product['condition']),
                        ],
                      ),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Delete Product',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'Are you sure you want to delete this product? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Implement delete functionality here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}