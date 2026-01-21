// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/auth/login_provider.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'package:product_app/profile/edit_profile.dart';
// import 'package:product_app/views/auth/login_screen.dart';
// import 'package:product_app/views/help/contact_us.dart';
// import 'package:product_app/views/help/help_screen.dart';
// import 'package:product_app/views/location/location_screen.dart';
// import 'package:product_app/views/location_screen.dart';
// import 'package:product_app/views/posting/posting_details.dart';
// import 'package:product_app/views/subscription/subscription_screen.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Profile',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             const Divider(),
//             const SizedBox(
//               height: 8,
//             ),
//             Container(
//               width: 330,
//               height: 50,
//               padding: const EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                 border: Border.all(color: const Color(0xFF00A8E8)),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.person,
//                         color: Color(0xFF2BBBAD),
//                       ),
//                       const SizedBox(width: 8),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const EditProfile()));
//                         },
//                         child: const Text(
//                           'Personal Information',
//                           style: TextStyle(color: Color(0xFF2BBBAD)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Icon at the end
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 15,
//                     color: Colors.grey,
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               width: 330,
//               height: 50,
//               padding: const EdgeInsets.all(8.0),
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(6)),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Texts side-by-side
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on),
//                       const SizedBox(width: 8),
//                       GestureDetector(
//                           onTap: () {
//                             final userId = SharedPrefHelper.getUserId();

//                             if (userId == null || userId.isEmpty) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                     content: Text('User ID not found')),
//                               );
//                               return;
//                             }
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>
//                                         LocationFetchScreen(userId: userId)));
//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) =>
//                             //             const LocationScreen()));
//                           },
//                           child: const Text('Change Address')),
//                     ],
//                   ),

//                   // Icon at the end
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 15,
//                     color: Colors.grey,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const PostingDetails()));
//               },
//               child: Container(
//                 width: 330,
//                 height: 50,
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(6)),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         (Icon(Icons.grid_view)),
//                         SizedBox(width: 8),
//                         Text('My Postings'),
//                       ],
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 15,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // const SizedBox(
//             //   height: 10,
//             // ),

//             // GestureDetector(
//             //   onTap: () {
//             //     Navigator.push(
//             //         context,
//             //         MaterialPageRoute(
//             //             builder: (context) => const SubscriptionScreen()));
//             //   },
//             //   child: Container(
//             //     width: 330,
//             //     height: 50,
//             //     padding: const EdgeInsets.all(8.0),
//             //     decoration: BoxDecoration(
//             //         border: Border.all(color: Colors.black),
//             //         borderRadius: BorderRadius.circular(6)),
//             //     child: const Row(
//             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //       children: [
//             //         Row(
//             //           children: [
//             //             (Icon(Icons.workspace_premium)),
//             //             SizedBox(width: 8), // space between icon and text
//             //             Text('Upgrade to premium'),
//             //           ],
//             //         ),

//             //         // Icon at the end
//             //         Icon(
//             //           Icons.arrow_forward_ios,
//             //           size: 15,
//             //           color: Colors.grey,
//             //         ),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Account',
//                     style: TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => HelpScreen()));
//               },
//               child: Container(
//                 width: 330,
//                 height: 50,
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(6)),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Texts side-by-side
//                     Row(
//                       children: [
//                         Icon(Icons.help_outline),

//                         SizedBox(width: 8), // space between icon and text
//                         Text('Privacy Policy'),
//                       ],
//                     ),

//                     // Icon at the end
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 15,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => ContactUs()));
//               },
//               child: Container(
//                 width: 330,
//                 height: 50,
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                     border: Border.all(color: Colors.black),
//                     borderRadius: BorderRadius.circular(6)),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Texts side-by-side
//                     Row(
//                       children: [
//                         Icon(Icons.phone),
//                         SizedBox(width: 8), // space between icon and text
//                         Text('Terms & Conditions'),
//                       ],
//                     ),

//                     // Icon at the end
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 15,
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             // Container(
//             //   width: 330,
//             //   height: 50,
//             //   padding: const EdgeInsets.all(8.0),
//             //   decoration: BoxDecoration(
//             //       border: Border.all(color: Colors.black),
//             //       borderRadius: BorderRadius.circular(6)),
//             //   child: const Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: [
//             //       // Texts side-by-side
//             //       Row(
//             //         children: [
//             //           Icon(
//             //             Icons.exit_to_app,
//             //             color: Colors.red,
//             //           ),
//             //           SizedBox(width: 8), // space between icon and text
//             //           Text(
//             //             'Logout',
//             //             style: TextStyle(color: Colors.red),
//             //           ),
//             //         ],
//             //       ),

//             //       // Icon at the end
//             //       Icon(
//             //         Icons.arrow_forward_ios,
//             //         size: 15,
//             //         color: Colors.red,
//             //       ),
//             //     ],
//             //   ),
//             // ),

//             GestureDetector(
//               // onTap: () async {
//               //   final authProvider =
//               //       Provider.of<AuthProvider>(context, listen: false);

//               //   // Call logout function
//               //   await authProvider.logout();

//               //   // Navigate to Login screen & clear stack
//               //   Navigator.pushAndRemoveUntil(
//               //     context,
//               //     MaterialPageRoute(builder: (_) => const LoginScreen()),
//               //     (route) => false,
//               //   );
//               // },

//               onTap: () async {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text('Confirm Logout'),
//                     content: const Text('Are you sure you want to logout?'),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context); // Close dialog
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () async {
//                           Navigator.pop(context); // Close dialog first

//                           final authProvider =
//                               Provider.of<AuthProvider>(context, listen: false);

//                           await authProvider.logout();

//                           Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => const LoginScreen()),
//                             (route) => false,
//                           );
//                         },
//                         child: const Text(
//                           'Logout',
//                           style: TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },

//               child: Container(
//                 width: 330,
//                 height: 50,
//                 padding: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.red),
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.exit_to_app,
//                           color: Colors.red,
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           'Logout',
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                     Icon(
//                       Icons.arrow_forward_ios,
//                       size: 15,
//                       color: Colors.red,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:product_app/Provider/auth/login_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/profile/edit_profile.dart';
import 'package:product_app/views/auth/login_screen.dart';
import 'package:product_app/views/deleteaccount/delete_account.dart';
import 'package:product_app/views/help/contact_us.dart';
import 'package:product_app/views/help/help_screen.dart';
import 'package:product_app/views/location/location_screen.dart';
import 'package:product_app/views/location_screen.dart';
import 'package:product_app/views/posting/posting_details.dart';
import 'package:product_app/views/subscription/subscription_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $url')),
        );
      }
    }
  }

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
                border: Border.all(color: const Color(0xFF00A8E8)),
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
                          style: TextStyle(color: Color(0xFF2BBBAD)),
                        ),
                      ),
                    ],
                  ),
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
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 8),
                      GestureDetector(
                          onTap: () {
                            final userId = SharedPrefHelper.getUserId();

                            if (userId == null || userId.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('User ID not found')),
                              );
                              return;
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LocationFetchScreen(userId: userId)));
                          },
                          child: const Text('Change Address')),
                    ],
                  ),
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
            GestureDetector(
              onTap: () {
                _launchURL(
                    'https://estatehouz.onrender.com/privacy-policy', context);
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
                        Icon(Icons.help_outline),
                        SizedBox(width: 8),
                        Text('Privacy Policy'),
                      ],
                    ),
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
                _launchURL(
                    'https://estatehouz.onrender.com/terms-and-conditions',
                    context);
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
                        Icon(Icons.phone),
                        SizedBox(width: 8),
                        Text('Terms & Conditions'),
                      ],
                    ),
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
                _launchURL('https://estatehouz.onrender.com/contact', context);
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
                        Icon(Icons.contact_support),
                        SizedBox(width: 8),
                        Text('Contact Us'),
                      ],
                    ),
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
                        builder: (context) => const DeleteAccount()));
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
                        (Icon(Icons.delete)),
                        SizedBox(width: 8),
                        Text('Delete Account'),
                      ],
                    ),
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
                _launchURL(
                    'https://product-web-rho-tan.vercel.app/home', context);
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
                        Icon(Icons.help_outline),
                        SizedBox(width: 8),
                        Text('About Us'),
                      ],
                    ),
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
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Confirm Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);

                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);

                          await authProvider.logout();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                width: 330,
                height: 50,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.red,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
