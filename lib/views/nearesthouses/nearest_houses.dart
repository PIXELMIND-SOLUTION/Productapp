import 'package:flutter/material.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/utils/call_utils.dart';
import 'package:product_app/utils/whatsapp_utils.dart';
import 'package:product_app/utils/location_utils.dart';
import 'package:product_app/views/Details/nearest_house_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NearestHouses extends StatefulWidget {
  const NearestHouses({super.key});

  @override
  State<NearestHouses> createState() => _NearestHousesState();
}

class _NearestHousesState extends State<NearestHouses> {
  List<Map<String, dynamic>> houseList = [];
  bool isLoading = true;
  String? errorMessage;
  
  // Default agent phone number - replace with actual agent number from your data
  final String agentPhone = "919961593179";

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
                'latitude': product['latitude'] ?? 28.6139, // Add actual latitude from your data
                'longitude': product['longitude'] ?? 77.2090, // Add actual longitude from your data
                'description': product['description']?.toString() ?? 
                    'Beautiful property located in prime area with modern amenities and peaceful surroundings.',
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Icon(Icons.arrow_back, size: 18, color: Colors.black87),
          ),
        ),
        title: const Text(
          "Nearest Properties",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          errorMessage!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: fetchNearestProducts,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE33629),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  ),
                )
              : houseList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.home_outlined,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'No Properties Found',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'We couldn\'t find any properties near your location',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: houseList.length,
                      itemBuilder: (context, index) {
                        final house = houseList[index];
                        return _buildPropertyCard(house);
                      },
                    ),
    );
  }

  Widget _buildPropertyCard(Map<String, dynamic> house) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Property Image (Tappable)
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NearestHouseDetail(house: house),
                ),
              );
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: house['image'].toString().startsWith('http')
                        ? Image.network(
                            house['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Icon(Icons.image_not_supported, size: 50),
                                ),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: Colors.grey.shade300,
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 50),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      house['tag'],
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title (Tappable)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NearestHouseDetail(house: house),
                      ),
                    );
                  },
                  child: Text(
                    house['title'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                /// Location
                Row(
                  children: [
                    Image.asset(
                      'assets/images/location.png',
                      width: 14,
                      height: 14,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.location_on, size: 14, color: Colors.grey);
                      },
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        house['location'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Stats Row
                Row(
                  children: [
                    _StatChip(
                      imagePath: 'assets/images/bed.png',
                      label: house['beds'],
                    ),
                    const SizedBox(width: 12),
                    _StatChip(
                      imagePath: 'assets/images/bath.png',
                      label: house['baths'],
                    ),
                    const SizedBox(width: 12),
                    _StatChip(
                      imagePath: 'assets/images/sqft.png',
                      label: house['area'],
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Divider(color: Colors.grey.shade200, height: 1),
                const SizedBox(height: 12),

                /// Action Buttons
                Row(
                  children: [
                    _CallButton(
                      onTap: () {
                        // Show call options
                        CallUtils.showCallOptions(
                          context: context,
                          phoneNumber: agentPhone,
                          name: "Property Agent",
                          showMessage: true,
                          showWhatsApp: true,
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    _ActionButton(
                      imagePath: 'assets/images/whatsapp.png',
                      label: "Whatsapp",
                      onTap: () {
                        // Share property via WhatsApp
                        WhatsAppUtils.shareProperty(
                          context: context,
                          propertyTitle: house['title'],
                          propertyLocation: house['location'],
                          propertyPrice: house['price'],
                          agentPhone: agentPhone,
                        );
                      },
                    ),
                    const Spacer(),
                    _ActionButton(
                      imagePath: 'assets/images/location.png',
                      label: "Location",
                      onTap: () {
                        // Show location options
                        LocationUtils.showMapOptions(
                          context: context,
                          latitude: house['latitude'] ?? 28.6139,
                          longitude: house['longitude'] ?? 77.2090,
                          address: house['location'],
                          locationName: house['title'],
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// View Details Button
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NearestHouseDetail(house: house),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "View Details",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat Chip ────────────────────────────────────────────────────────────────
class _StatChip extends StatelessWidget {
  final String imagePath;
  final String label;

  const _StatChip({
    required this.imagePath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 14,
          height: 14,
          errorBuilder: (_, __, ___) {
            return Container(
              width: 14,
              height: 14,
              color: Colors.grey,
            );
          },
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

// ── Call Button ──────────────────────────────────────────────────────────────
class _CallButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CallButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: const Color(0xFFE33629),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          "Call",
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ── Action Button ────────────────────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 16,
            height: 16,
            errorBuilder: (_, __, ___) {
              return Container(
                width: 16,
                height: 16,
                color: Colors.grey,
              );
            },
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}