

// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/auth/login_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:product_app/views/auth/otp_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _mobileController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _mobileController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleGetOtp() async {
//     // Clear previous errors
//     context.read<AuthProvider>().clearError();

//     // Validate form
//     if (_formKey.currentState?.validate() ?? false) {
//       final authProvider = context.read<AuthProvider>();
//       final mobile = _mobileController.text.trim();

//       // Send OTP
//       final success = await authProvider.sendOtp(mobile);

//       if (success && mounted) {
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('OTP sent to $mobile'),
//             backgroundColor: Colors.green,
//             duration: const Duration(seconds: 2),
//           ),
//         );

//         // Navigate to OTP screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpScreen(mobileNumber: mobile,otpToken:authProvider.token.toString() ,),
//           ),
//         );
//       } else if (mounted && authProvider.errorMessage != null) {
//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(authProvider.errorMessage!),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Consumer<AuthProvider>(
//         builder: (context, authProvider, child) {
//           return Stack(
//             children: [
//               SizedBox(
//                 height: size.height,
//                 width: size.width,
//                 child: Image.asset(
//                   'lib/assets/326d2930d9db1602b33b58791da49bcca71891d3.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Container(
//                 height: size.height,
//                 width: size.width,
//                 color: Colors.black.withOpacity(0.3),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   const Text(
//                     "Welcome Back!",
//                     style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "Please Sign In to Continue",
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.vertical(
//                         top: Radius.circular(30),
//                       ),
//                     ),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 10),
//                           TextFormField(
//                             controller: _mobileController,
//                             decoration: InputDecoration(
//                               hintText: "Enter your Mobile Number",
//                               labelText: 'Mobile Number',
//                               prefixText: '+91 ',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               errorBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                                 borderSide: const BorderSide(
//                                   color: Colors.red,
//                                   width: 1.5,
//                                 ),
//                               ),
//                             ),
//                             keyboardType: TextInputType.phone,
//                             maxLength: 10,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter mobile number';
//                               }
//                               if (value.length != 10) {
//                                 return 'Mobile number must be 10 digits';
//                               }
//                               if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
//                                 return 'Please enter a valid mobile number';
//                               }
//                               return null;
//                             },
//                           ),
//                           const SizedBox(height: 20),
//                           SizedBox(
//                             width: double.infinity,
//                             height: 50,
//                             child: DecoratedBox(
//                               decoration: BoxDecoration(
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color(0xFF00A8E8), // #00A8E8
//                                     Color(0xFF2BBBAD), // #2BBBAD
//                                   ],
//                                 ),
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: ElevatedButton(
//                                 onPressed: authProvider.isLoading
//                                     ? null
//                                     : _handleGetOtp,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   shadowColor: Colors.transparent,
//                                   disabledBackgroundColor: Colors.transparent,
//                                 ),
//                                 child: authProvider.isLoading
//                                     ? const SizedBox(
//                                         height: 20,
//                                         width: 20,
//                                         child: CircularProgressIndicator(
//                                           strokeWidth: 2,
//                                           valueColor:
//                                               AlwaysStoppedAnimation<Color>(
//                                             Colors.white,
//                                           ),
//                                         ),
//                                       )
//                                     : const Text(
//                                         "Get OTP",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//                           const Row(
//                             children: [
//                               Expanded(child: Divider()),
//                               Padding(
//                                 padding: EdgeInsets.symmetric(horizontal: 10),
//                                 child: Text("Or"),
//                               ),
//                               Expanded(child: Divider()),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               _socialIcon('lib/assets/google-logo.webp'),
//                               _socialIcon('lib/assets/twitterimage.png'),
//                               _socialIcon(
//                                 'lib/assets/fb_1695273515215_1695273522698.avif',
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               // Loading overlay (optional, for full screen loading)
//               if (authProvider.isLoading)
//                 Container(
//                   color: Colors.black.withOpacity(0.3),
//                   child: const Center(
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _socialIcon(String assetPath) {
//     return CircleAvatar(
//       backgroundColor: Colors.white,
//       radius: 25,
//       child: Image.asset(assetPath, height: 30),
//     );
//   }
// }

















// ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/auth/login_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:product_app/views/auth/otp_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _mobileController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     _mobileController.dispose();
//     super.dispose();
//   }

//   Future<void> _handleGetOtp() async {
//     // Clear previous errors
//     context.read<AuthProvider>().clearError();

//     // Validate form
//     if (_formKey.currentState?.validate() ?? false) {
//       final authProvider = context.read<AuthProvider>();
//       final mobile = _mobileController.text.trim();

//       // Send OTP
//       final success = await authProvider.sendOtp(mobile);

//       if (success && mounted) {
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('OTP sent to $mobile'),
//             backgroundColor: Colors.green,
//             duration: const Duration(seconds: 2),
//           ),
//         );

//         // Navigate to OTP screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OtpScreen(
//               mobileNumber: mobile,
//               otpToken: authProvider.token.toString(),
//             ),
//           ),
//         );
//       } else if (mounted && authProvider.errorMessage != null) {
//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(authProvider.errorMessage!),
//             backgroundColor: Colors.red,
//             duration: const Duration(seconds: 3),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final isWeb = size.width > 600;

//     return Scaffold(
//       body: Consumer<AuthProvider>(
//         builder: (context, authProvider, child) {
//           return Stack(
//             children: [
//               // Background Image
//               SizedBox(
//                 height: size.height,
//                 width: size.width,
//                 child: Image.asset(
//                   'lib/assets/326d2930d9db1602b33b58791da49bcca71891d3.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               // Dark Overlay
//               Container(
//                 height: size.height,
//                 width: size.width,
//                 color: Colors.black.withOpacity(0.3),
//               ),
//               // Main Content
//               Center(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Welcome Text Section
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: isWeb ? 40 : 20,
//                           vertical: isWeb ? 60 : 40,
//                         ),
//                         child: Column(
//                           children: [
//                             Text(
//                               "Welcome Back!",
//                               style: TextStyle(
//                                 fontSize: isWeb ? 40 : 30,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               "Please Sign In to Continue",
//                               style: TextStyle(
//                                 fontSize: isWeb ? 18 : 14,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Login Form Container
//                       Container(
//                         width: isWeb ? 500 : size.width,
//                         margin: EdgeInsets.symmetric(
//                           horizontal: isWeb ? 0 : 0,
//                         ),
//                         padding: EdgeInsets.all(isWeb ? 40 : 20),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(isWeb ? 20 : 30),
//                           boxShadow: isWeb
//                               ? [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.1),
//                                     blurRadius: 20,
//                                     offset: const Offset(0, 10),
//                                   ),
//                                 ]
//                               : null,
//                         ),
//                         child: Form(
//                           key: _formKey,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               const SizedBox(height: 10),
//                               TextFormField(
//                                 controller: _mobileController,
//                                 decoration: InputDecoration(
//                                   hintText: "Enter your Mobile Number",
//                                   labelText: 'Mobile Number',
//                                   prefixText: '+91 ',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                     borderSide: const BorderSide(
//                                       color: Colors.red,
//                                       width: 1.5,
//                                     ),
//                                   ),
//                                 ),
//                                 keyboardType: TextInputType.phone,
//                                 maxLength: 10,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please enter mobile number';
//                                   }
//                                   if (value.length != 10) {
//                                     return 'Mobile number must be 10 digits';
//                                   }
//                                   if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
//                                     return 'Please enter a valid mobile number';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                               const SizedBox(height: 20),
//                               SizedBox(
//                                 width: double.infinity,
//                                 height: 50,
//                                 child: DecoratedBox(
//                                   decoration: BoxDecoration(
//                                     gradient: const LinearGradient(
//                                       colors: [
//                                         Color(0xFF00A8E8),
//                                         Color(0xFF2BBBAD),
//                                       ],
//                                     ),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: ElevatedButton(
//                                     onPressed: authProvider.isLoading
//                                         ? null
//                                         : _handleGetOtp,
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: Colors.transparent,
//                                       shadowColor: Colors.transparent,
//                                       disabledBackgroundColor:
//                                           Colors.transparent,
//                                     ),
//                                     child: authProvider.isLoading
//                                         ? const SizedBox(
//                                             height: 20,
//                                             width: 20,
//                                             child: CircularProgressIndicator(
//                                               strokeWidth: 2,
//                                               valueColor:
//                                                   AlwaysStoppedAnimation<Color>(
//                                                 Colors.white,
//                                               ),
//                                             ),
//                                           )
//                                         : const Text(
//                                             "Get OTP",
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               const Row(
//                                 children: [
//                                   Expanded(child: Divider()),
//                                   Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 10),
//                                     child: Text("Or"),
//                                   ),
//                                   Expanded(child: Divider()),
//                                 ],
//                               ),
//                               const SizedBox(height: 20),
//                               // Row(
//                               //   mainAxisAlignment:
//                               //       MainAxisAlignment.spaceEvenly,
//                               //   children: [
//                               //     _socialIcon('lib/assets/google-logo.webp'),
//                               //     _socialIcon('lib/assets/twitterimage.png'),
//                               //     _socialIcon(
//                               //       'lib/assets/fb_1695273515215_1695273522698.avif',
//                               //     ),
//                               //   ],
//                               // ),
//                               SizedBox(height: isWeb ? 10 : 0),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: isWeb ? 40 : 20),
//                     ],
//                   ),
//                 ),
//               ),
//               // Loading overlay
//               if (authProvider.isLoading)
//                 Container(
//                   color: Colors.black.withOpacity(0.3),
//                   child: const Center(
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   ),
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _socialIcon(String assetPath) {
//     return CircleAvatar(
//       backgroundColor: Colors.white,
//       radius: 25,
//       child: Image.asset(assetPath, height: 30),
//     );
//   }
// }
























import 'package:flutter/material.dart';
import 'package:product_app/Provider/auth/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:product_app/views/auth/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _handleGetOtp() async {
    // Clear previous errors
    context.read<AuthProvider>().clearError();

    // Validate form
    if (_formKey.currentState?.validate() ?? false) {
      final authProvider = context.read<AuthProvider>();
      final mobile = _mobileController.text.trim();

      // Send OTP
      final success = await authProvider.sendOtp(mobile);

      if (success && mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP sent to $mobile'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Navigate to OTP screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              mobileNumber: mobile,
              otpToken: authProvider.token.toString(),
            ),
          ),
        );
      } else if (mounted && authProvider.errorMessage != null) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage!),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 600;

    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Stack(
            children: [
              // Background Image
              SizedBox(
                height: size.height,
                width: size.width,
                child: Image.asset(
                  'lib/assets/326d2930d9db1602b33b58791da49bcca71891d3.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Dark Overlay
              Container(
                height: size.height,
                width: size.width,
                color: Colors.black.withOpacity(0.3),
              ),
              // Main Content
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Section
                      Padding(
                        padding: EdgeInsets.only(
                          top: isWeb ? 40 : 20,
                          bottom: isWeb ? 20 : 10,
                        ),
                        child: Image.asset(
                          'lib/assets/splashscreenlogo.png',
                          height: isWeb ? 120 : 100,
                          width: isWeb ? 120 : 100,
                        ),
                      ),
                      // Welcome Text Section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isWeb ? 40 : 20,
                          vertical: isWeb ? 30 : 20,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Welcome Back!",
                              style: TextStyle(
                                fontSize: isWeb ? 40 : 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Please Sign In to Continue",
                              style: TextStyle(
                                fontSize: isWeb ? 18 : 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Login Form Container
                      Container(
                        width: isWeb ? 500 : size.width,
                        margin: EdgeInsets.symmetric(
                          horizontal: isWeb ? 0 : 0,
                        ),
                        padding: EdgeInsets.all(isWeb ? 40 : 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(isWeb ? 20 : 30),
                          boxShadow: isWeb
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ]
                              : null,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _mobileController,
                                decoration: InputDecoration(
                                  hintText: "Enter your Mobile Number",
                                  labelText: 'Mobile Number',
                                  prefixText: '+91 ',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter mobile number';
                                  }
                                  if (value.length != 10) {
                                    return 'Mobile number must be 10 digits';
                                  }
                                  if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                                    return 'Please enter a valid mobile number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFF00A8E8),
                                        Color(0xFF2BBBAD),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: authProvider.isLoading
                                        ? null
                                        : _handleGetOtp,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      disabledBackgroundColor:
                                          Colors.transparent,
                                    ),
                                    child: authProvider.isLoading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.white,
                                              ),
                                            ),
                                          )
                                        : const Text(
                                            "Get OTP",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 20),
                              // const Row(
                              //   children: [
                              //     Expanded(child: Divider()),
                              //     Padding(
                              //       padding:
                              //           EdgeInsets.symmetric(horizontal: 10),
                              //       child: Text("Or"),
                              //     ),
                              //     Expanded(child: Divider()),
                              //   ],
                              // ),
                              const SizedBox(height: 20),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     _socialIcon('lib/assets/google-logo.webp'),
                              //     _socialIcon('lib/assets/twitterimage.png'),
                              //     _socialIcon(
                              //       'lib/assets/fb_1695273515215_1695273522698.avif',
                              //     ),
                              //   ],
                              // ),
                              SizedBox(height: isWeb ? 10 : 0),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: isWeb ? 40 : 20),
                    ],
                  ),
                ),
              ),
              // Loading overlay
              if (authProvider.isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 25,
      child: Image.asset(assetPath, height: 30),
    );
  }
}