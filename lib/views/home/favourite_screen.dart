// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
// import 'package:provider/provider.dart';

// class FavouriteScreen extends StatefulWidget {
//   const FavouriteScreen({super.key});

//   @override
//   State<FavouriteScreen> createState() => _FavouriteScreenState();
// }

// class _FavouriteScreenState extends State<FavouriteScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch wishlist when screen loads
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<WishlistProvider>().fetchWishlist();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Wishlist',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         actions: [
//           Consumer<WishlistProvider>(
//             builder: (context, wishlistProvider, _) {
//               if (wishlistProvider.wishlistItems.isNotEmpty) {
//                 return IconButton(
//                   icon: const Icon(Icons.refresh),
//                   onPressed: () {
//                     wishlistProvider.refreshWishlist();
//                   },
//                 );
//               }
//               return const SizedBox.shrink();
//             },
//           ),
//         ],
//       ),
//       body: Consumer<WishlistProvider>(
//         builder: (context, wishlistProvider, child) {
//           // Show loading indicator
//           if (wishlistProvider.isLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           // Show error message
//           if (wishlistProvider.errorMessage != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.error_outline,
//                     size: 64,
//                     color: Colors.red.shade300,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     wishlistProvider.errorMessage!,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       color: Colors.red,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       wishlistProvider.fetchWishlist();
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // Show empty state
//           if (wishlistProvider.wishlistItems.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(
//                     Icons.favorite_border,
//                     size: 100,
//                     color: Colors.grey.shade300,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Your wishlist is empty',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     'Add properties you like to see them here',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey.shade500,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           // Show wishlist items
//           return RefreshIndicator(
//             onRefresh: () => wishlistProvider.refreshWishlist(),
//             child: ListView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: wishlistProvider.wishlistItems.length,
//               itemBuilder: (context, index) {
//                 final item = wishlistProvider.wishlistItems[index];
                
//                 // Extract features
//                 String bed = '';
//                 String bath = '';
//                 String area = '';

//                 if (item['features'] != null && item['features'] is List) {
//                   for (var feature in item['features']) {
//                     String name = feature['name'].toString().toLowerCase();
//                     if (name.contains('bedroom') || name.contains('bed')) {
//                       bed = feature['name'];
//                     } else if (name.contains('bathroom') ||
//                         name.contains('bath')) {
//                       bath = feature['name'];
//                     } else if (name.contains('sqft') || name.contains('sq')) {
//                       area = feature['name'];
//                     }
//                   }
//                 }

//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 16),
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Colors.grey.shade300,
//                       width: 1,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.network(
//                              (item['images'] != null && item['images'].isNotEmpty)
//     ? item['images'][0]
//     : '',

//                               height: 160,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Container(
//                                   height: 160,
//                                   width: double.infinity,
//                                   color: Colors.grey.shade300,
//                                   child: const Icon(
//                                     Icons.home,
//                                     size: 64,
//                                     color: Colors.grey,
//                                   ),
//                                 );
//                               },
//                               loadingBuilder:
//                                   (context, child, loadingProgress) {
//                                 if (loadingProgress == null) return child;
//                                 return Container(
//                                   height: 160,
//                                   width: double.infinity,
//                                   color: Colors.grey.shade200,
//                                   child: const Center(
//                                     child: CircularProgressIndicator(),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           Positioned(
//                             top: 8,
//                             left: 8,
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 item['type'] ?? "For Sale",
//                                 style: const TextStyle(
//                                     color: Colors.black, fontSize: 12),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 8,
//                             right: 8,
//                             child: CircleAvatar(
//                               backgroundColor: Colors.white,
//                               child: wishlistProvider.isToggling
//                                   ? const SizedBox(
//                                       width: 20,
//                                       height: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         valueColor:
//                                             AlwaysStoppedAnimation<Color>(
//                                                 Colors.red),
//                                       ),
//                                     )
//                                   : IconButton(
//                                       icon: const Icon(
//                                         Icons.favorite,
//                                         color: Colors.red,
//                                       ),
//                                       onPressed: () async {
//                                         final success = await wishlistProvider
//                                             .toggleWishlist(item['_id']);

//                                         if (context.mounted) {
//                                           ScaffoldMessenger.of(context)
//                                               .showSnackBar(
//                                             SnackBar(
//                                               backgroundColor: success
//                                                   ? Colors.red
//                                                   : Colors.red,
//                                               content: Text(
//                                                 success
//                                                     ? 'Removed from wishlist'
//                                                     : (wishlistProvider
//                                                             .errorMessage ??
//                                                         'Failed to remove'),
//                                               ),
//                                               duration:
//                                                   const Duration(seconds: 2),
//                                               behavior:
//                                                   SnackBarBehavior.floating,
//                                             ),
//                                           );
//                                         }
//                                       },
//                                     ),
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         item['name'] ?? 'Property',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 15,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           _iconText(Icons.bed_outlined,
//                               bed.isNotEmpty ? bed : '4 Bed'),
//                           const SizedBox(width: 8),
//                           _iconText(Icons.bathtub_outlined,
//                               bath.isNotEmpty ? bath : '2 Bath'),
//                           const SizedBox(width: 8),
//                           _iconText(Icons.square_foot,
//                               area.isNotEmpty ? area : '7,500 sqft'),
//                         ],
//                       ),
//                       const SizedBox(height: 6),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on_outlined,
//                             size: 16,
//                             color: Colors.blue,
//                           ),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               item['address'] ?? 'Location not available',
//                               style: const TextStyle(fontSize: 13),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         },
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


















import 'package:flutter/material.dart';
import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
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
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red.shade400, Colors.red.shade600],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Wishlist',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Your favorite properties',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, _) {
              if (wishlistProvider.wishlistItems.isNotEmpty) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '${wishlistProvider.wishlistItems.length}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'items',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade400),
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Loading your favorites...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              wishlistProvider.errorMessage ?? 'Please try again',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                wishlistProvider.fetchWishlist();
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
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
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.shade50,
                    Colors.red.shade100,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 80,
                color: Colors.red.shade300,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Your Wishlist is Empty',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Start adding your favorite properties\nto see them here',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lightbulb_outline, color: Colors.amber.shade700),
                  const SizedBox(width: 12),
                  const Flexible(
                    child: Text(
                      'Tap the heart icon on any property to save it',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistContent(WishlistProvider wishlistProvider) {
    return RefreshIndicator(
      onRefresh: () => wishlistProvider.refreshWishlist(),
      color: Colors.red.shade400,
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
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
            _buildPropertyImage(item, wishlistProvider),
            _buildPropertyDetails(item, bed, bath, area),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyImage(
      Map<String, dynamic> item, WishlistProvider wishlistProvider) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Image.network(
            (item['images'] != null && item['images'].isNotEmpty)
                ? item['images'][0]
                : '',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade200, Colors.grey.shade300],
                  ),
                ),
                child: Icon(
                  Icons.home_rounded,
                  size: 80,
                  color: Colors.grey.shade400,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.grey.shade100, Colors.grey.shade200],
                  ),
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.red.shade400),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sell_rounded,
                  size: 14,
                  color: Colors.red.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  item['type'] ?? "For Sale",
                  style: TextStyle(
                    color: Colors.red.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: GestureDetector(
            onTap: () async {
              if (!wishlistProvider.isToggling) {
                final success =
                    await wishlistProvider.toggleWishlist(item['_id']);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: success
                          ? Colors.green.shade600
                          : Colors.red.shade600,
                      content: Row(
                        children: [
                          Icon(
                            success
                                ? Icons.check_circle_rounded
                                : Icons.error_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            success
                                ? 'Removed from wishlist'
                                : (wishlistProvider.errorMessage ??
                                    'Failed to remove'),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(16),
                    ),
                  );
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: wishlistProvider.isToggling
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.red.shade400),
                      ),
                    )
                  : Icon(
                      Icons.favorite_rounded,
                      color: Colors.red.shade400,
                      size: 20,
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPropertyDetails(
      Map<String, dynamic> item, String bed, String bath, String area) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['name'] ?? 'Property',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 16,
                color: Colors.red.shade400,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  item['address'] ?? 'Location not available',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildFeatureChip(
                  Icons.bed_rounded, bed.isNotEmpty ? bed : '4 Bed'),
              const SizedBox(width: 8),
              _buildFeatureChip(
                  Icons.bathtub_rounded, bath.isNotEmpty ? bath : '2 Bath'),
              const SizedBox(width: 8),
              _buildFeatureChip(Icons.square_foot_rounded,
                  area.isNotEmpty ? area : '7,500 sqft'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: Colors.grey.shade700,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}