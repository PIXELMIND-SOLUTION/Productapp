import 'package:flutter/material.dart';
import 'package:product_app/views/Buy/mobile_screen.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({super.key});

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
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
                            builder: (context) => const MobileScreen(),
                          ),
                        );
                      }                     },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF2BBBAD) : Colors.grey.shade300,
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
                            color: isSelected ? Colors.white : const Color.fromARGB(255, 157, 218, 211),
                            size: 23,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            categories[index]['name'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
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