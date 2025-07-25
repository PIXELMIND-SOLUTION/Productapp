// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
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
//             Divider(),
//             SizedBox(height: 8,),
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
//                     children: const [
//                       Icon(
//                         Icons.person,
//                         color: Colors.blue,
//                       ),
//                       SizedBox(width: 8), // space between icon and text
//                       Text(
//                         'Personal Information',
//                         style: TextStyle(color: Colors.blue),
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
//             SizedBox(
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
//                     children: const [
//                       Icon(Icons.location_on),
//                       SizedBox(width: 8), // space between icon and text
//                       Text('Change Address'),
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
//             SizedBox(
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
//                     children: const [
//                       (Icon(Icons.swap_horiz)),
//                       SizedBox(width: 8), // space between icon and text
//                       Text('Switch Account'),
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
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
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
//             SizedBox(
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
//                     children: const [
//                       Icon(Icons.help_outline),

//                       SizedBox(width: 8), // space between icon and text
//                       Text('Need Help?'),
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
//             SizedBox(
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
//                     children: const [
//                       Icon(Icons.phone),
//                       SizedBox(width: 8), // space between icon and text
//                       Text('Contact Us'),
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
//             SizedBox(
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
//                     children: const [
//                       Icon(
//                         Icons.exit_to_app,
//                         color: Colors.red,
//                       ),
//                       SizedBox(width: 8), // space between icon and text
//                       Text(
//                         'Logout',
//                         style: TextStyle(color: Colors.red),
//                       ),
//                     ],
//                   ),

//                   // Icon at the end
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 15,
//                     color: Colors.red,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
