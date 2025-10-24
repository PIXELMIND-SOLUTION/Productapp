// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class PostingDetails extends StatelessWidget {
  const PostingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'My Postings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: const Color(0xFF00BCD4),
                  borderRadius: BorderRadius.circular(25),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black87,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_outlined, size: 18),
                        SizedBox(width: 6),
                        Text('Listings'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.grid_view_outlined, size: 18),
                        SizedBox(width: 6),
                        Text('Products'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildListingsTab(),
            _buildProductsTab(),
          ],
        ),
      ),
    );
  }

  // Listings Tab (Favourite Screen UI)
  Widget _buildListingsTab() {
    final List<Map<String, dynamic>> houseList = List.generate(3, (_) {
      return {
        "title": "Luxury House LakeView Estate",
        "location": "Kakinada",
        "price": "₹4,00,000",
        "beds": "4 Bed",
        "baths": "3 Bath",
        "area": "7,500 sqft",
        "image": "lib/assets/22c7ca7468778df234aab7d17ed03d05c804b058.png",
      };
    });

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: houseList.length,
      itemBuilder: (context, index) {
        final house = houseList[index];
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      house['image'],
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 160,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image, size: 60),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        house['price'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.more_vert,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
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
                  const Icon(Icons.location_on_outlined, size: 16, color: Colors.blue),
                  const SizedBox(width: 10),
                  Text(
                    house['location'],
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Products Tab (Mobile Screen UI)
  Widget _buildProductsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.58,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        final isRed = index % 2 == 1;
        return _buildProductCard(isRed);
      },
    );
  }

  Widget _buildProductCard(bool isRed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: isRed ? const Color(0xFFE8E8E8) : const Color(0xFFF5F5F5),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: isRed
                      ? Image.asset(
                          'lib/assets/iphone14pro.jpg',
                          height: 130,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 90,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.red.shade900.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade900.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade900.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Image.asset(
                          'lib/assets/iphone13.jpg',
                          height: 130,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 75,
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade700,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 12),
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade800,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isRed ? 'Iphone 14 Pro Max' : 'Iphone 16 Pro Max',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                const Text(
                  '₹40000',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'New',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '10/10',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        'Hyderabad',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '22 Sep',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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