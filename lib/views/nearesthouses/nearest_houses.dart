// import 'package:flutter/material.dart';
// import 'package:product_app/views/Details/nearest_house_detail.dart';

// class NearestHouses extends StatelessWidget {
//   const NearestHouses({super.key,});

//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, dynamic>> houseList = List.generate(3, (_) {
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
//       body: ListView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: houseList.length,
//         itemBuilder: (context, index) {
//           final house = houseList[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>NearestHouseDetail()));
//             },
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 16),
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: index == 1 ? Colors.grey.shade300 : Colors.grey.shade300,
//                   width: index == 1 ? 1.5 : 1,
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.asset(
//                           house['image'],
//                           height: 160,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Positioned(
//                         top: 8,
//                         left: 8,
//                         child: Container(
//                           padding:
//                               const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: const Text(
//                             "For Sale",
//                             style: TextStyle(color: Colors.black, fontSize: 12),
//                           ),
//                         ),
//                       ),
//                       // Positioned(
//                       //   bottom: 8,
//                       //   right: 8,
//                       //   child: Container(
//                       //     padding:
//                       //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       //     decoration: BoxDecoration(
//                       //       color: Colors.white,
//                       //       borderRadius: BorderRadius.circular(8),
//                       //     ),
//                       //     child: Text(
//                       //       house['price'],
//                       //       style: const TextStyle(
//                       //           fontWeight: FontWeight.bold, fontSize: 14),
//                       //     ),
//                       //   ),
//                       // ),
//                       Positioned(
//                         top: 8,
//                         right: 8,
//                         child: CircleAvatar(
//                           backgroundColor: Colors.white,
//                           child: IconButton(
//                             icon: const Icon(Icons.favorite_border,color: Colors.black,),
//                             onPressed: () {},
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     house['title'],
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 15,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       _iconText(Icons.bed_outlined, house['beds']),
//                       const SizedBox(width: 8),
//                       _iconText(Icons.bathtub_outlined, house['baths']),
//                       const SizedBox(width: 8),
//                       _iconText(Icons.square_foot, house['area']),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on_outlined, size: 16,color: Color(0xFF00A8E8),),
//                       SizedBox(width: 10,),
//                       Text(
//                         house['location'],
//                         style: const TextStyle(fontSize: 13,color: Color.fromARGB(255, 118, 118, 118)),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
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
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// Import your SharedPrefHelper - adjust the path as needed
// import 'package:product_app/helpers/shared_pref_helper.dart';

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
      appBar: AppBar(
        title: const Text(
          'Nearest Houses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text(
                        errorMessage!,
                        style: TextStyle(color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: fetchNearestProducts,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : houseList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_outlined,
                              size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          Text(
                            'No properties found nearby',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: fetchNearestProducts,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: houseList.length,
                        itemBuilder: (context, index) {
                          final house = houseList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NearestHouseDetail(
                                    house: house,
                                      // houseId: house['id'],
                                      ),
                                ),
                              );
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
                                        child: house['image'].startsWith('http')
                                            ? Image.network(
                                                house['image'],
                                                height: 160,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    height: 160,
                                                    width: double.infinity,
                                                    color: Colors.grey[300],
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      size: 64,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Container(
                                                    height: 160,
                                                    width: double.infinity,
                                                    color: Colors.grey[200],
                                                    child: const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  );
                                                },
                                              )
                                            : Image.asset(
                                                house['image'],
                                                height: 160,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    height: 160,
                                                    width: double.infinity,
                                                    color: Colors.grey[300],
                                                    child: const Icon(
                                                      Icons.home,
                                                      size: 64,
                                                      color: Colors.grey,
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            house['tag'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                      // Positioned(
                                      //   top: 8,
                                      //   right: 8,
                                      //   child: CircleAvatar(
                                      //     backgroundColor: Colors.white,
                                      //     child: IconButton(
                                      //       icon: const Icon(
                                      //         Icons.favorite_border,
                                      //         color: Colors.black,
                                      //       ),
                                      //       onPressed: () {},
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    house['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      _iconText(
                                          Icons.bed_outlined, house['beds']),
                                      const SizedBox(width: 8),
                                      _iconText(Icons.bathtub_outlined,
                                          house['baths']),
                                      const SizedBox(width: 8),
                                      _iconText(
                                          Icons.square_foot, house['area']),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        size: 16,
                                        color: Color(0xFF00A8E8),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          house['location'],
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(
                                                255, 118, 118, 118),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
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

// Placeholder class - replace with your actual SharedPrefHelper
