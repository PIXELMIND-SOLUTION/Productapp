import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/views/Listing/listing_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedIndex = 0;

  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  // Future<void> fetchCategories() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('http://31.97.206.144:9174/api/auth/get/MainCategories'),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       if (data['success'] == true) {
  //         setState(() {
  //           categories = List<Map<String, dynamic>>.from(
  //               data['categories'].map((category) => {
  //                     'id': category['_id'],
  //                     'name': category['name'],
  //                     'image': category['image'],
  //                   }));
  //           isLoading = false;
  //         });
  //       }
  //     }
  //   } catch (e) {
  //     print('Error fetching categories: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  Future<void> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:9174/api/auth/sub/all'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          setState(() {
            categories = List<Map<String, dynamic>>.from(
              data['subCategories'].map((sub) => {
                    'id': sub['_id'],
                    'name': sub['name'],
                    'image': sub['image'],
                    // extra (useful later)
                    'mainCategoryId': sub['category']['_id'],
                    'mainCategoryName': sub['category']['name'],
                  }),
            );
            isLoading = false;
          });
        } else {
          isLoading = false;
        }
      } else {
        isLoading = false;
      }
    } catch (e) {
      debugPrint('Error fetching sub categories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // final List<Map<String, dynamic>> categories = [
  //   {"name": "House", "icon": Icons.home},
  //   {"name": "Villa", "icon": Icons.villa},
  //   {"name": "Apart..", "icon": Icons.apartment},
  //   {"name": "Hotel", "icon": Icons.hotel},
  //   {"name": "Land", "icon": Icons.terrain},
  //   {"name": "Gated..", "icon": Icons.security},
  //   {"name": "Farm..", "icon": Icons.agriculture},
  //   {
  //     "name": "Studio..",
  //     "icon": Icons.stadium
  //   }, // Replace with proper icon if needed
  // ];

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text(
  //         'Categories',
  //         style: TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //       centerTitle: true,
  //       leading: IconButton(
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //         icon: const Icon(Icons.arrow_back_ios),
  //       ),
  //       backgroundColor: Colors.white,
  //       foregroundColor: Colors.black,
  //       elevation: 0,
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.all(8),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(12),
  //               color: Colors.white,
  //               boxShadow: const [
  //                 BoxShadow(
  //                   color: Colors.black12,
  //                   blurRadius: 6,
  //                   offset: Offset(0, 2),
  //                 )
  //               ],
  //             ),
  //             child: GridView.builder(
  //               shrinkWrap: true,
  //               itemCount: categories.length,
  //               physics: const NeverScrollableScrollPhysics(),
  //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                 crossAxisCount: 4,
  //                 mainAxisSpacing: 12,
  //                 crossAxisSpacing: 12,
  //                 childAspectRatio: 0.85,
  //               ),
  //               itemBuilder: (context, index) {
  //                 bool isSelected = index == selectedIndex;
  //                 return GestureDetector(
  //                   onTap: () {
  //                     setState(() {
  //                       selectedIndex = index;
  //                     });
  //                   },
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(12),
  //                       gradient: isSelected
  //                           ? const LinearGradient(
  //                               colors: [
  //                                 Color(0xFF00A8E8),
  //                                 Color(0xFF2BBBAD),
  //                               ],
  //                               begin: Alignment.topLeft,
  //                               end: Alignment.bottomRight,
  //                             )
  //                           : null,
  //                       color: isSelected ? null : Colors.white,
  //                       border: Border.all(
  //                         color: isSelected
  //                             ? Colors.transparent
  //                             : Colors.grey.shade300,
  //                         width: 1.5,
  //                       ),
  //                     ),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Icon(
  //                           categories[index]['icon'],
  //                           color: isSelected
  //                               ? Colors.white
  //                               : const Color(0xFF2BBBAD),
  //                           size: 28,
  //                         ),
  //                         const SizedBox(height: 6),
  //                         Text(
  //                           categories[index]['name'],
  //                           textAlign: TextAlign.center,
  //                           style: TextStyle(
  //                             fontSize: 13,
  //                             fontWeight: FontWeight.bold,
  //                             color: isSelected ? Colors.white : Colors.black,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : categories.isEmpty
                      ? const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Text('No categories available'),
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          itemCount: categories.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 0.85,
                          ),
                          itemBuilder: (context, index) {
                            bool isSelected = index == selectedIndex;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateListingScreen(
                                      subcategoryId: categories[index]['id'],
                                      name: categories[index]['name'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: isSelected
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF00A8E8),
                                            Color(0xFF2BBBAD),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : null,
                                  color: isSelected ? null : Colors.white,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.transparent
                                        : Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        categories[index]['image'],
                                        width: 32,
                                        height: 32,
                                        fit: BoxFit.cover,
                                        color: isSelected ? Colors.white : null,
                                        colorBlendMode:
                                            isSelected ? BlendMode.srcIn : null,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.category,
                                            color: isSelected
                                                ? Colors.white
                                                : const Color(0xFF2BBBAD),
                                            size: 28,
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      categories[index]['name'].length > 8
                                          ? '${categories[index]['name'].substring(0, 8)}..'
                                          : categories[index]['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}



















// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   int selectedIndex = 0;

//   List<Map<String, dynamic>> categories = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//   }

//   Future<void> fetchCategories() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:9174/api/auth/sub/all'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['success'] == true) {
//           setState(() {
//             categories = List<Map<String, dynamic>>.from(
//               data['subCategories'].map((sub) => {
//                     'id': sub['_id'],
//                     'name': sub['name'],
//                     'image': sub['image'],
//                     // extra (useful later)
//                     'mainCategoryId': sub['category']['_id'],
//                     'mainCategoryName': sub['category']['name'],
//                   }),
//             );
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       debugPrint('Error fetching sub categories: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   int _getCrossAxisCount(double width) {
//     if (width > 1200) return 8;
//     if (width > 900) return 6;
//     if (width > 600) return 5;
//     return 4;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final crossAxisCount = _getCrossAxisCount(screenWidth);

//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const Text(
//           'Categories',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 1400),
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     color: Colors.white,
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 8,
//                         offset: Offset(0, 2),
//                       )
//                     ],
//                   ),
//                   child: isLoading
//                       ? const Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(60.0),
//                             child: CircularProgressIndicator(),
//                           ),
//                         )
//                       : categories.isEmpty
//                           ? const Center(
//                               child: Padding(
//                                 padding: EdgeInsets.all(60.0),
//                                 child: Column(
//                                   children: [
//                                     Icon(
//                                       Icons.category_outlined,
//                                       size: 64,
//                                       color: Colors.grey,
//                                     ),
//                                     SizedBox(height: 16),
//                                     Text(
//                                       'No categories available',
//                                       style: TextStyle(
//                                         fontSize: 16,
//                                         color: Colors.grey,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : GridView.builder(
//                               shrinkWrap: true,
//                               itemCount: categories.length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               gridDelegate:
//                                   SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: crossAxisCount,
//                                 mainAxisSpacing: 16,
//                                 crossAxisSpacing: 16,
//                                 childAspectRatio: 0.85,
//                               ),
//                               itemBuilder: (context, index) {
//                                 bool isSelected = index == selectedIndex;
//                                 return _CategoryCard(
//                                   category: categories[index],
//                                   isSelected: isSelected,
//                                   onTap: () {
//                                     setState(() {
//                                       selectedIndex = index;
//                                     });
//                                   },
//                                 );
//                               },
//                             ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _CategoryCard extends StatefulWidget {
//   final Map<String, dynamic> category;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const _CategoryCard({
//     required this.category,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   State<_CategoryCard> createState() => _CategoryCardState();
// }

// class _CategoryCardState extends State<_CategoryCard> {
//   bool _isHovered = false;

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => setState(() => _isHovered = true),
//       onExit: (_) => setState(() => _isHovered = false),
//       child: GestureDetector(
//         onTap: widget.onTap,
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             gradient: widget.isSelected
//                 ? const LinearGradient(
//                     colors: [
//                       Color(0xFF00A8E8),
//                       Color(0xFF2BBBAD),
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   )
//                 : null,
//             color: widget.isSelected ? null : Colors.white,
//             border: Border.all(
//               color: widget.isSelected
//                   ? Colors.transparent
//                   : _isHovered
//                       ? const Color(0xFF2BBBAD)
//                       : Colors.grey.shade300,
//               width: _isHovered ? 2 : 1.5,
//             ),
//             boxShadow: _isHovered || widget.isSelected
//                 ? [
//                     BoxShadow(
//                       color: widget.isSelected
//                           ? const Color(0xFF2BBBAD).withOpacity(0.3)
//                           : Colors.black12,
//                       blurRadius: 8,
//                       offset: const Offset(0, 4),
//                     )
//                   ]
//                 : null,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   widget.category['image'],
//                   width: 40,
//                   height: 40,
//                   fit: BoxFit.cover,
//                   color: widget.isSelected ? Colors.white : null,
//                   colorBlendMode: widget.isSelected ? BlendMode.srcIn : null,
//                   errorBuilder: (context, error, stackTrace) {
//                     return Icon(
//                       Icons.category,
//                       color: widget.isSelected
//                           ? Colors.white
//                           : const Color(0xFF2BBBAD),
//                       size: 32,
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4),
//                 child: Text(
//                   widget.category['name'],
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: widget.isSelected ? Colors.white : Colors.black87,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }