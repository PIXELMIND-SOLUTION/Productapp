import 'package:flutter/material.dart';
import 'package:product_app/views/sell/car_sell_screen.dart';
import 'package:product_app/views/sell/mobile_sell_screen.dart';

class SellCategory extends StatefulWidget {
  const SellCategory({super.key});

  @override
  State<SellCategory> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<SellCategory> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {"name": "Cars", "icon": Icons.directions_car},
    {"name": "Mobiles", "icon": Icons.smartphone},
    {"name": "Bikes", "icon": Icons.pedal_bike},
    {"name": "Electronics", "icon": Icons.devices},
    {"name": "Furniture", "icon": Icons.chair},
    {"name": "Fashion", "icon": Icons.checkroom},
    {"name": "Books", "icon": Icons.menu_book},
    {"name": "Services", "icon": Icons.build},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sell',
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
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            builder: (context) => const MobileSellScreen(),
                          ),
                        );
                      } else if (categories[index]['name'] == 'Cars') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CarSellScreen(),
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
                                colors: [Color(0xFF00A8E8), Color(0xFF2BBBAD)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            categories[index]['icon'],
                            color: isSelected
                                ? Colors.white
                                : const Color.fromARGB(255, 157, 218, 211),
                            size: 23,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            categories[index]['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.black,
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




// import 'package:flutter/material.dart';
// import 'package:product_app/views/sell/car_sell_screen.dart';
// import 'package:product_app/views/sell/mobile_sell_screen.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SellCategory extends StatefulWidget {
//   const SellCategory({super.key});

//   @override
//   State<SellCategory> createState() => _BuyScreenState();
// }

// class _BuyScreenState extends State<SellCategory> {
//   int selectedIndex = 0;
//   List<Map<String, dynamic>> categories = [];
//   bool isLoading = true;
//   String? errorMessage;

//   // Icon mapping for categories
//   final Map<String, IconData> iconMapping = {
//     "Cars": Icons.directions_car,
//     "Car": Icons.directions_car,
//     "Mobiles": Icons.smartphone,
//     "Bikes": Icons.pedal_bike,
//     "Electronics & Appliances": Icons.devices,
//     "Elictronic & Appliances": Icons.devices,
//     "Furniture": Icons.chair,
//     "Fashion": Icons.checkroom,
//     "Books,Sports": Icons.menu_book,
//     "Services": Icons.build,
//   };

//   @override
//   void initState() {
//     super.initState();
//     fetchSubCategories();
//   }

//   Future<void> fetchSubCategories() async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:9174/api/auth/sub/all'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['success'] == true) {
//           List<dynamic> subCategories = data['subCategories'];

//           // Filter only "Sell" category items
//           List<Map<String, dynamic>> sellCategories = subCategories
//               .where((item) => item['category']['name'] == 'Sell')
//               .map((item) {
//             String name = item['name'];
//             return {
//               "id": item['_id'],
//               "name": name,
//               "icon": iconMapping[name] ?? Icons.category,
//               "image": item['image'],
//             };
//           }).toList();

//           setState(() {
//             categories = sellCategories;
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             errorMessage = 'Failed to load categories';
//             isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           errorMessage = 'Server error: ${response.statusCode}';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorMessage = 'Error: $e';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Sell',
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
//                   : errorMessage != null
//                       ? Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(20.0),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   errorMessage!,
//                                   style: const TextStyle(color: Colors.red),
//                                   textAlign: TextAlign.center,
//                                 ),
//                                 const SizedBox(height: 10),
//                                 ElevatedButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       isLoading = true;
//                                       errorMessage = null;
//                                     });
//                                     fetchSubCategories();
//                                   },
//                                   child: const Text('Retry'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       : categories.isEmpty
//                           ? const Center(
//                               child: Padding(
//                                 padding: EdgeInsets.all(40.0),
//                                 child: Text('No categories available'),
//                               ),
//                             )
//                           : GridView.builder(
//                               shrinkWrap: true,
//                               itemCount: categories.length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 4,
//                                 mainAxisSpacing: 12,
//                                 crossAxisSpacing: 12,
//                                 childAspectRatio: 0.85,
//                               ),
//                               itemBuilder: (context, index) {
//                                 bool isSelected = index == selectedIndex;
//                                 return GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedIndex = index;
//                                     });

//                                     if (categories[index]['name'] ==
//                                         'Mobiles') {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               const MobileSellScreen(),
//                                         ),
//                                       );
//                                     } else if (categories[index]['name'] ==
//                                         'Cars') {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               const CarSellScreen(),
//                                         ),
//                                       );
//                                     }
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(12),
//                                       border: Border.all(
//                                         color: isSelected
//                                             ? const Color(0xFF2BBBAD)
//                                             : Colors.grey.shade300,
//                                         width: 1.5,
//                                       ),
//                                       gradient: isSelected
//                                           ? const LinearGradient(
//                                               colors: [
//                                                 Color(0xFF00A8E8),
//                                                 Color(0xFF2BBBAD)
//                                               ],
//                                               begin: Alignment.topLeft,
//                                               end: Alignment.bottomRight,
//                                             )
//                                           : null,
//                                     ),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(
//                                           categories[index]['icon'],
//                                           color: isSelected
//                                               ? Colors.white
//                                               : const Color.fromARGB(
//                                                   255, 157, 218, 211),
//                                           size: 23,
//                                         ),
//                                         const SizedBox(height: 6),
//                                         Text(
//                                           categories[index]['name'],
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.w500,
//                                             color: isSelected
//                                                 ? Colors.white
//                                                 : Colors.black,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
