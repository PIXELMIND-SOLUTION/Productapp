// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:product_app/views/Listing/listing_screen.dart';

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

//   // Future<void> fetchCategories() async {
//   //   try {
//   //     final response = await http.get(
//   //       Uri.parse('http://31.97.206.144:9174/api/auth/get/MainCategories'),
//   //     );

//   //     if (response.statusCode == 200) {
//   //       final data = json.decode(response.body);
//   //       if (data['success'] == true) {
//   //         setState(() {
//   //           categories = List<Map<String, dynamic>>.from(
//   //               data['categories'].map((category) => {
//   //                     'id': category['_id'],
//   //                     'name': category['name'],
//   //                     'image': category['image'],
//   //                   }));
//   //           isLoading = false;
//   //         });
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching categories: $e');
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }

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
//           isLoading = false;
//         }
//       } else {
//         isLoading = false;
//       }
//     } catch (e) {
//       debugPrint('Error fetching sub categories: $e');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: const Text(
//   //         'Categories',
//   //         style: TextStyle(fontWeight: FontWeight.bold),
//   //       ),
//   //       centerTitle: true,
//   //       leading: IconButton(
//   //         onPressed: () {
//   //           Navigator.of(context).pop();
//   //         },
//   //         icon: const Icon(Icons.arrow_back_ios),
//   //       ),
//   //       backgroundColor: Colors.white,
//   //       foregroundColor: Colors.black,
//   //       elevation: 0,
//   //     ),
//   //     body: Padding(
//   //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Container(
//   //             padding: const EdgeInsets.all(8),
//   //             decoration: BoxDecoration(
//   //               borderRadius: BorderRadius.circular(12),
//   //               color: Colors.white,
//   //               boxShadow: const [
//   //                 BoxShadow(
//   //                   color: Colors.black12,
//   //                   blurRadius: 6,
//   //                   offset: Offset(0, 2),
//   //                 )
//   //               ],
//   //             ),
//   //             child: GridView.builder(
//   //               shrinkWrap: true,
//   //               itemCount: categories.length,
//   //               physics: const NeverScrollableScrollPhysics(),
//   //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//   //                 crossAxisCount: 4,
//   //                 mainAxisSpacing: 12,
//   //                 crossAxisSpacing: 12,
//   //                 childAspectRatio: 0.85,
//   //               ),
//   //               itemBuilder: (context, index) {
//   //                 bool isSelected = index == selectedIndex;
//   //                 return GestureDetector(
//   //                   onTap: () {
//   //                     setState(() {
//   //                       selectedIndex = index;
//   //                     });
//   //                   },
//   //                   child: Container(
//   //                     decoration: BoxDecoration(
//   //                       borderRadius: BorderRadius.circular(12),
//   //                       gradient: isSelected
//   //                           ? const LinearGradient(
//   //                               colors: [
//   //                                 Color(0xFF00A8E8),
//   //                                 Color(0xFF2BBBAD),
//   //                               ],
//   //                               begin: Alignment.topLeft,
//   //                               end: Alignment.bottomRight,
//   //                             )
//   //                           : null,
//   //                       color: isSelected ? null : Colors.white,
//   //                       border: Border.all(
//   //                         color: isSelected
//   //                             ? Colors.transparent
//   //                             : Colors.grey.shade300,
//   //                         width: 1.5,
//   //                       ),
//   //                     ),
//   //                     child: Column(
//   //                       mainAxisAlignment: MainAxisAlignment.center,
//   //                       children: [
//   //                         Icon(
//   //                           categories[index]['icon'],
//   //                           color: isSelected
//   //                               ? Colors.white
//   //                               : const Color(0xFF2BBBAD),
//   //                           size: 28,
//   //                         ),
//   //                         const SizedBox(height: 6),
//   //                         Text(
//   //                           categories[index]['name'],
//   //                           textAlign: TextAlign.center,
//   //                           style: TextStyle(
//   //                             fontSize: 13,
//   //                             fontWeight: FontWeight.bold,
//   //                             color: isSelected ? Colors.white : Colors.black,
//   //                           ),
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 );
//   //               },
//   //             ),
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   Widget build(BuildContext context) {
//     return Scaffold(
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
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: Colors.white,
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 6,
//                     offset: Offset(0, 2),
//                   )
//                 ],
//               ),
//               child: isLoading
//                   ? const Center(
//                       child: Padding(
//                         padding: EdgeInsets.all(40.0),
//                         child: CircularProgressIndicator(),
//                       ),
//                     )
//                   : categories.isEmpty
//                       ? const Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(40.0),
//                             child: Text('No categories available'),
//                           ),
//                         )
//                       : GridView.builder(
//                           shrinkWrap: true,
//                           itemCount: categories.length,
//                           physics: const NeverScrollableScrollPhysics(),
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 4,
//                             mainAxisSpacing: 12,
//                             crossAxisSpacing: 12,
//                             childAspectRatio: 0.85,
//                           ),
//                           itemBuilder: (context, index) {
//                             bool isSelected = index == selectedIndex;
//                             return GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedIndex = index;
//                                 });

//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => CreateListingScreen(
//                                       subcategoryId: categories[index]['id'],
//                                       name: categories[index]['name'],
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(12),
//                                   gradient: isSelected
//                                       ? const LinearGradient(
//                                           colors: [
//                                             Color(0xFF00A8E8),
//                                             Color(0xFF2BBBAD),
//                                           ],
//                                           begin: Alignment.topLeft,
//                                           end: Alignment.bottomRight,
//                                         )
//                                       : null,
//                                   color: isSelected ? null : Colors.white,
//                                   border: Border.all(
//                                     color: isSelected
//                                         ? Colors.transparent
//                                         : Colors.grey.shade300,
//                                     width: 1.5,
//                                   ),
//                                 ),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: Image.network(
//                                         categories[index]['image'],
//                                         width: 32,
//                                         height: 32,
//                                         fit: BoxFit.cover,
//                                         color: isSelected ? Colors.white : null,
//                                         colorBlendMode:
//                                             isSelected ? BlendMode.srcIn : null,
//                                         errorBuilder:
//                                             (context, error, stackTrace) {
//                                           return Icon(
//                                             Icons.category,
//                                             color: isSelected
//                                                 ? Colors.white
//                                                 : const Color(0xFF2BBBAD),
//                                             size: 28,
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                     const SizedBox(height: 6),
//                                     Text(
//                                       categories[index]['name'].length > 8
//                                           ? '${categories[index]['name'].substring(0, 8)}..'
//                                           : categories[index]['name'],
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 13,
//                                         fontWeight: FontWeight.bold,
//                                         color: isSelected
//                                             ? Colors.white
//                                             : Colors.black,
//                                       ),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




















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
  int selectedIndex = -1;
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

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
                    'mainCategoryId': sub['category']['_id'],
                    'mainCategoryName': sub['category']['name'],
                  }),
            );
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching sub categories: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get filteredCategories {
    if (searchQuery.isEmpty) {
      return categories;
    }
    return categories
        .where((category) =>
            category['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 600 ? 4 : 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            expandedHeight: 180,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black87,
                  size: 18,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF00A8E8),
                      Color(0xFF2BBBAD),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   'Browse',
                            //   style: TextStyle(
                            //     color: Colors.white70,
                            //     fontSize: 16,
                            //     fontWeight: FontWeight.w500,
                            //   ),
                            // ),
                            SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Categories',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Search categories...',
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey.shade600,
                              ),
                              suffixIcon: searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.grey.shade600,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          searchQuery = '';
                                        });
                                      },
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Categories Grid
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: isLoading
                ? SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF2BBBAD),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Loading categories...',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : filteredCategories.isEmpty
                    ? SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey.shade300,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                searchQuery.isEmpty
                                    ? 'No categories available'
                                    : 'No categories found',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (searchQuery.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Try a different search term',
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    : SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final category = filteredCategories[index];
                            final isSelected = index == selectedIndex;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateListingScreen(
                                      subcategoryId: category['id'],
                                      name: category['name'],
                                    ),
                                  ),
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: isSelected
                                          ? const Color.fromARGB(255, 23, 179, 41)
                                              .withOpacity(0.3)
                                          : Colors.black.withOpacity(0.05),
                                      blurRadius: isSelected ? 15 : 10,
                                      offset: Offset(0, isSelected ? 6 : 4),
                                      spreadRadius: isSelected ? 1 : 0,
                                    ),
                                  ],
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF2BBBAD)
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Image Container
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        gradient: isSelected
                                            ? const LinearGradient(
                                                colors: [
                                                  Color(0xFF00A8E8),
                                                  Color(0xFF2BBBAD),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  const Color(0xFF2BBBAD)
                                                      .withOpacity(0.1),
                                                  const Color(0xFF00A8E8)
                                                      .withOpacity(0.1),
                                                ],
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          category['image'],
                                          fit: BoxFit.cover,
                                          color: isSelected
                                              ? Colors.white.withOpacity(0.9)
                                              : null,
                                          colorBlendMode: isSelected
                                              ? BlendMode.modulate
                                              : null,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Icon(
                                              Icons.category_rounded,
                                              color: isSelected
                                                  ? Colors.white
                                                  : const Color(0xFF2BBBAD),
                                              size: 32,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    // Category Name
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        category['name'],
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? const Color(0xFF2BBBAD)
                                              : Colors.black87,
                                          height: 1.2,
                                        ),
                                      ),
                                    ),
                                    if (isSelected) ...[
                                      const SizedBox(height: 8),
                                      // Container(
                                      //   padding: const EdgeInsets.symmetric(
                                      //     horizontal: 12,
                                      //     vertical: 4,
                                      //   ),
                                      //   decoration: BoxDecoration(
                                      //     gradient: const LinearGradient(
                                      //       colors: [
                                      //         Color(0xFF00A8E8),
                                      //         Color(0xFF2BBBAD),
                                      //       ],
                                      //     ),
                                      //     borderRadius:
                                      //         BorderRadius.circular(12),
                                      //   ),
                                      //   child: const Text(
                                      //     'Selected',
                                      //     style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontSize: 10,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: filteredCategories.length,
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}


