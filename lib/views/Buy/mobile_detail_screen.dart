

import 'package:flutter/material.dart';
import 'package:product_app/views/popup/call_popup.dart';

class MobileDetailScreen extends StatelessWidget {
  const MobileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image with overlay buttons
                Stack(
                  children: [
                    // House Image
                    Container(
                      height: 320,
                      width: double.infinity,
                      decoration:const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'lib/assets/iphone14pro.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      height: 320,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Back button
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),

                            // Right buttons
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.favorite_border),
                                    onPressed: () {},
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: IconButton(
                                    icon:
                                        const Icon(Icons.share_rounded), // Example icon
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                // Content section
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  transform: Matrix4.translationValues(0, -20, 0),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        const Text(
                          'Iphone 14 pro max',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                                                const SizedBox(height: 8),


                        const Text(
                          '₹ 40000',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Location
                        Row(
                          children: [
                          const  Icon(
                              Icons.location_on,
                              size: 18,
                              color:  Color.fromARGB(255, 41, 197, 228),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '1-2-12, Gandhi Nagar, kakinada',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      const  SizedBox(height: 13,),
                       const  Divider(),
                        // Features row
                       
                        const SizedBox(height: 24),
                        // Description
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Lorem ipsum dolor is simply dummy text of the printing and typesetting industry. Lorem ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // View Map section
                      const  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             Text(
                              'View on Map',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            // TextButton(
                            //   onPressed: () {},
                            //   child: Text(
                            //     'Map',
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       color: Colors.grey[600],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Map preview
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/assets/map.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 100), // Space for bottom buttons
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom buttons
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF00A8E8),
                              Color(0xFF2BBBAD)
                            ], // your colors
                          ),
                          borderRadius: BorderRadius.circular(30), // pill shape
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_bubble_outline),
                          label: const Text(
                            'Chat',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.transparent, // transparent for gradient
                            shadowColor: Colors.transparent, // remove shadow
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape:
                                const StadiumBorder(), // full curved pill button
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF00A8E8),
                              Color(0xFF2BBBAD)
                            ], // gradient colors
                          ),
                          borderRadius:
                              BorderRadius.circular(30), // rounded shape
                        ),
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CallPopup()));
                          },
                          icon: const Icon(Icons.phone),
                          label: const Text(
                            'Call',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.transparent, 
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: const StadiumBorder(), 
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
