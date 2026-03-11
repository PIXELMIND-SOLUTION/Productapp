// import 'package:flutter/material.dart';
// import 'package:product_app/views/Buy/mobile_screen.dart';

// class BuyScreen extends StatefulWidget {
//   const BuyScreen({super.key});

//   @override
//   State<BuyScreen> createState() => _BuyScreenState();
// }

// class _BuyScreenState extends State<BuyScreen> {
//   int selectedIndex = 0;

//   final List<Map<String, dynamic>> categories = [
//     {"name": "Cars", "icon": Icons.directions_car},
//     {"name": "Mobiles", "icon": Icons.smartphone},
//     {"name": "Bikes", "icon": Icons.pedal_bike},
//     {"name": "Electronics", "icon": Icons.devices},
//     {"name": "Furniture", "icon": Icons.chair},
//     {"name": "Fashion", "icon": Icons.checkroom},
//     {"name": "Books", "icon": Icons.menu_book},
//     {"name": "Services", "icon": Icons.build},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Buy',
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
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 itemCount: categories.length,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 4,
//                   mainAxisSpacing: 12,
//                   crossAxisSpacing: 12,
//                   childAspectRatio: 0.85,
//                 ),
//                 itemBuilder: (context, index) {
//                   bool isSelected = index == selectedIndex;
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedIndex = index;
//                       });

//                       if (categories[index]['name'] == 'Mobiles') {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const MobileScreen(),
//                           ),
//                         );
//                       }                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(
//                           color: isSelected ? const Color(0xFF2BBBAD) : Colors.grey.shade300,
//                           width: 1.5,
//                         ),
//                         gradient: isSelected
//                             ? const LinearGradient(
//                                 colors: [Color(0xFF00A8E8), Color(0xFF2BBBAD)],
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                               )
//                             : null,
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             categories[index]['icon'],
//                             color: isSelected ? Colors.white : const Color.fromARGB(255, 157, 218, 211),
//                             size: 23,
//                           ),
//                           const SizedBox(height: 6),
//                           Text(
//                             categories[index]['name'],
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                               color: isSelected ? Colors.white : Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:product_app/views/Buy/mobile_screen.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;
  String? errorMessage;

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

      print(
          'response status code for get sub categories ${response.statusCode}');
      print(
          'response bodyyyyyyyyyyyyy for get sub categories ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          List<Map<String, dynamic>> fetchedCategories = [];

          // Filter only "Buy" category items
          for (var subCategory in data['subCategories']) {
            if (subCategory['category']['name'] == 'Buy') {
              fetchedCategories.add({
                'id': subCategory['_id'],
                'name': subCategory['name'],
                'image': subCategory['image'],
                'icon': _getIconForCategory(subCategory['name']),
              });
            }
          }

          setState(() {
            categories = fetchedCategories;
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Failed to load categories';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Server error: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  IconData _getIconForCategory(String name) {
    switch (name.toLowerCase()) {
      case 'car':
      case 'cars':
        return Icons.directions_car;
      case 'mobiles':
        return Icons.smartphone;
      case 'bikes':
        return Icons.pedal_bike;
      case 'electronics & appliances':
        return Icons.devices;
      case 'furniture':
        return Icons.chair;
      case 'fashion':
        return Icons.checkroom;
      case 'books,sports':
        return Icons.menu_book;
      case 'services':
        return Icons.build;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buy',
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
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(
                          color: Color(0xFF2BBBAD),
                        ),
                      ),
                    )
                  : errorMessage != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                      errorMessage = null;
                                    });
                                    fetchCategories();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2BBBAD),
                                  ),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
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

                                if (categories[index]['name'] == 'Mobiles') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MobileScreen(),
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFF2BBBAD)
                                        : Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                  gradient: isSelected
                                      ? const LinearGradient(
                                          colors: [
                                            Color(0xFF00A8E8),
                                            Color(0xFF2BBBAD)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        )
                                      : null,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        categories[index]['image'],
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                        color: isSelected ? Colors.white : null,
                                        colorBlendMode: isSelected
                                            ? BlendMode.srcATop
                                            : null,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            categories[index]['icon'],
                                            color: isSelected
                                                ? Colors.white
                                                : const Color.fromARGB(
                                                    255, 157, 218, 211),
                                            size: 40,
                                          );
                                        },
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  isSelected
                                                      ? Colors.white
                                                      : const Color(0xFF2BBBAD),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      categories[index]['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.black,
                                      ),
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
