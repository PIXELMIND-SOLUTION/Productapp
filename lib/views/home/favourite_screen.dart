// import 'package:flutter/material.dart';

// class FavouriteScreen extends StatelessWidget {
//   const FavouriteScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//      final List<Map<String, dynamic>> houseList = List.generate(3, (_) {
//       return {
//         "title": "Luxury House LakeView Estate",
//         "location": "Kakinada",
//         "price": "₹4,00,000",
//         "beds": "4 Bed",
//         "baths": "3 Bath",
//         "area": "7,500 sqft",
//         "image":
//             "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png", 
//       };
//     });
//     return  Scaffold(
//       appBar: AppBar(
//         title:const Text('Wishlist',style: TextStyle(fontWeight: FontWeight.bold),),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//        body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: houseList.length,
//         itemBuilder: (context, index) {
//           final house = houseList[index];
//           return Container(
//             margin: const EdgeInsets.only(bottom: 16),
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: index == 1 ? Colors.grey.shade300 : Colors.grey.shade300,
//                 width: index == 1 ? 1.5 : 1,
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
//                       ),
//                     ),
//                     Positioned(
//                       top: 8,
//                       left: 8,
//                       child: Container(
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
//                         padding:
//                             const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           house['price'],
//                           style: const TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 14),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       top: 8,
//                       right: 8,
//                       child: CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: IconButton(
//                           icon: const Icon(Icons.favorite_border,color: Colors.red,),
//                           onPressed: () {},
//                         ),
//                       ),
//                     )
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
//                     const Icon(Icons.location_on_outlined, size: 16,color: Colors.blue,),
//                   const  SizedBox(width: 10,),
//                     Text(
//                       house['location'],
//                       style: const TextStyle(fontSize: 13),
//                     )
//                   ],
//                 ),
//               ],
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














// import 'package:flutter/material.dart';
// import 'package:product_app/views/widgets/wishlist_manager.dart';

// class FavouriteScreen extends StatelessWidget {
//   const FavouriteScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final WishlistManager wishlistManager = WishlistManager();
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Wishlist',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body: AnimatedBuilder(
//         animation: wishlistManager,
//         builder: (context, child) {
//           final wishlist = wishlistManager.wishlist;
          
//           if (wishlist.isEmpty) {
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
          
//           return ListView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: wishlist.length,
//             itemBuilder: (context, index) {
//               final house = wishlist[index];
//               return Container(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey.shade300,
//                     width: 1,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Stack(
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.asset(
//                             house['imageUrl'] ?? house['image'],
//                             height: 160,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                         Positioned(
//                           top: 8,
//                           left: 8,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(
//                               house['tag'] ?? "For Sale",
//                               style: const TextStyle(
//                                   color: Colors.black, fontSize: 12),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 8,
//                           right: 8,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 4),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               house['price'],
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 14),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           top: 8,
//                           right: 8,
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             child: IconButton(
//                               icon: const Icon(
//                                 Icons.favorite,
//                                 color: Colors.red,
//                               ),
//                               onPressed: () {
//                                 wishlistManager.removeFromWishlist(house['title']);
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     backgroundColor: Colors.red,
//                                     content: Text('Removed from wishlist'),
//                                     duration: Duration(seconds: 1),
//                                     behavior: SnackBarBehavior.floating,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       house['title'],
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//                         _iconText(Icons.bed_outlined, house['bed'] ?? house['beds']),
//                         const SizedBox(width: 8),
//                         _iconText(Icons.bathtub_outlined, house['bath'] ?? house['baths']),
//                         const SizedBox(width: 8),
//                         _iconText(Icons.square_foot, house['area']),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.location_on_outlined,
//                           size: 16,
//                           color: Colors.blue,
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           house['location'],
//                           style: const TextStyle(fontSize: 13),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
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

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch wishlist when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WishlistProvider>().fetchWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Consumer<WishlistProvider>(
            builder: (context, wishlistProvider, _) {
              if (wishlistProvider.wishlistItems.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    wishlistProvider.refreshWishlist();
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<WishlistProvider>(
        builder: (context, wishlistProvider, child) {
          // Show loading indicator
          if (wishlistProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Show error message
          if (wishlistProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    wishlistProvider.errorMessage!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      wishlistProvider.fetchWishlist();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Show empty state
          if (wishlistProvider.wishlistItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 100,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your wishlist is empty',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add properties you like to see them here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

          // Show wishlist items
          return RefreshIndicator(
            onRefresh: () => wishlistProvider.refreshWishlist(),
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: wishlistProvider.wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistProvider.wishlistItems[index];
                
                // Extract features
                String bed = '';
                String bath = '';
                String area = '';

                if (item['features'] != null && item['features'] is List) {
                  for (var feature in item['features']) {
                    String name = feature['name'].toString().toLowerCase();
                    if (name.contains('bedroom') || name.contains('bed')) {
                      bed = feature['name'];
                    } else if (name.contains('bathroom') ||
                        name.contains('bath')) {
                      bath = feature['name'];
                    } else if (name.contains('sqft') || name.contains('sq')) {
                      area = feature['name'];
                    }
                  }
                }

                return Container(
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
                            child: Image.network(
                             (item['images'] != null && item['images'].isNotEmpty)
    ? item['images'][0]
    : '',

                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 160,
                                  width: double.infinity,
                                  color: Colors.grey.shade300,
                                  child: const Icon(
                                    Icons.home,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 160,
                                  width: double.infinity,
                                  color: Colors.grey.shade200,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
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
                                item['type'] ?? "For Sale",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: wishlistProvider.isToggling
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.red),
                                      ),
                                    )
                                  : IconButton(
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        final success = await wishlistProvider
                                            .toggleWishlist(item['_id']);

                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              backgroundColor: success
                                                  ? Colors.red
                                                  : Colors.red,
                                              content: Text(
                                                success
                                                    ? 'Removed from wishlist'
                                                    : (wishlistProvider
                                                            .errorMessage ??
                                                        'Failed to remove'),
                                              ),
                                              duration:
                                                  const Duration(seconds: 2),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['name'] ?? 'Property',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          _iconText(Icons.bed_outlined,
                              bed.isNotEmpty ? bed : '4 Bed'),
                          const SizedBox(width: 8),
                          _iconText(Icons.bathtub_outlined,
                              bath.isNotEmpty ? bath : '2 Bath'),
                          const SizedBox(width: 8),
                          _iconText(Icons.square_foot,
                              area.isNotEmpty ? area : '7,500 sqft'),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item['address'] ?? 'Location not available',
                              style: const TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _iconText(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}