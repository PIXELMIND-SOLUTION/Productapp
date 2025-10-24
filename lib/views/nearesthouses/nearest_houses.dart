import 'package:flutter/material.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';

class NearestHouses extends StatelessWidget {
  const NearestHouses({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> houseList = List.generate(3, (_) {
      return {
        "title": "Luxury House LakeView Estate",
        "location": "Kakinada",
        "price": "₹4,00,000",
        "beds": "4 Bed",
        "baths": "3 Bath",
        "area": "7,500 sqft",
        "image":
            "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png", // You can replace this
      };
    });

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
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: houseList.length,
        itemBuilder: (context, index) {
          final house = houseList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NearestHouseDetail()));
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: index == 1 ? Colors.grey.shade300 : Colors.grey.shade300,
                  width: index == 1 ? 1.5 : 1,
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
                        child: Image.asset(
                          house['image'],
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "For Sale",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                      // Positioned(
                      //   bottom: 8,
                      //   right: 8,
                      //   child: Container(
                      //     padding:
                      //         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      //     decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //     child: Text(
                      //       house['price'],
                      //       style: const TextStyle(
                      //           fontWeight: FontWeight.bold, fontSize: 14),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.favorite_border,color: Colors.black,),
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
                      _iconText(Icons.bed_outlined, house['beds']),
                      const SizedBox(width: 8),
                      _iconText(Icons.bathtub_outlined, house['baths']),
                      const SizedBox(width: 8),
                      _iconText(Icons.square_foot, house['area']),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16,color: Color(0xFF00A8E8),),
                      SizedBox(width: 10,),
                      Text(
                        house['location'],
                        style: const TextStyle(fontSize: 13,color: Color.fromARGB(255, 118, 118, 118)),
                      )
                    ],
                  ),
                ],
              ),
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
