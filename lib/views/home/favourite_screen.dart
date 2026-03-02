import 'package:flutter/material.dart';
import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
import 'package:product_app/utils/call_utils.dart';
import 'package:product_app/utils/whatsapp_utils.dart';
import 'package:product_app/utils/location_utils.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // Default agent phone number - replace with actual agent number from your data
  final String agentPhone = "919961593179";

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Consumer<WishlistProvider>(
                builder: (context, wishlistProvider, child) {
                  if (wishlistProvider.isLoading) {
                    return _buildLoadingState();
                  }

                  if (wishlistProvider.errorMessage != null) {
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
    );
  }

  Widget _buildHeader() {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
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
            Text(
              'Wishlist',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: CircularProgressIndicator(),
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

  Widget _buildPropertyCard(
      Map<String, dynamic> item, WishlistProvider wishlistProvider, int index) {
    String bed = '';
    String bath = '';
    String area = '';

    if (item['features'] != null && item['features'] is List) {
      for (var feature in item['features']) {
        String name = feature['name'].toString().toLowerCase();
        if (name.contains('bedroom') || name.contains('bed')) {
          bed = feature['name'];
        } else if (name.contains('bathroom') || name.contains('bath')) {
          bath = feature['name'];
        } else if (name.contains('sqft') || name.contains('sq')) {
          area = feature['name'];
        }
      }
    }

    // Default values if features not found
    bed = bed.isNotEmpty ? bed : '4 Bed';
    bath = bath.isNotEmpty ? bath : '2 Bath';
    area = area.isNotEmpty ? area : '7,500 sqft';

    // Create house object for navigation
    Map<String, dynamic> house = {
      'id': item['_id']?.toString() ?? '',
      'image': (item['images'] != null && item['images'].isNotEmpty)
          ? item['images'][0].toString()
          : '',
      'tag': item['type']?.toString() ?? 'For Sale',
      'title': item['name']?.toString() ?? 'Unnamed Property',
      'location': item['address']?.toString() ?? 'Unknown',
      'price': item['price']?.toString() ?? '₹25,000',
      'beds': bed,
      'baths': bath,
      'area': area,
      'description': item['description']?.toString() ?? 
          'Beautiful property located in prime area with modern amenities and peaceful surroundings.',
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
          // Navigate to detail screen when card is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NearestHouseDetail(house: house),
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
                      child: (item['images'] != null && item['images'].isNotEmpty)
                          ? (item['images'][0].toString().startsWith('http')
                              ? Image.network(
                                  item['images'][0],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey.shade300,
                                      child: const Center(
                                        child: Icon(Icons.image_not_supported, size: 50),
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
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported, size: 50),
                                  ),
                                ))
                          : Container(
                              color: Colors.grey.shade300,
                              child: const Center(
                                child: Icon(Icons.image_not_supported, size: 50),
                              ),
                            ),
                    ),
                  ),
                  // Type Badge
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        house['tag'],
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
                              await wishlistProvider.toggleWishlist(item['_id']);

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: success ? Colors.green : Colors.red,
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
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                                ),
                              )
                            : Icon(
                                Icons.favorite,
                                size: 16,
                                color: const Color(0xFFE33629),
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
                      house['title'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Location
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/location.png',
                          width: 14,
                          height: 14,
                          errorBuilder: (_, __, ___) {
                            return const Icon(Icons.location_on, size: 14, color: Colors.grey);
                          },
                        ),
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

                    /// Stats Row with asset images
                    Row(
                      children: [
                        _StatChip(
                          imagePath: 'assets/images/bed.png',
                          label: bed,
                        ),
                        const SizedBox(width: 12),
                        _StatChip(
                          imagePath: 'assets/images/bath.png',
                          label: bath,
                        ),
                        const SizedBox(width: 12),
                        _StatChip(
                          imagePath: 'assets/images/sqft.png',
                          label: area,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Divider(color: Colors.grey.shade200, height: 1),
                    const SizedBox(height: 10),

                    /// Action Buttons
                    Row(
                      children: [
                        _CallButton(
                          onTap: () {
                            // Show call options
                            CallUtils.showCallOptions(
                              context: context,
                              phoneNumber: agentPhone,
                              name: "Property Agent",
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
                            // Share property via WhatsApp
                            WhatsAppUtils.shareProperty(
                              context: context,
                              propertyTitle: house['title'],
                              propertyLocation: house['location'],
                              propertyPrice: house['price'],
                              agentPhone: agentPhone,
                            );
                          },
                        ),
                        const Spacer(),
                        _ActionButton(
                          imagePath: 'assets/images/location.png',
                          label: "Location",
                          onTap: () {
                            // Show location options
                            LocationUtils.showMapOptions(
                              context: context,
                              latitude: 28.6139, // Replace with actual latitude from your data
                              longitude: 77.2090, // Replace with actual longitude from your data
                              address: house['location'],
                              locationName: house['title'],
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                    
                    /// View Details Button
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
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
              color: Colors.grey,
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
        child: Text(
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
                color: Colors.grey,
              );
            },
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
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