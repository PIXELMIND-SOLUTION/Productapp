import 'package:flutter/material.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:product_app/views/Details/product_detail_screen.dart';
import 'package:product_app/views/home/sell/edit.dart';
import 'package:product_app/views/home/sell/sell.dart';

class PostingDetails extends StatefulWidget {
  const PostingDetails({super.key});

  @override
  State<PostingDetails> createState() => _PostingDetailsState();
}

class _PostingDetailsState extends State<PostingDetails> with SingleTickerProviderStateMixin {
  List<dynamic> allProducts = [];
  List<dynamic> pendingProducts = [];
  List<dynamic> approvedProducts = [];
  List<dynamic> rejectedProducts = [];
  
  bool isLoading = true;
  String? errorMessage;
  late TabController _tabController;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadProducts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    final userId = SharedPrefHelper.getUserId();
    final token = SharedPrefHelper.getToken();

    if (userId == null || token == null) {
      setState(() {
        errorMessage = 'User not authenticated';
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://estatehouz-backend.onrender.com/api/user/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true) {
          final products = data['products'] ?? [];
          
          setState(() {
            allProducts = products;
            
            // Categorize products based on isApproved status
            pendingProducts = products.where((p) => p['isApproved'] == false).toList();
            approvedProducts = products.where((p) => p['isApproved'] == true).toList();
            rejectedProducts = []; // API doesn't seem to have rejected status
            
            isLoading = false;
          });
        } else {
          throw Exception('Failed to load products');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _updateProductStatus(String productId, bool isActive) async {
    setState(() {
      _isProcessing = true;
    });

    final token = SharedPrefHelper.getToken();
    if (token == null) return;

    try {
      final response = await http.patch(
        Uri.parse('https://estatehouz-backend.onrender.com/api/$productId/status'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({'isActive': isActive}),
      );

      if (response.statusCode == 200) {
        _loadProducts();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(isActive ? 'Product activated' : 'Product deactivated'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to update status');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<void> _deleteProduct(String productId) async {
    setState(() {
      _isProcessing = true;
    });

    final token = SharedPrefHelper.getToken();
    if (token == null) return;

    try {
      final response = await http.delete(
        Uri.parse('https://estatehouz-backend.onrender.com/api/$productId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _loadProducts();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _navigateToEditScreen(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Edit(
          productToEdit: product,
        ),
      ),
    ).then((shouldRefresh) {
      if (shouldRefresh == true) {
        _loadProducts();
      }
    });
  }

  Map<String, dynamic> _parseAttributes(dynamic attributes) {
    if (attributes == null) return {};
    
    if (attributes is String) {
      try {
        return json.decode(attributes) as Map<String, dynamic>;
      } catch (e) {
        return {};
      }
    } else if (attributes is Map) {
      return Map<String, dynamic>.from(attributes);
    }
    return {};
  }

String _extractFeature(Map<String, dynamic> attributes, String type) {

  if (type == 'bed') {
    if (attributes.containsKey('bedrooms')) {
      final bedrooms = attributes['bedrooms'];

      if (bedrooms is num) return '${bedrooms.toStringAsFixed(0)} Bed';
      if (bedrooms is String) return '$bedrooms Bed';
    }
  }

  else if (type == 'bath') {
    if (attributes.containsKey('bathrooms')) {
      final bathrooms = attributes['bathrooms'];

      if (bathrooms is num) return '${bathrooms.toStringAsFixed(0)} Bath';
      if (bathrooms is String) return '$bathrooms Bath';
    }
  }

  else if (type == 'area') {

    // PRIORITY → landSize first
    if (attributes.containsKey('landSize')) {
      final landSize = attributes['landSize'];
      final unit = attributes['unit'] ?? '';

      if (landSize is num) return '$landSize $unit';
      if (landSize is String) return '$landSize $unit';
    }

    // fallback → sqft
    if (attributes.containsKey('sqft')) {
      final sqft = attributes['sqft'];

      if (sqft is num) return '${sqft.toStringAsFixed(0)} sqft';
      if (sqft is String) return '$sqft sqft';
    }
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

  String _formatDate(String? dateString) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today';
      } else if (difference.inDays == 1) {
        return 'Yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return '';
    }
  }

  String _getCategoryName(dynamic category) {
    if (category == null) return 'Property';
    if (category is Map) {
      return category['name']?.toString() ?? 'Property';
    }
    return category.toString();
  }

  Color _getEmptyStateColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getEmptyStateIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.hourglass_empty;
      case 'approved':
        return Icons.check_circle_outline;
      case 'rejected':
        return Icons.cancel_outlined;
      default:
        return Icons.inbox_outlined;
    }
  }

  String _getEmptyStateTitle(String status) {
    switch (status) {
      case 'pending':
        return 'No Pending Listings';
      case 'approved':
        return 'No Approved Listings';
      case 'rejected':
        return 'No Rejected Listings';
      default:
        return 'No Listings Found';
    }
  }

  String _getEmptyStateDescription(String status) {
    switch (status) {
      case 'pending':
        return 'You don\'t have any properties waiting for approval.\nList a new property to get started!';
      case 'approved':
        return 'You don\'t have any approved properties yet.\nOnce your listings are approved, they will appear here.';
      case 'rejected':
        return 'You don\'t have any rejected properties.\nKeep listing and they\'ll appear here if rejected.';
      default:
        return 'Start by listing your first property';
    }
  }

  Widget _buildEmptyStateActions(String status) {
    return Column(
      children: [
        if (status == 'pending')
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SellScreen(),
                ),
              ).then((shouldRefresh) {
                if (shouldRefresh == true) {
                  _loadProducts();
                }
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('List a Property'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE33629),
              foregroundColor: Colors.white,
              minimumSize: const Size(200, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        
        const SizedBox(height: 12),
        
        OutlinedButton.icon(
          onPressed: _loadProducts,
          icon: const Icon(Icons.refresh),
          label: const Text('Refresh'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey.shade700,
            side: BorderSide(color: Colors.grey.shade300),
            minimumSize: const Size(200, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
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
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: const Color(0xFFE33629),
                  borderRadius: BorderRadius.circular(14),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: pendingProducts.isNotEmpty ? Colors.orange : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text('Pending'),
 
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: approvedProducts.isNotEmpty ? Colors.green : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text('Approved'),
                
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                _buildTabContent(
                  products: pendingProducts,
                  isLoading: isLoading,
                  status: 'pending',
                ),
                _buildTabContent(
                  products: approvedProducts,
                  isLoading: isLoading,
                  status: 'approved',
                ),
                _buildTabContent(
                  products: rejectedProducts,
                  isLoading: isLoading,
                  status: 'rejected',
                ),
              ],
            ),
            if (_isProcessing)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent({
    required List<dynamic> products,
    required bool isLoading,
    required String status,
  }) {
    if (isLoading) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildSkeletonCard();
        },
      );
    }

    if (errorMessage != null && products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red.shade400,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Oops! Something went wrong',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadProducts,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE33629),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 1000),
                tween: Tween<double>(begin: 0, end: 1),
                curve: Curves.elasticOut,
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: _getEmptyStateColor(status).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getEmptyStateIcon(status),
                        size: 64,
                        color: _getEmptyStateColor(status),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 24),
              
              Text(
                _getEmptyStateTitle(status),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade800,
                ),
              ),
              
              const SizedBox(height: 12),
              
              Text(
                _getEmptyStateDescription(status),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              
              _buildEmptyStateActions(status),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadProducts,
      color: const Color(0xFFE33629),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildPropertyCard(product, status: status);
        },
      ),
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
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
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

  Widget _buildPropertyCard(dynamic product, {required String status}) {
    final Map<String, dynamic> productMap = product is Map<String, dynamic> 
        ? product 
        : Map<String, dynamic>.from(product);
    
    final images = productMap['images'] as List<dynamic>? ?? [];
    final imageUrl = images.isNotEmpty ? images.first.toString() : '';
    
    // Parse attributes
    final attributes = _parseAttributes(productMap['attributes']);
    
    // Extract values from attributes
    String bed = _extractFeature(attributes, 'bed');
    String bath = _extractFeature(attributes, 'bath');
    String area = _extractFeature(attributes, 'area');

    print("llllllllllllll$bed");
    
    // Format price
    String price = '';
    if (attributes.containsKey('price')) {
      price = _formatPrice(attributes['price']);
    } else if (attributes.containsKey('pricePerNight')) {
      price = '₹${attributes['pricePerNight']}/night';
    }

    // Get category name
    final categoryName = _getCategoryName(productMap['category']);

    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ProductDetailScreen(
        //       productId: productMap['_id']?.toString() ?? '',
        //     ),
        //   ),
        // );
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
            // Property Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: imageUrl.startsWith('http')
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                            ),
                          ),
                  ),
                ),
                
                // Category Badge
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      categoryName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // Status Badge
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: status == 'approved' ? Colors.green : Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status == 'approved' ? 'Approved' : 'Pending',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                // More Options Button
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => _showOptionsMenu(context, productMap),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.more_vert,
                        size: 18,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Price Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          productMap['name']?.toString() ?? 'Unnamed Property',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (price.isNotEmpty)
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFE33629),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Stats Row
                  if (bed.isNotEmpty || bath.isNotEmpty || area.isNotEmpty)
                    Row(
                      children: [
                        if (bed.isNotEmpty)
                          _StatChip(
                            imagePath: 'assets/images/bed.png',
                            label: bed,
                          ),
                        if (bed.isNotEmpty && (bath.isNotEmpty || area.isNotEmpty))
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

                  // Location
                  if (productMap['address'] != null && productMap['address'].toString().isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            productMap['address'].toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 8),

                  // Posted Date and Active Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(productMap['createdAt']),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      
                      // Active status for approved products
                      if (status == 'approved')
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: productMap['isActive'] == true 
                                ? Colors.green.shade50 
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            productMap['isActive'] == true ? 'Active' : 'Inactive',
                            style: TextStyle(
                              fontSize: 11,
                              color: productMap['isActive'] == true 
                                  ? Colors.green.shade700 
                                  : Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsMenu(BuildContext context, Map<String, dynamic> product) {
    final isApproved = product['isApproved'] == true;
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // View Details
              // ListTile(
              //   leading: const Icon(Icons.visibility, color: Color(0xFFE33629)),
              //   title: const Text('View Details'),
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) => ProductDetailScreen(
              //     //       productId: product['_id']?.toString() ?? '',
              //     //     ),
              //     //   ),
              //     // );
              //   },
              // ),
              
              // Edit
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.blue),
                title: const Text('Edit Listing'),
                onTap: () {
                  Navigator.pop(context);
                  _navigateToEditScreen(product);
                },
              ),
              
              // Toggle Active Status (only for approved)
              if (isApproved)
                ListTile(
                  leading: Icon(
                    product['isActive'] == true ? Icons.visibility_off : Icons.visibility,
                    color: Colors.orange,
                  ),
                  title: Text(product['isActive'] == true ? 'Deactivate' : 'Activate'),
                  onTap: () {
                    Navigator.pop(context);
                    _confirmStatusToggle(context, product);
                  },
                ),
              
              // Delete
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Delete Listing'),
                onTap: () {
                  Navigator.pop(context);
                  _confirmDelete(context, product);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _confirmStatusToggle(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product['isActive'] == true ? 'Deactivate Listing' : 'Activate Listing'),
          content: Text(
            product['isActive'] == true
                ? 'Are you sure you want to deactivate "${product['name']}"?'
                : 'Are you sure you want to activate "${product['name']}"?'
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _updateProductStatus(
                  product['_id']?.toString() ?? '',
                  !(product['isActive'] == true),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: product['isActive'] == true ? Colors.orange : Colors.green,
              ),
              child: Text(product['isActive'] == true ? 'Deactivate' : 'Activate'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Listing'),
          content: Text('Are you sure you want to delete "${product['name']}"? This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _deleteProduct(product['_id']?.toString() ?? '');
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

// Stat Chip Widget
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