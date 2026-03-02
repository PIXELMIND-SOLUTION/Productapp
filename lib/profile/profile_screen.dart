// // import 'package:flutter/material.dart';
// // import 'package:product_app/Provider/auth/login_provider.dart';
// // import 'package:product_app/helper/helper_function.dart';
// // import 'package:product_app/profile/edit_profile.dart';
// // import 'package:product_app/views/auth/login_screen.dart';
// // import 'package:product_app/views/help/contact_us.dart';
// // import 'package:product_app/views/help/help_screen.dart';
// // import 'package:product_app/views/location/location_screen.dart';
// // import 'package:product_app/views/location_screen.dart';
// // import 'package:product_app/views/posting/posting_details.dart';
// // import 'package:product_app/views/subscription/subscription_screen.dart';
// // import 'package:provider/provider.dart';

// // class ProfileScreen extends StatelessWidget {
// //   const ProfileScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           'Profile',
// //           style: TextStyle(fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //         automaticallyImplyLeading: false,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: Column(
// //           children: [
// //             const Divider(),
// //             const SizedBox(
// //               height: 8,
// //             ),
// //             Container(
// //               width: 330,
// //               height: 50,
// //               padding: const EdgeInsets.all(8.0),
// //               decoration: BoxDecoration(
// //                 border: Border.all(color: const Color(0xFF00A8E8)),
// //                 borderRadius: BorderRadius.circular(6),
// //               ),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   Row(
// //                     children: [
// //                       const Icon(
// //                         Icons.person,
// //                         color: Color(0xFF2BBBAD),
// //                       ),
// //                       const SizedBox(width: 8),
// //                       GestureDetector(
// //                         onTap: () {
// //                           Navigator.push(
// //                               context,
// //                               MaterialPageRoute(
// //                                   builder: (context) => const EditProfile()));
// //                         },
// //                         child: const Text(
// //                           'Personal Information',
// //                           style: TextStyle(color: Color(0xFF2BBBAD)),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   // Icon at the end
// //                   const Icon(
// //                     Icons.arrow_forward_ios,
// //                     size: 15,
// //                     color: Colors.grey,
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             const SizedBox(
// //               height: 10,
// //             ),
// //             Container(
// //               width: 330,
// //               height: 50,
// //               padding: const EdgeInsets.all(8.0),
// //               decoration: BoxDecoration(
// //                   border: Border.all(color: Colors.black),
// //                   borderRadius: BorderRadius.circular(6)),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                   // Texts side-by-side
// //                   Row(
// //                     children: [
// //                       const Icon(Icons.location_on),
// //                       const SizedBox(width: 8),
// //                       GestureDetector(
// //                           onTap: () {
// //                             final userId = SharedPrefHelper.getUserId();

// //                             if (userId == null || userId.isEmpty) {
// //                               ScaffoldMessenger.of(context).showSnackBar(
// //                                 const SnackBar(
// //                                     content: Text('User ID not found')),
// //                               );
// //                               return;
// //                             }
// //                             Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                     builder: (context) =>
// //                                         LocationFetchScreen(userId: userId)));
// //                             // Navigator.push(
// //                             //     context,
// //                             //     MaterialPageRoute(
// //                             //         builder: (context) =>
// //                             //             const LocationScreen()));
// //                           },
// //                           child: const Text('Change Address')),
// //                     ],
// //                   ),

// //                   // Icon at the end
// //                   const Icon(
// //                     Icons.arrow_forward_ios,
// //                     size: 15,
// //                     color: Colors.grey,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 10,
// //             ),
// //             GestureDetector(
// //               onTap: () {
// //                 Navigator.push(
// //                     context,
// //                     MaterialPageRoute(
// //                         builder: (context) => const PostingDetails()));
// //               },
// //               child: Container(
// //                 width: 330,
// //                 height: 50,
// //                 padding: const EdgeInsets.all(8.0),
// //                 decoration: BoxDecoration(
// //                     border: Border.all(color: Colors.black),
// //                     borderRadius: BorderRadius.circular(6)),
// //                 child: const Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         (Icon(Icons.grid_view)),
// //                         SizedBox(width: 8),
// //                         Text('My Postings'),
// //                       ],
// //                     ),
// //                     Icon(
// //                       Icons.arrow_forward_ios,
// //                       size: 15,
// //                       color: Colors.grey,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             // const SizedBox(
// //             //   height: 10,
// //             // ),

// //             // GestureDetector(
// //             //   onTap: () {
// //             //     Navigator.push(
// //             //         context,
// //             //         MaterialPageRoute(
// //             //             builder: (context) => const SubscriptionScreen()));
// //             //   },
// //             //   child: Container(
// //             //     width: 330,
// //             //     height: 50,
// //             //     padding: const EdgeInsets.all(8.0),
// //             //     decoration: BoxDecoration(
// //             //         border: Border.all(color: Colors.black),
// //             //         borderRadius: BorderRadius.circular(6)),
// //             //     child: const Row(
// //             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             //       children: [
// //             //         Row(
// //             //           children: [
// //             //             (Icon(Icons.workspace_premium)),
// //             //             SizedBox(width: 8), // space between icon and text
// //             //             Text('Upgrade to premium'),
// //             //           ],
// //             //         ),

// //             //         // Icon at the end
// //             //         Icon(
// //             //           Icons.arrow_forward_ios,
// //             //           size: 15,
// //             //           color: Colors.grey,
// //             //         ),
// //             //       ],
// //             //     ),
// //             //   ),
// //             // ),
// //             const SizedBox(
// //               height: 20,
// //             ),
// //             const Padding(
// //               padding: EdgeInsets.all(8.0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     'Account',
// //                     style: TextStyle(color: Colors.grey),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 10,
// //             ),
// //             GestureDetector(
// //               onTap: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => HelpScreen()));
// //               },
// //               child: Container(
// //                 width: 330,
// //                 height: 50,
// //                 padding: const EdgeInsets.all(8.0),
// //                 decoration: BoxDecoration(
// //                     border: Border.all(color: Colors.black),
// //                     borderRadius: BorderRadius.circular(6)),
// //                 child: const Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     // Texts side-by-side
// //                     Row(
// //                       children: [
// //                         Icon(Icons.help_outline),

// //                         SizedBox(width: 8), // space between icon and text
// //                         Text('Privacy Policy'),
// //                       ],
// //                     ),

// //                     // Icon at the end
// //                     Icon(
// //                       Icons.arrow_forward_ios,
// //                       size: 15,
// //                       color: Colors.grey,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 10,
// //             ),
// //             GestureDetector(
// //               onTap: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => ContactUs()));
// //               },
// //               child: Container(
// //                 width: 330,
// //                 height: 50,
// //                 padding: const EdgeInsets.all(8.0),
// //                 decoration: BoxDecoration(
// //                     border: Border.all(color: Colors.black),
// //                     borderRadius: BorderRadius.circular(6)),
// //                 child: const Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     // Texts side-by-side
// //                     Row(
// //                       children: [
// //                         Icon(Icons.phone),
// //                         SizedBox(width: 8), // space between icon and text
// //                         Text('Terms & Conditions'),
// //                       ],
// //                     ),

// //                     // Icon at the end
// //                     Icon(
// //                       Icons.arrow_forward_ios,
// //                       size: 15,
// //                       color: Colors.grey,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 10,
// //             ),
// //             // Container(
// //             //   width: 330,
// //             //   height: 50,
// //             //   padding: const EdgeInsets.all(8.0),
// //             //   decoration: BoxDecoration(
// //             //       border: Border.all(color: Colors.black),
// //             //       borderRadius: BorderRadius.circular(6)),
// //             //   child: const Row(
// //             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             //     children: [
// //             //       // Texts side-by-side
// //             //       Row(
// //             //         children: [
// //             //           Icon(
// //             //             Icons.exit_to_app,
// //             //             color: Colors.red,
// //             //           ),
// //             //           SizedBox(width: 8), // space between icon and text
// //             //           Text(
// //             //             'Logout',
// //             //             style: TextStyle(color: Colors.red),
// //             //           ),
// //             //         ],
// //             //       ),

// //             //       // Icon at the end
// //             //       Icon(
// //             //         Icons.arrow_forward_ios,
// //             //         size: 15,
// //             //         color: Colors.red,
// //             //       ),
// //             //     ],
// //             //   ),
// //             // ),

// //             GestureDetector(
// //               // onTap: () async {
// //               //   final authProvider =
// //               //       Provider.of<AuthProvider>(context, listen: false);

// //               //   // Call logout function
// //               //   await authProvider.logout();

// //               //   // Navigate to Login screen & clear stack
// //               //   Navigator.pushAndRemoveUntil(
// //               //     context,
// //               //     MaterialPageRoute(builder: (_) => const LoginScreen()),
// //               //     (route) => false,
// //               //   );
// //               // },

// //               onTap: () async {
// //                 showDialog(
// //                   context: context,
// //                   builder: (context) => AlertDialog(
// //                     title: const Text('Confirm Logout'),
// //                     content: const Text('Are you sure you want to logout?'),
// //                     actions: [
// //                       TextButton(
// //                         onPressed: () {
// //                           Navigator.pop(context); // Close dialog
// //                         },
// //                         child: const Text('Cancel'),
// //                       ),
// //                       TextButton(
// //                         onPressed: () async {
// //                           Navigator.pop(context); // Close dialog first

// //                           final authProvider =
// //                               Provider.of<AuthProvider>(context, listen: false);

// //                           await authProvider.logout();

// //                           Navigator.pushAndRemoveUntil(
// //                             context,
// //                             MaterialPageRoute(
// //                                 builder: (_) => const LoginScreen()),
// //                             (route) => false,
// //                           );
// //                         },
// //                         child: const Text(
// //                           'Logout',
// //                           style: TextStyle(color: Colors.red),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               },

// //               child: Container(
// //                 width: 330,
// //                 height: 50,
// //                 padding: const EdgeInsets.all(8.0),
// //                 decoration: BoxDecoration(
// //                   border: Border.all(color: Colors.red),
// //                   borderRadius: BorderRadius.circular(6),
// //                 ),
// //                 child: const Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         Icon(
// //                           Icons.exit_to_app,
// //                           color: Colors.red,
// //                         ),
// //                         SizedBox(width: 8),
// //                         Text(
// //                           'Logout',
// //                           style: TextStyle(
// //                             color: Colors.red,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     Icon(
// //                       Icons.arrow_forward_ios,
// //                       size: 15,
// //                       color: Colors.red,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/auth/login_provider.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'package:product_app/profile/edit_profile.dart';
// import 'package:product_app/views/auth/login_screen.dart';
// import 'package:product_app/views/deleteaccount/delete_account.dart';
// import 'package:product_app/views/help/contact_us.dart';
// import 'package:product_app/views/help/help_screen.dart';
// import 'package:product_app/views/location/location_screen.dart';
// import 'package:product_app/views/location_screen.dart';
// import 'package:product_app/views/posting/posting_details.dart';
// import 'package:product_app/views/subscription/subscription_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   Future<void> _launchURL(String url, BuildContext context) async {
//     final Uri uri = Uri.parse(url);
//     if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Could not launch $url')),
//         );
//       }
//     }
//   }

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
//                           },
//                           child: const Text('Change Address')),
//                     ],
//                   ),
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
//                 _launchURL(
//                     'https://estatehouz.onrender.com/privacy-policy', context);
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
//                         Icon(Icons.help_outline),
//                         SizedBox(width: 8),
//                         Text('Privacy Policy'),
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
//             const SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () {
//                 _launchURL(
//                     'https://estatehouz.onrender.com/terms-and-conditions',
//                     context);
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
//                         Icon(Icons.phone),
//                         SizedBox(width: 8),
//                         Text('Terms & Conditions'),
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
//             const SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () {
//                 _launchURL('https://estatehouz.onrender.com/contact', context);
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
//                         Icon(Icons.contact_support),
//                         SizedBox(width: 8),
//                         Text('Contact Us'),
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
//             const SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const DeleteAccount()));
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
//                         (Icon(Icons.delete)),
//                         SizedBox(width: 8),
//                         Text('Delete Account'),
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
//             const SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () {
//                 _launchURL(
//                     'https://product-web-rho-tan.vercel.app/home', context);
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
//                         Icon(Icons.help_outline),
//                         SizedBox(width: 8),
//                         Text('About Us'),
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
//             const SizedBox(
//               height: 10,
//             ),
//             GestureDetector(
//               onTap: () async {
//                 showDialog(
//                   context: context,
//                   builder: (context) => AlertDialog(
//                     title: const Text('Confirm Logout'),
//                     content: const Text('Are you sure you want to logout?'),
//                     actions: [
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: const Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () async {
//                           Navigator.pop(context);

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

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not launch $url'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF00A8E8).withOpacity(0.05),
              Colors.white,
              const Color(0xFF2BBBAD).withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // App Bar
                  SliverAppBar(
                    expandedHeight: 160,
                    floating: false,
                    pinned: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: const Text(
                        'Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 20,
                        ),
                      ),
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xFF00A8E8).withOpacity(0.1),
                              const Color(0xFF2BBBAD).withOpacity(0.1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Content
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),

                          // Personal Information Section
                          _buildAnimatedMenuItem(
                            icon: Icons.person_outline,
                            title: 'Personal Information',
                            gradientColors: [
                              const Color(0xFF00A8E8),
                              const Color(0xFF2BBBAD)
                            ],
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const EditProfile(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            delay: 0,
                          ),

                          const SizedBox(height: 12),

                          _buildAnimatedMenuItem(
                            icon: Icons.location_on_outlined,
                            title: 'Change Address',
                            onTap: () {
                              final userId = SharedPrefHelper.getUserId();
                              if (userId == null || userId.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('User ID not found'),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                );
                                return;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LocationFetchScreen(userId: userId),
                                ),
                              );
                            },
                            delay: 50,
                          ),

                          const SizedBox(height: 12),

                          _buildAnimatedMenuItem(
                            icon: Icons.grid_view_rounded,
                            title: 'My Postings',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PostingDetails(),
                                ),
                              );
                            },
                            delay: 100,
                          ),

                          const SizedBox(height: 30),

                          // Account Section Header
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 12),
                            child: Text(
                              'Account',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                          _buildAnimatedMenuItem(
                            icon: Icons.privacy_tip_outlined,
                            title: 'Privacy Policy',
                            onTap: () => _launchURL(
                                'https://estatehouz.onrender.com/privacy-policy',
                                context),
                            delay: 150,
                          ),

                          const SizedBox(height: 12),

                          _buildAnimatedMenuItem(
                            icon: Icons.description_outlined,
                            title: 'Terms & Conditions',
                            onTap: () => _launchURL(
                                'https://estatehouz.onrender.com/terms-and-conditions',
                                context),
                            delay: 200,
                          ),

                          const SizedBox(height: 12),

                          _buildAnimatedMenuItem(
                            icon: Icons.contact_support_outlined,
                            title: 'Contact Us',
                            onTap: () => _launchURL(
                                'https://estatehouz.onrender.com/contact',
                                context),
                            delay: 250,
                          ),

                          const SizedBox(height: 12),

                          _buildAnimatedMenuItem(
                            icon: Icons.delete_outline,
                            gradientColors: [
                              Colors.red,
                              Colors.red,
                            ],
                            title: 'Delete Account',
                            iconColor: Colors.orange.shade700,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DeleteAccount(),
                                ),
                              );
                            },
                            delay: 300,
                          ),

                          const SizedBox(height: 12),

                          _buildAnimatedMenuItem(
                            icon: Icons.info_outline,
                            title: 'About Us',
                            onTap: () => _launchURL(
                                'https://product-web-rho-tan.vercel.app/home',
                                context),
                            delay: 350,
                          ),

                          const SizedBox(height: 20),

                          // Logout Button
                          _buildAnimatedLogoutButton(delay: 400),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    List<Color>? gradientColors,
    Color? iconColor,
    int delay = 0,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: gradientColors != null
                          ? LinearGradient(colors: gradientColors)
                          : null,
                      color: gradientColors == null
                          ? (iconColor ?? Colors.grey.shade100)
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: gradientColors != null
                          ? Colors.white
                          : (iconColor ?? Colors.grey.shade700),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedLogoutButton({int delay = 0}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 500 + delay),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red.shade400,
              Colors.red.shade600,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.logout,
                          color: Colors.red.shade600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Confirm Logout',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  content: const Text(
                    'Are you sure you want to logout?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                    ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Logout'),
                    ),
                  ],
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
