// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/auth/otp_provider.dart';
// import 'package:product_app/views/home/navbar_screen.dart';
// import 'package:provider/provider.dart';

// class OtpScreen extends StatefulWidget {
//   final String? mobileNumber;
//   final String otpToken; // Token received from send-otp API
  
//   const OtpScreen({
//     super.key,
//     this.mobileNumber,
//     required this.otpToken,
//   });

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final List<TextEditingController> _controllers =
//       List.generate(4, (index) => TextEditingController());

//   final List<FocusNode> _focusNodes =
//       List.generate(4, (index) => FocusNode());

//   @override
//   void dispose() {
//     for (var c in _controllers) {
//       c.dispose();
//     }
//     for (var f in _focusNodes) {
//       f.dispose();
//     }
//     super.dispose();
//   }

//   void _onOtpChanged(String value, int index) {
//     if (value.isNotEmpty && index < 3) {
//       _focusNodes[index + 1].requestFocus();
//     }
//   }

//   void _onBackspace(String value, int index) {
//     if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
//   }

//   Future<void> _verifyOtp() async {
//     String enteredOtp = _controllers.map((c) => c.text).join("");

//     // Validate OTP length
//     if (enteredOtp.length != 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Enter complete OTP"),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     final authProvider = context.read<OtpProvider>();
    
//     // Call verify OTP
//     final success = await authProvider.verifyOtp(
//       otp: enteredOtp,
//       token: widget.otpToken,
//     );

//     if (!mounted) return;

//     if (success) {
//       // Navigate to navbar screen
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const NavbarScreen()),
//       );
//     } else {
//       // Show error from provider
//       final errorMsg = authProvider.errorMessage ?? "Invalid OTP";
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(errorMsg),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _resendOtp() async {
//     if (widget.mobileNumber == null || widget.mobileNumber!.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Mobile number not found"),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     final authProvider = context.read<OtpProvider>();
    
//     final success = await authProvider.resendOtp(
//       mobile: widget.mobileNumber!,
//     );

//     if (!mounted) return;

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("OTP resent successfully"),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else {
//       final errorMsg = authProvider.errorMessage ?? "Failed to resend OTP";
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(errorMsg),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Consumer<OtpProvider>(
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

//               // Back button
//               Positioned(
//                 top: 48,
//                 left: 16,
//                 child: GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     width: 38,
//                     height: 38,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.arrow_back, color: Colors.white),
//                   ),
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
//                     children: [
//                       // OTP Boxes Row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                           4,
//                           (index) => _OtpBox(
//                             controller: _controllers[index],
//                             focusNode: _focusNodes[index],
//                             onChanged: (value) => _onOtpChanged(value, index),
//                             onBackspace: (value) => _onBackspace(value, index),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 14),

//                       // Resend OTP
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: authProvider.isResending
//                             ? const SizedBox(
//                                 height: 20,
//                                 width: 20,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                   valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE33629)),
//                                 ),
//                               )
//                             : GestureDetector(
//                                 onTap: authProvider.canResend ? _resendOtp : null,
//                                 child: RichText(
//                                   text: TextSpan(
//                                     children: [
//                                       if (authProvider.resendCountdown > 0) ...[
//                                         TextSpan(
//                                           text: "Resend OTP in ",
//                                           style: TextStyle(
//                                             color: Colors.grey.shade500,
//                                             fontSize: 13,
//                                           ),
//                                         ),
//                                         TextSpan(
//                                           text: "00:${authProvider.resendCountdown.toString().padLeft(2, '0')}",
//                                           style: const TextStyle(
//                                             color: Color(0xFFE33629),
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                       ] else
//                                         const TextSpan(
//                                           text: "Resend OTP",
//                                           style: TextStyle(
//                                             color: Color(0xFFE33629),
//                                             fontSize: 13,
//                                             fontWeight: FontWeight.w600,
//                                             decoration: TextDecoration.underline,
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                       ),

//                       const SizedBox(height: 20),

//                       // Verify Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: authProvider.isLoading ? null : _verifyOtp,
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
//                                   "Verify",
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
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

// // ── OTP Box (exact same as first UI) ─────────────────────────────────────────

// class _OtpBox extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final Function(String) onChanged;
//   final Function(String) onBackspace;

//   const _OtpBox({
//     required this.controller,
//     required this.focusNode,
//     required this.onChanged,
//     required this.onBackspace,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 55,
//       height: 55,
//       margin: const EdgeInsets.symmetric(horizontal: 6),
//       child: TextField(
//         controller: controller,
//         focusNode: focusNode,
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//         ),
//         decoration: InputDecoration(
//           counterText: "",
//           contentPadding: EdgeInsets.zero,
//           border: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
//           ),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
//           ),
//           focusedBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(color: Color(0xFFE33629), width: 2),
//           ),
//         ),
//         onChanged: (value) {
//           onChanged(value);
//           if (value.isEmpty) {
//             onBackspace(value);
//           }
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


























// // lib/views/otp_screen.dart - Using Custom OTP Boxes
// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/auth/login_provider.dart';
// import 'package:product_app/views/home/navbar_screen.dart';
// import 'package:provider/provider.dart';

// class OtpScreen extends StatefulWidget {
//   final String mobileNumber;

//   const OtpScreen({
//     super.key,
//     required this.mobileNumber,
//   });

//   @override
//   State<OtpScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<OtpScreen> {
//   final List<TextEditingController> _controllers =
//       List.generate(4, (index) => TextEditingController());

//   final List<FocusNode> _focusNodes =
//       List.generate(4, (index) => FocusNode());

//   int _start = 60;
//   bool _resend = false;

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   @override
//   void dispose() {
//     for (var c in _controllers) {
//       c.dispose();
//     }
//     for (var f in _focusNodes) {
//       f.dispose();
//     }
//     super.dispose();
//   }

//   void startTimer() {
//     _resend = false;
//     _start = 60;
//     Future.doWhile(() async {
//       await Future.delayed(const Duration(seconds: 1));
//       if (_start > 0 && mounted) {
//         setState(() {
//           _start--;
//         });
//         return true;
//       }
//       if (mounted) {
//         setState(() {
//           _resend = true;
//         });
//       }
//       return false;
//     });
//   }

//   void _onOtpChanged(String value, int index) {
//     if (value.isNotEmpty && index < 3) {
//       _focusNodes[index + 1].requestFocus();
//     }
//   }

//   void _onBackspace(String value, int index) {
//     if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
//   }

//   Future<void> _verifyOtp() async {
//     String enteredOtp = _controllers.map((c) => c.text).join("");

//     if (enteredOtp.length != 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Enter complete OTP"),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     final authProvider = context.read<AuthProvider>();
    
//     final success = await authProvider.verifyOtp(enteredOtp);

//     if (!mounted) return;

//     if (success) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const NavbarScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(authProvider.errorMessage ?? "Invalid OTP"),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _resendOtp() async {
//     if (!_resend) return;

//     final authProvider = context.read<AuthProvider>();
    
//     final success = await authProvider.resendOtp(widget.mobileNumber);

//     if (!mounted) return;

//     if (success) {
//       startTimer();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("OTP resent successfully"),
//           backgroundColor: Colors.green,
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(authProvider.errorMessage ?? "Failed to resend OTP"),
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
//               // Background Image
//               Positioned.fill(
//                 child: Image.asset(
//                   'assets/images/login.png',
//                   fit: BoxFit.cover,
//                   errorBuilder: (_, __, ___) => Container(
//                     color: Colors.grey[900],
//                   ),
//                 ),
//               ),

//               // Dark Overlay
//               Positioned.fill(
//                 child: Container(
//                   color: Colors.black.withOpacity(0.35),
//                 ),
//               ),

//               // Back Button
//               Positioned(
//                 top: 48,
//                 left: 16,
//                 child: GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     width: 38,
//                     height: 38,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.arrow_back, color: Colors.white),
//                   ),
//                 ),
//               ),

//               // White Bottom Card
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(24, 28, 24, 36),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(28),
//                       topRight: Radius.circular(28),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         "Enter Verification Code",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         "Code sent to ${widget.mobileNumber}",
//                         style: TextStyle(
//                           color: Colors.grey.shade600,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(height: 30),

//                       // OTP Boxes Row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(
//                           4,
//                           (index) => _OtpBox(
//                             controller: _controllers[index],
//                             focusNode: _focusNodes[index],
//                             onChanged: (value) => _onOtpChanged(value, index),
//                             onBackspace: (value) => _onBackspace(value, index),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // Verify Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: authProvider.isLoading ? null : _verifyOtp,
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
//                                   "Verify",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       // Resend OTP
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Didn't receive code? ",
//                             style: TextStyle(color: Colors.grey.shade600),
//                           ),
//                           GestureDetector(
//                             onTap: _resend ? _resendOtp : null,
//                             child: Text(
//                               _resend ? "Resend" : "Resend in 00:$_start",
//                               style: TextStyle(
//                                 color: _resend
//                                     ? const Color(0xFFE33629)
//                                     : Colors.grey,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Loading Overlay
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

// // Custom OTP Box Widget
// class _OtpBox extends StatelessWidget {
//   final TextEditingController controller;
//   final FocusNode focusNode;
//   final Function(String) onChanged;
//   final Function(String) onBackspace;

//   const _OtpBox({
//     required this.controller,
//     required this.focusNode,
//     required this.onChanged,
//     required this.onBackspace,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 55,
//       height: 55,
//       margin: const EdgeInsets.symmetric(horizontal: 6),
//       child: TextField(
//         controller: controller,
//         focusNode: focusNode,
//         textAlign: TextAlign.center,
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         style: const TextStyle(
//           fontSize: 20,
//           fontWeight: FontWeight.bold,
//           color: Colors.black87,
//         ),
//         decoration: InputDecoration(
//           counterText: "",
//           contentPadding: EdgeInsets.zero,
//           border: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
//           ),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
//           ),
//           focusedBorder: const UnderlineInputBorder(
//             borderSide: BorderSide(color: Color(0xFFE33629), width: 2),
//           ),
//         ),
//         onChanged: (value) {
//           onChanged(value);
//           if (value.isEmpty) {
//             onBackspace(value);
//           }
//         },
//       ),
//     );
//   }
// }




















import 'package:flutter/material.dart';
import 'package:product_app/Provider/auth/login_provider.dart';
import 'package:product_app/views/home/navbar_screen.dart';
import 'package:provider/provider.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({
    super.key,
    required this.mobileNumber,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  final List<FocusNode> _focusNodes =
      List.generate(6, (index) => FocusNode());

  int _start = 60;
  bool _resend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    _resend = false;
    _start = 60;

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (_start > 0 && mounted) {
        setState(() {
          _start--;
        });
        return true;
      }

      if (mounted) {
        setState(() {
          _resend = true;
        });
      }

      return false;
    });
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  void _onBackspace(String value, int index) {
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verifyOtp() async {
    String enteredOtp = _controllers.map((c) => c.text).join("");

    if (enteredOtp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter complete OTP"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.verifyOtp(enteredOtp);

    if (!mounted) return;

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavbarScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? "Invalid OTP"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _resendOtp() async {
    if (!_resend) return;

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.resendOtp(widget.mobileNumber);

    if (!mounted) return;

    if (success) {
      startTimer();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP resent successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? "Failed to resend OTP"),
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

              // Background
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

              // Back Button
              Positioned(
                top: 48,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text(
                        "Enter Verification Code",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Code sent to ${widget.mobileNumber}",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// OTP Boxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          6,
                          (index) => _OtpBox(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            onChanged: (value) => _onOtpChanged(value, index),
                            onBackspace: (value) => _onBackspace(value, index),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed:
                              authProvider.isLoading ? null : _verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE33629),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: authProvider.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Verify",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Resend OTP
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive code? ",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          GestureDetector(
                            onTap: _resend ? _resendOtp : null,
                            child: Text(
                              _resend ? "Resend" : "Resend in 00:$_start",
                              style: TextStyle(
                                color: _resend
                                    ? const Color(0xFFE33629)
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Loading overlay
              if (authProvider.isLoading)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
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

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final Function(String) onBackspace;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE33629), width: 2),
          ),
        ),
        onChanged: (value) {
          onChanged(value);

          if (value.isEmpty) {
            onBackspace(value);
          }
        },
      ),
    );
  }
}