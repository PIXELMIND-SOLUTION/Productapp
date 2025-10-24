import 'package:flutter/material.dart';
import 'package:product_app/views/Buy/buy_screen.dart';
import 'package:product_app/views/Notifications/notification_screen.dart';
import 'package:product_app/views/category/category_screen.dart';
import 'package:product_app/views/location_screen.dart';
import 'package:product_app/views/nearesthouses/nearest_houses.dart';
import 'package:product_app/views/sell/sell_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> products = [
    {
      "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      "tag": "For Sale",
      "title": "Modern Apartment in City Center",
      "location": "Kakinada",
      "price": "₹25,000",
      "bed": "4 Bed",
      "bath": "2 Bath",
      "area": "7,500 sqft"
    },
    {
      "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      "tag": "For Sale",
      "title": "Luxury Villa with Pool",
      "location": "Kakinada",
      "price": "₹7,50,000",
      "bed": "4 Bed",
      "bath": "2 Bath",
      "area": "7,500 sqft"
    },
    {
      "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      "tag": "For Sale",
      "title": "Cozy 2BHK House",
      "location": "Kakinada",
      "price": "₹18,000",
      "bed": "4 Bed",
      "bath": "2 Bath",
      "area": "7,500 sqft"
    },
    {
      "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      "tag": "For Sale",
      "title": "Sea View Apartment",
      "location": "Kakinada",
      "price": "₹32,000",
      "bed": "4 Bed",
      "bath": "2 Bath",
      "area": "7,500 sqft"
    },
    {
      "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      "tag": "For Sale",
      "title": "Boutique Hotel Space",
      "location": "Kakinada",
      "price": "₹1,50,000",
      "bed": "4 Bed",
      "bath": "2 Bath",
      "area": "7,500 sqft"
    },
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage(
                'lib/assets/403079b6b3230e238d25d0e18c175d870e3223de.png'),
          ),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Morning',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            Text('PMS',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>const LocationScreen()));
            },
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey)),
                child:const Icon(Icons.location_on, color: Colors.black)),
          ),
        const  SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationScreen()));
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.notifications_none, color: Colors.black),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      // Border when the TextField is not focused
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(
                              255, 221, 221, 221), // Your border color here
                          width: 2,
                        ),
                      ),
                      // Border when the TextField is focused
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(
                              255, 217, 216, 216), // Border color when focused
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 44, // radius * 2
                  height: 44,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF00A8E8),
                        Color(0xFF2BBBAD),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.tune,
                      color: Colors.white,
                    ),
                  ),
                )

                // const CircleAvatar(
                //     radius: 22,
                //     backgroundColor: Color.fromARGB(255, 86, 235, 220),
                //     child: Icon(
                //       Icons.tune,
                //       color: Colors.white,
                //     )),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _choiceChip('Listing', false),
                GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BuyScreen()));
                    },
                    child: _choiceChip('Buy', true)),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellCategory()));
                    },
                    child: _choiceChip('Sell', false)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  _categoryIcon('House', Icons.house),
                  SizedBox(width: 8),
                  _categoryIcon('Villa', Icons.villa),
                  SizedBox(width: 8),
                  _categoryIcon('Apart.', Icons.apartment),
                  SizedBox(width: 8),
                  _categoryIcon('Hotel', Icons.hotel),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: 'All Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryScreen()));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.black,
                            ))),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text('Nearest Houses',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 126,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NearestHouses()));
                  },
                  child: Text('See All', style: TextStyle(color: Colors.black)),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 13,
                )
              ],
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final house = products[index];
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NearestHouses()));
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                house['imageUrl'],
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
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
                                house['tag'],
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
                              child: IconButton(
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.black,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          )
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
                          _iconText(Icons.bed_outlined, house['bed']),
                          const SizedBox(width: 8),
                          _iconText(Icons.bathtub_outlined, house['bath']),
                          const SizedBox(width: 8),
                          _iconText(Icons.square_foot, house['area']),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 16),
                          Text(
                            house['location'],
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _choiceChip(String label, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? Colors.transparent : Colors.grey[300]!,
          width: 1,
        ),
        gradient: selected
            ? const LinearGradient(
                colors: [
                  Color(0xFF00A8E8),
                  Color(0xFF2BBBAD),
                ],
              )
            : null,
        color: selected ? null : Colors.transparent,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.grey[700],
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

//  Widget _categoryIcon(String label, IconData icon) {
//   return Expanded(
//     child: Container(
//       height: 80,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16),
//         color: label == "House" ? null : const Color.fromARGB(255, 228, 227, 227),
//         gradient: label == "House"
//             ? const LinearGradient(
//                 colors: [
//                   Color(0xFF00A8E8),
//                   Color(0xFF2BBBAD),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               )
//             : null,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           CircleAvatar(
//             radius: 20,
//             backgroundColor: Colors.white,
//             child: Icon(
//               icon,
//               color: label == "House" ? const Color(0xFF00A8E8) : const Color(0xFF56EBDC),
//               size: 20,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             label,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Colors.white,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

  Widget _categoryIcon(String label, IconData icon) {
    final bool isHouse = label == "House";

    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isHouse ? null : const Color.fromARGB(255, 243, 243, 243),
          gradient: isHouse
              ? const LinearGradient(
                  colors: [
                    Color(0xFF00A8E8),
                    Color(0xFF2BBBAD),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color:
                    isHouse ? const Color(0xFF00A8E8) : const Color(0xFF2BBBAD),
                size: 20,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isHouse ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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
