import 'package:flutter/material.dart';
import 'package:product_app/profile/edit_profile.dart';
import 'package:product_app/views/location_screen.dart';
import 'package:product_app/views/posting/posting_details.dart';
import 'package:product_app/views/subscription/subscription_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Divider(),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                    color: const Color(0xFF00A8E8)), // using your first color
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Color(0xFF2BBBAD), 
                      ),
                      const SizedBox(width: 8), 
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditProfile()));
                        },
                        child: const Text(
                          'Personal Information',
                          style: TextStyle(
                              color: Color(0xFF2BBBAD)), 
                        ),
                      ),
                    ],
                  ),

                  // Icon at the end
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Texts side-by-side
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 8), // space between icon and text
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LocationScreen()));
                          },
                          child: const Text('Change Address')),
                    ],
                  ),

                  // Icon at the end
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostingDetails()));
              },
              child: Container(
                width: 330,
                height: 50,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(6)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        (Icon(Icons.grid_view)),
                        SizedBox(width: 8), 
                        Text('My Postings'),
                      ],
                    ),

                    // Icon at the end
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubscriptionScreen()));
              },
              child: Container(
                width: 330,
                height: 50,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(6)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        (Icon(Icons.workspace_premium)),
                        SizedBox(width: 8), // space between icon and text
                        Text('Upgrade to premium'),
                      ],
                    ),

                    // Icon at the end
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Account',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Texts side-by-side
                  Row(
                    children: [
                      Icon(Icons.help_outline),

                      SizedBox(width: 8), // space between icon and text
                      Text('Need Help?'),
                    ],
                  ),

                  // Icon at the end
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Texts side-by-side
                  Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 8), // space between icon and text
                      Text('Contact Us'),
                    ],
                  ),

                  // Icon at the end
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: 330,
              height: 50,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(6)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Texts side-by-side
                  Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      SizedBox(width: 8), // space between icon and text
                      Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),

                  // Icon at the end
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
