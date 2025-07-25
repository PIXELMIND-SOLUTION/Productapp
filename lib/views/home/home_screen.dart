import 'package:flutter/material.dart';
import 'package:product_app/views/Notifications/notification_screen.dart';
import 'package:product_app/views/category/category_screen.dart';
import 'package:product_app/views/nearesthouses/nearest_houses.dart';

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
      "price": 25000,
      "bed": 4,
      "bath": 2,
      "area": 7500
    },
    {
      "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      "tag": "For Sale",
      "title": "Luxury Villa with Pool",
      "price": 750000,
      "bed": 4,
      "bath": 2,
      "area": 7500
    },
    {
      "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      "tag": "For Sale",
      "title": "Cozy 2BHK House",
      "price": 18000,
      "bed": 4,
      "bath": 2,
      "area": 7500
    },
    {
      "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      "tag": "For Sale",
      "title": "Sea View Apartment",
      "price": 32000,
      "bed": 4,
      "bath": 2,
      "area": 7500
    },
    {
      "imageUrl": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      "tag": "For Sale",
      "title": "Boutique Hotel Space",
      "price": 150000,
      "bed": 4,
      "bath": 2,
      "area": 7500
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
          Icon(Icons.location_on, color: Colors.black),
          SizedBox(width: 16),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
              },
              child: const Icon(Icons.notifications_none, color: Colors.black)),
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
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(
                    radius: 22,
                    backgroundColor: Color.fromARGB(255, 86, 235, 220),
                    child: Icon(
                      Icons.tune,
                      color: Colors.white,
                    )),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _choiceChip('Rent', false),
                _choiceChip('Buy', true),
                _choiceChip('Sell', false),
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
                            onPressed: () {},
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
                            builder: (context) => CategoryScreen()));
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
                final product = products[index];
                return _houseCard(
                    imageUrl: product['imageUrl'],
                    tag: product['tag'],
                    title: product['title'],
                    price: product['price'],
                    bed: product['bed'].toString(),
                    bath: product['bath'].toString(),
                    area: product['area']);
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
        color: selected
            ? const Color.fromARGB(255, 86, 235, 220)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected
              ? const Color.fromARGB(255, 86, 235, 220)
              : Colors.grey[300]!,
          width: 1,
        ),
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

  // Widget _categoryIcon(String label, IconData icon) {
  Widget _categoryIcon(String label, IconData icon) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 86, 235, 220),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: Icon(
                icon,
                color: const Color.fromARGB(255, 86, 235, 220),
                size: 20,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _houseCard(
      {required String imageUrl,
      required String tag,
      required String title,
      required dynamic price,
      required String bath,
      required String bed,
      required dynamic area}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NearestHouses()));
                },
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    imageUrl,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(tag, style: TextStyle(color: Colors.black)),
                ),
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.favorite_border, color: Colors.red),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Text('$price',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Icon(Icons.bed, size: 16),
                      SizedBox(width: 4),
                      Text(bed)
                    ]),
                    Row(children: [
                      Icon(Icons.bathtub, size: 16),
                      SizedBox(width: 4),
                      Text(bath)
                    ]),
                    Row(children: [
                      Icon(Icons.square_foot, size: 16),
                      SizedBox(width: 4),
                      Text('$area')
                    ]),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
