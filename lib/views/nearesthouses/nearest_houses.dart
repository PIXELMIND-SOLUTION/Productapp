// // import 'package:flutter/material.dart';
// // import 'package:product_app/views/Details/nearest_house_detail.dart';

// // class NearestHouses extends StatelessWidget {
// //   const NearestHouses({super.key,});

// //   @override
// //   Widget build(BuildContext context) {
// //     final List<Map<String, dynamic>> houseList = List.generate(3, (_) {
// //       return {
// //         "title": "Luxury House LakeView Estate",
// //         "location": "Kakinada",
// //         "price": "₹4,00,000",
// //         "beds": "4 Bed",
// //         "baths": "3 Bath",
// //         "area": "7,500 sqft",
// //         "image":
// //             "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
// //       };
// //     });

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           'Nearest Houses',
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         leading: IconButton(
// //           onPressed: () => Navigator.of(context).pop(),
// //           icon: const Icon(Icons.arrow_back_ios),
// //         ),
// //         centerTitle: true,
// //         backgroundColor: Colors.white,
// //         foregroundColor: Colors.black,
// //         elevation: 0,
// //       ),
// //       body: ListView.builder(
// //         padding: const EdgeInsets.all(12),
// //         itemCount: houseList.length,
// //         itemBuilder: (context, index) {
// //           final house = houseList[index];
// //           return GestureDetector(
// //             onTap: () {
// //               Navigator.push(context, MaterialPageRoute(builder: (context)=>NearestHouseDetail()));
// //             },
// //             child: Container(
// //               margin: const EdgeInsets.only(bottom: 16),
// //               padding: const EdgeInsets.all(8),
// //               decoration: BoxDecoration(
// //                 border: Border.all(
// //                   color: index == 1 ? Colors.grey.shade300 : Colors.grey.shade300,
// //                   width: index == 1 ? 1.5 : 1,
// //                 ),
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Stack(
// //                     children: [
// //                       ClipRRect(
// //                         borderRadius: BorderRadius.circular(10),
// //                         child: Image.asset(
// //                           house['image'],
// //                           height: 160,
// //                           width: double.infinity,
// //                           fit: BoxFit.cover,
// //                         ),
// //                       ),
// //                       Positioned(
// //                         top: 8,
// //                         left: 8,
// //                         child: Container(
// //                           padding:
// //                               const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                           decoration: BoxDecoration(
// //                             color: Colors.white,
// //                             borderRadius: BorderRadius.circular(20),
// //                           ),
// //                           child: const Text(
// //                             "For Sale",
// //                             style: TextStyle(color: Colors.black, fontSize: 12),
// //                           ),
// //                         ),
// //                       ),
// //                       // Positioned(
// //                       //   bottom: 8,
// //                       //   right: 8,
// //                       //   child: Container(
// //                       //     padding:
// //                       //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                       //     decoration: BoxDecoration(
// //                       //       color: Colors.white,
// //                       //       borderRadius: BorderRadius.circular(8),
// //                       //     ),
// //                       //     child: Text(
// //                       //       house['price'],
// //                       //       style: const TextStyle(
// //                       //           fontWeight: FontWeight.bold, fontSize: 14),
// //                       //     ),
// //                       //   ),
// //                       // ),
// //                       Positioned(
// //                         top: 8,
// //                         right: 8,
// //                         child: CircleAvatar(
// //                           backgroundColor: Colors.white,
// //                           child: IconButton(
// //                             icon: const Icon(Icons.favorite_border,color: Colors.black,),
// //                             onPressed: () {},
// //                           ),
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                   const SizedBox(height: 8),
// //                   Text(
// //                     house['title'],
// //                     style: const TextStyle(
// //                       fontWeight: FontWeight.w600,
// //                       fontSize: 15,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 6),
// //                   Row(
// //                     children: [
// //                       _iconText(Icons.bed_outlined, house['beds']),
// //                       const SizedBox(width: 8),
// //                       _iconText(Icons.bathtub_outlined, house['baths']),
// //                       const SizedBox(width: 8),
// //                       _iconText(Icons.square_foot, house['area']),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 6),
// //                   Row(
// //                     children: [
// //                       const Icon(Icons.location_on_outlined, size: 16,color: Color(0xFF00A8E8),),
// //                       SizedBox(width: 10,),
// //                       Text(
// //                         house['location'],
// //                         style: const TextStyle(fontSize: 13,color: Color.fromARGB(255, 118, 118, 118)),
// //                       )
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
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



// import 'package:flutter/material.dart';
// import 'package:product_app/helper/helper_function.dart';
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
//         Uri.parse('http://31.97.206.144:9174/api/nearest/user/$userId'),
//       );

//       print('Response status code: ${response.statusCode}');
//       print('Response body: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success'] == true && data['products'] != null) {
//           setState(() {
//             houseList = (data['products'] as List).map((product) {
//               String bed = '';
//               String bath = '';
//               String area = '';

//               if (product['features'] != null) {
//                 for (var feature in product['features']) {
//                   String name =
//                       (feature['name']?.toString() ?? '').toLowerCase();
//                   if (name.contains('bedroom') || name.contains('bed')) {
//                     bed = feature['name']?.toString() ?? '';
//                   } else if (name.contains('bathroom') ||
//                       name.contains('bath')) {
//                     bath = feature['name']?.toString() ?? '';
//                   } else if (name.contains('sqft') || name.contains('sq')) {
//                     area = feature['name']?.toString() ?? '';
//                   }
//                 }
//               }

//               return {
//                 'id': product['_id']?.toString() ?? '',
//                 'image': (product['images'] != null &&
//                         product['images'] is List &&
//                         product['images'].isNotEmpty)
//                     ? product['images'][0].toString()
//                     : '',
//                 'tag': product['type']?.toString() ?? 'For Sale',
//                 'title': product['name']?.toString() ?? 'Unnamed Property',
//                 'location': product['address']?.toString() ?? 'Unknown',
//                 'price': product['price']?.toString() ?? '₹25,000',
//                 'beds': bed.isNotEmpty ? bed : '4 Bed',
//                 'baths': bath.isNotEmpty ? bath : '2 Bath',
//                 'area': area.isNotEmpty ? area : '7,500 sqft',
//               };
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Nearest Houses',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : errorMessage != null
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.error_outline, size: 64, color: Colors.grey),
//                       const SizedBox(height: 16),
//                       Text(
//                         errorMessage!,
//                         style: TextStyle(color: Colors.grey[600]),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: fetchNearestProducts,
//                         child: const Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 )
//               : houseList.isEmpty
//                   ? Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.home_outlined,
//                               size: 64, color: Colors.grey),
//                           const SizedBox(height: 16),
//                           Text(
//                             'No properties found nearby',
//                             style: TextStyle(color: Colors.grey[600]),
//                           ),
//                         ],
//                       ),
//                     )
//                   : RefreshIndicator(
//                       onRefresh: fetchNearestProducts,
//                       child: ListView.builder(
//                         padding: const EdgeInsets.all(12),
//                         itemCount: houseList.length,
//                         itemBuilder: (context, index) {
//                           final house = houseList[index];
//                           return GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => NearestHouseDetail(
//                                     house: house,
//                                       // houseId: house['id'],
//                                       ),
//                                 ),
//                               );
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.only(bottom: 16),
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.grey.shade300,
//                                   width: 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Stack(
//                                     children: [
//                                       ClipRRect(
//                                         borderRadius: BorderRadius.circular(10),
//                                         child: house['image'].startsWith('http')
//                                             ? Image.network(
//                                                 house['image'],
//                                                 height: 160,
//                                                 width: double.infinity,
//                                                 fit: BoxFit.cover,
//                                                 errorBuilder: (context, error,
//                                                     stackTrace) {
//                                                   return Container(
//                                                     height: 160,
//                                                     width: double.infinity,
//                                                     color: Colors.grey[300],
//                                                     child: const Icon(
//                                                       Icons.broken_image,
//                                                       size: 64,
//                                                       color: Colors.grey,
//                                                     ),
//                                                   );
//                                                 },
//                                                 loadingBuilder: (context, child,
//                                                     loadingProgress) {
//                                                   if (loadingProgress == null)
//                                                     return child;
//                                                   return Container(
//                                                     height: 160,
//                                                     width: double.infinity,
//                                                     color: Colors.grey[200],
//                                                     child: const Center(
//                                                       child:
//                                                           CircularProgressIndicator(),
//                                                     ),
//                                                   );
//                                                 },
//                                               )
//                                             : Image.asset(
//                                                 house['image'],
//                                                 height: 160,
//                                                 width: double.infinity,
//                                                 fit: BoxFit.cover,
//                                                 errorBuilder: (context, error,
//                                                     stackTrace) {
//                                                   return Container(
//                                                     height: 160,
//                                                     width: double.infinity,
//                                                     color: Colors.grey[300],
//                                                     child: const Icon(
//                                                       Icons.home,
//                                                       size: 64,
//                                                       color: Colors.grey,
//                                                     ),
//                                                   );
//                                                 },
//                                               ),
//                                       ),
//                                       Positioned(
//                                         top: 8,
//                                         left: 8,
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               horizontal: 8, vertical: 4),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                           ),
//                                           child: Text(
//                                             house['tag'],
//                                             style: const TextStyle(
//                                                 color: Colors.black,
//                                                 fontSize: 12),
//                                           ),
//                                         ),
//                                       ),
//                                       // Positioned(
//                                       //   top: 8,
//                                       //   right: 8,
//                                       //   child: CircleAvatar(
//                                       //     backgroundColor: Colors.white,
//                                       //     child: IconButton(
//                                       //       icon: const Icon(
//                                       //         Icons.favorite_border,
//                                       //         color: Colors.black,
//                                       //       ),
//                                       //       onPressed: () {},
//                                       //     ),
//                                       //   ),
//                                       // )
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     house['title'],
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 6),
//                                   Row(
//                                     children: [
//                                       _iconText(
//                                           Icons.bed_outlined, house['beds']),
//                                       const SizedBox(width: 8),
//                                       _iconText(Icons.bathtub_outlined,
//                                           house['baths']),
//                                       const SizedBox(width: 8),
//                                       _iconText(
//                                           Icons.square_foot, house['area']),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 6),
//                                   Row(
//                                     children: [
//                                       const Icon(
//                                         Icons.location_on_outlined,
//                                         size: 16,
//                                         color: Color(0xFF00A8E8),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Expanded(
//                                         child: Text(
//                                           house['location'],
//                                           style: const TextStyle(
//                                             fontSize: 13,
//                                             color: Color.fromARGB(
//                                                 255, 118, 118, 118),
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
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

// // Placeholder class - replace with your actual SharedPrefHelper

















import 'package:flutter/material.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearestHouses extends StatefulWidget {
  const NearestHouses({super.key});

  @override
  State<NearestHouses> createState() => _NearestHousesState();
}

class _NearestHousesState extends State<NearestHouses> {
  List<Map<String, dynamic>> houseList = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchNearestProducts();
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
      final response = await http.get(
        Uri.parse('http://31.97.206.144:9174/api/nearest/user/$userId'),
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['products'] != null) {
          setState(() {
            houseList = (data['products'] as List).map((product) {
              String bed = '';
              String bath = '';
              String area = '';

              if (product['features'] != null) {
                for (var feature in product['features']) {
                  String name =
                      (feature['name']?.toString() ?? '').toLowerCase();
                  if (name.contains('bedroom') || name.contains('bed')) {
                    bed = feature['name']?.toString() ?? '';
                  } else if (name.contains('bathroom') ||
                      name.contains('bath')) {
                    bath = feature['name']?.toString() ?? '';
                  } else if (name.contains('sqft') || name.contains('sq')) {
                    area = feature['name']?.toString() ?? '';
                  }
                }
              }

              return {
                'id': product['_id']?.toString() ?? '',
                'image': (product['images'] != null &&
                        product['images'] is List &&
                        product['images'].isNotEmpty)
                    ? product['images'][0].toString()
                    : '',
                'tag': product['type']?.toString() ?? 'For Sale',
                'title': product['name']?.toString() ?? 'Unnamed Property',
                'location': product['address']?.toString() ?? 'Unknown',
                'price': product['price']?.toString() ?? '₹25,000',
                'beds': bed.isNotEmpty ? bed : '4 Bed',
                'baths': bath.isNotEmpty ? bath : '2 Bath',
                'area': area.isNotEmpty ? area : '7,500 sqft',
              };
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // Modern AppBar with gradient
          SliverAppBar(
            expandedHeight: 130,
            floating: false,
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                color: const Color(0xFF2D3142),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF667EEA),
                      Color(0xFF764BA2),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   'Discover',
                        //   style: TextStyle(
                        //     color: Colors.white70,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Nearest Properties',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: isLoading
                ? Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF667EEA),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Finding properties near you...',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : errorMessage != null
                    ? Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.all(24),
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF3F2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Icon(
                                    Icons.error_outline_rounded,
                                    size: 48,
                                    color: Color(0xFFEF4444),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Oops!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  errorMessage!,
                                  style: const TextStyle(
                                    color: Color(0xFF6B7280),
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: fetchNearestProducts,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF667EEA),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Try Again',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : houseList.isEmpty
                        ? Container(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Center(
                              child: Container(
                                margin: const EdgeInsets.all(24),
                                padding: const EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 20,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF3F4F6),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.home_outlined,
                                        size: 48,
                                        color: Color(0xFF9CA3AF),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      'No Properties Found',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1F2937),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'We couldn\'t find any properties\nnear your location',
                                      style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Results count
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${houseList.length} Properties',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF1F2937),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF667EEA)
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Text(
                                          'Near You',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF667EEA),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Property List
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: houseList.length,
                                  itemBuilder: (context, index) {
                                    final house = houseList[index];
                                    return _buildModernPropertyCard(
                                        context, house);
                                  },
                                ),
                              ],
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernPropertyCard(
      BuildContext context, Map<String, dynamic> house) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NearestHouseDetail(house: house),
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
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
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
                  child: house['image'].startsWith('http')
                      ? Image.network(
                          house['image'],
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 220,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.grey[200]!,
                                    Colors.grey[300]!,
                                  ],
                                ),
                              ),
                              child: const Icon(
                                Icons.home_rounded,
                                size: 64,
                                color: Colors.grey,
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: 220,
                              width: double.infinity,
                              color: Colors.grey[100],
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color(0xFF667EEA),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          house['image'],
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 220,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.grey[200]!,
                                    Colors.grey[300]!,
                                  ],
                                ),
                              ),
                              child: const Icon(
                                Icons.home_rounded,
                                size: 64,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                ),
                // Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
                // Tag
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF667EEA).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      house['tag'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
                // Favorite button
                // Positioned(
                //   top: 16,
                //   right: 16,
                //   child: Container(
                //     padding: const EdgeInsets.all(8),
                //     decoration: BoxDecoration(
                //       color: Colors.white.withOpacity(0.9),
                //       borderRadius: BorderRadius.circular(12),
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.black.withOpacity(0.1),
                //           blurRadius: 8,
                //           offset: const Offset(0, 2),
                //         ),
                //       ],
                //     ),
                //     child: const Icon(
                //       Icons.favorite_border_rounded,
                //       color: Color(0xFF1F2937),
                //       size: 20,
                //     ),
                //   ),
                // ),
              ],
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    house['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF1F2937),
                      letterSpacing: -0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF667EEA).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          size: 14,
                          color: Color(0xFF667EEA),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          house['location'],
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Features
                  Row(
                    children: [
                      _buildModernFeature(
                          Icons.bed_rounded, house['beds'], const Color(0xFF667EEA)),
                      const SizedBox(width: 12),
                      _buildModernFeature(Icons.bathtub_rounded,
                          house['baths'], const Color(0xFF10B981)),
                      const SizedBox(width: 12),
                      _buildModernFeature(Icons.square_foot_rounded,
                          house['area'], const Color(0xFFF59E0B)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Price and View Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Text(
                          //   'Price',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     color: Color(0xFF9CA3AF),
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          // const SizedBox(height: 2),
                          // Text(
                          //   house['price'],
                          //   style: const TextStyle(
                          //     fontSize: 20,
                          //     fontWeight: FontWeight.bold,
                          //     color: Color(0xFF667EEA),
                          //     letterSpacing: -0.5,
                          //   ),
                          // ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF667EEA).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: const [
                            Text(
                              'View Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
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

  Widget _buildModernFeature(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color.withOpacity(0.9),
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