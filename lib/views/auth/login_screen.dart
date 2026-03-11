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

//   @override
//   void dispose() {
//     _mobileController.dispose();
//     super.dispose();
//   }

//   void _onGetOtp() async {
//     final mobile = _mobileController.text.trim();

//     if (mobile.isEmpty || mobile.length < 10) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Enter valid mobile number"),
//         ),
//       );
//       return;
//     }

//     final authProvider = context.read<AuthProvider>();
    
//     // Send OTP
//     final success = await authProvider.sendOtp(mobile);

//     if (success && mounted) {
//       // Navigate to OTP screen
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => OtpScreen(
//             mobileNumber: mobile,
//             otpToken: authProvider.token.toString(),
//           ),
//         ),
//       );
//     } else if (mounted && authProvider.errorMessage != null) {
//       // Show error message
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(authProvider.errorMessage!),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<AuthProvider>(
//         builder: (context, authProvider, child) {
//           return Stack(
//             children: [
//               // Full-screen background image
//               Positioned.fill(
//                 child: Image.asset(
//                   'assets/images/login.png',
//                   fit: BoxFit.cover,
//                 ),
//               ),

//               // Dark overlay for readability
//               Positioned.fill(
//                 child: Container(
//                   color: Colors.black.withOpacity(0.35),
//                 ),
//               ),

//               // Welcome text in upper area
//               Positioned(
//                 left: 24,
//                 right: 24,
//                 bottom: 300,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Welcome Back!",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 28,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       "Please Sign In to Continue.",
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.85),
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // White bottom card
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(28),
//                       topRight: Radius.circular(28),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Mobile Number Field
//                       Text(
//                         "Mobile Number",
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 12,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       TextField(
//                         controller: _mobileController,
//                         keyboardType: TextInputType.phone,
//                         maxLength: 10,
//                         decoration: InputDecoration(
//                           hintText: "Enter your Mobile Number",
//                           hintStyle: TextStyle(
//                             color: Colors.grey.shade400,
//                             fontSize: 13,
//                           ),
//                           counterText: "", // Hide the counter
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 14,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide: const BorderSide(color: Color(0xFFE33629)),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // Get OTP Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: authProvider.isLoading ? null : _onGetOtp,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFFE33629),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                           ),
//                           child: authProvider.isLoading
//                               ? const SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               : const Text(
//                                   "Get OTP",
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // OR Divider
//                       Row(
//                         children: [
//                           Expanded(child: Divider(color: Colors.grey.shade300)),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Text(
//                               "Or",
//                               style: TextStyle(
//                                 color: Colors.grey.shade500,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ),
//                           Expanded(child: Divider(color: Colors.grey.shade300)),
//                         ],
//                       ),

//                       const SizedBox(height: 20),

//                       // Social Login Icons
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           _SocialButton(assetPath: 'assets/images/go.png'),
//                           const SizedBox(width: 20),
//                           _SocialButton(assetPath: 'assets/images/x.png'),
//                           const SizedBox(width: 20),
//                           _SocialButton(assetPath: 'assets/images/fb.png'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Loading overlay
//               if (authProvider.isLoading)
//                 const Positioned.fill(
//                   child: Center(
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
// }

// // ── Social Button (exact same as first UI) ────────────────────────────────────

// class _SocialButton extends StatelessWidget {
//   final String assetPath;

//   const _SocialButton({required this.assetPath});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // TODO: Add social login functionality
//       },
//       child: Container(
//         width: 52,
//         height: 52,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.grey.shade300),
//           color: Colors.white,
//         ),
//         padding: const EdgeInsets.all(12),
//         child: Image.asset(
//           assetPath,
//           fit: BoxFit.contain,
//           errorBuilder: (_, __, ___) {
//             return const Icon(Icons.error, size: 20);
//           },
//         ),
//       ),
//     );
//   }
// }

























// lib/views/login_screen.dart
import 'package:flutter/material.dart';
import 'package:product_app/Provider/auth/login_provider.dart';
import 'package:product_app/views/auth/otp_screen.dart';
import 'package:product_app/views/home/navbar_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _phoneNumber = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  // Handle Get OTP
  Future<void> _handleGetOtp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (_phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter mobile number"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authProvider = context.read<AuthProvider>();
    
    // Send OTP
    final success = await authProvider.sendOtp(_phoneNumber);

    setState(() => _isLoading = false);

    if (success && mounted) {
      // Navigate to OTP screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            mobileNumber: _phoneNumber,
          ),
        ),
      );
    } else if (mounted) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? "Failed to send OTP"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Handle Google Sign In
  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.signInWithGoogle();

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>NavbarScreen()));
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? "Google Sign-In failed"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/login.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[900],
                  ),
                ),
              ),

              // Dark Overlay
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                ),
              ),

              // Welcome Text
              Positioned(
                left: 24,
                right: 24,
                bottom: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Please Sign In to Continue.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Card
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Mobile Number Label
                        const Text(
                          "Mobile Number",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Phone Input with Country Code
                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            _phoneNumber = number.phoneNumber ?? '';
                          },
                          onInputValidated: (bool isValid) {},
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: const TextStyle(color: Colors.black),
                          initialValue: PhoneNumber(isoCode: 'IN'),
                          textFieldController: _phoneController,
                          formatInput: false,
                          keyboardType: TextInputType.phone,
                          inputBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter mobile number';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        // Get OTP Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleGetOtp,
                            child: _isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Get OTP",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // OR Divider
                        Row(
                          children: [
                            Expanded(child: Divider(color: Colors.grey.shade300)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "Or",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: Colors.grey.shade300)),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Google Sign In Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: OutlinedButton.icon(
                            onPressed: _isLoading ? null : _handleGoogleSignIn,
                            icon: Image.asset(
                              'assets/images/go.png',
                              width: 20,
                              height: 20,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.g_mobiledata,
                                color: Colors.red,
                              ),
                            ),
                            label: const Text(
                              "Continue with Google",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey.shade300),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
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
          );
        },
      ),
    );
  }
}