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
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image Carousel
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
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
                child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              // IconButton(
              //   icon: Container(
              //     padding: const EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       shape: BoxShape.circle,
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.black.withOpacity(0.1),
              //           blurRadius: 8,
              //           offset: const Offset(0, 2),
              //         ),
              //       ],
              //     ),
              //     child: const Icon(Icons.share_outlined, size: 18, color: Colors.black),
              //   ),
              //   onPressed: () {},
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
                              color: Colors.grey.shade200,
                              child: const Center(
                                child: Icon(Icons.image_outlined, size: 80, color: Colors.grey),
                              ),
                            );
                          },
                        );
                      },
                    )
                  else
                    Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                        child: Icon(Icons.image_outlined, size: 80, color: Colors.grey),
                      ),
                    ),
                  // Image indicator
                  if (imageUrls.length > 1)
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          imageUrls.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == index
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.4),
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
                // Price and Title Section
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00BCD4).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF00BCD4)),
                            ),
                            child: Text(
                              widget.product['type'] ?? 'Sale',
                              style: const TextStyle(
                                color: Color(0xFF00BCD4),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (widget.product['status'] != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: widget.product['status'] == 'approved'
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.product['status'] ?? '',
                                style: TextStyle(
                                  color: widget.product['status'] == 'approved'
                                      ? Colors.green
                                      : Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.product['name'] ?? 'Product Name',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.product['price'] != null
                            ? '₹${widget.product['price']}'
                            : 'Price not available',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF00BCD4),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            'Posted on ${_formatDate(widget.product['createdAt'])}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, thickness: 1),

                // Location Section
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.location_on, size: 20, color: Colors.red.shade400),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.product['address'] ?? 'Location not specified',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, thickness: 1),

                // Description Section
                if (widget.product['description'] != null && 
                    widget.product['description'].toString().isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.product['description'] ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                if (widget.product['description'] != null && 
                    widget.product['description'].toString().isNotEmpty)
                  const Divider(height: 1, thickness: 1),

                // Features Section (for houses)
                if (isHouseCategory && 
                    widget.product['features'] != null && 
                    (widget.product['features'] as List).isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Features',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (widget.product['features'] as List).map((feature) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle, size: 16, color: Colors.green.shade600),
                                  const SizedBox(width: 6),
                                  Text(
                                    feature.toString(),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black87,
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
                  const Divider(height: 1, thickness: 1),

                // Details Section
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),
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

                const SizedBox(height: 80),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   padding: const EdgeInsets.all(16),
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(0.05),
      //         blurRadius: 10,
      //         offset: const Offset(0, -5),
      //       ),
      //     ],
      //   ),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: OutlinedButton(
      //           onPressed: () {
      //             // Edit functionality
      //           },
      //           style: OutlinedButton.styleFrom(
      //             padding: const EdgeInsets.symmetric(vertical: 14),
      //             side: const BorderSide(color: Color(0xFF00BCD4), width: 2),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //           ),
      //           child: const Text(
      //             'Edit',
      //             style: TextStyle(
      //               color: Color(0xFF00BCD4),
      //               fontSize: 16,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //         ),
      //       ),
      //       const SizedBox(width: 12),
      //       Expanded(
      //         child: ElevatedButton(
      //           onPressed: () {
      //             // Delete functionality
      //             _showDeleteDialog(context);
      //           },
      //           style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.red,
      //             padding: const EdgeInsets.symmetric(vertical: 14),
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12),
      //             ),
      //             elevation: 0,
      //           ),
      //           child: const Text(
      //             'Delete',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 16,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
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
            borderRadius: BorderRadius.circular(16),
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
                // You can call your delete API
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
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