
// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:product_app/Provider/auth/otp_provider.dart';
// import 'package:product_app/views/home/navbar_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:product_app/views/home/option_screen.dart';

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
//           content: Text("Please enter complete OTP"),
//           backgroundColor: Colors.orange,
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
//       // Navigate to option screen
//       // Navigator.pushReplacement(
//       //   context,
//       //   MaterialPageRoute(builder: (context) => const OptionScreen()),
//       // );


//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const NavbarScreen()),
//       );
      
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Login successful!"),
//           backgroundColor: Colors.green,
//         ),
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
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Consumer<OtpProvider>(
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
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//                     ),
//                     child: Column(
//                       children: [
//                         // OTP Input Fields
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: List.generate(4, (index) {
//                             return SizedBox(
//                               width: 50,
//                               child: TextField(
//                                 controller: _controllers[index],
//                                 focusNode: _focusNodes[index],
//                                 enabled: !authProvider.isLoading,
//                                 decoration: const InputDecoration(
//                                   counterText: '',
//                                   border: UnderlineInputBorder(),
//                                 ),
//                                 keyboardType: TextInputType.number,
//                                 maxLength: 1,
//                                 textAlign: TextAlign.center,
//                                 onChanged: (value) {
//                                   _onOtpChanged(value, index);
//                                   if (value.isEmpty) {
//                                     _onBackspace(value, index);
//                                   }
//                                 },
//                               ),
//                             );
//                           }),
//                         ),

//                         const SizedBox(height: 10),

//                         // Resend OTP Button
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: authProvider.isResending
//                               ? const SizedBox(
//                                   height: 20,
//                                   width: 20,
//                                   child: CircularProgressIndicator(strokeWidth: 2),
//                                 )
//                               : TextButton(
//                                   onPressed: authProvider.canResend ? _resendOtp : null,
//                                   child: Text(
//                                     authProvider.resendCountdown > 0
//                                         ? "Resend OTP in ${authProvider.resendCountdown}s"
//                                         : "Resend OTP",
//                                     style: TextStyle(
//                                       color: authProvider.canResend
//                                           ? const Color(0xFF00A8E8)
//                                           : Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                         ),

//                         const SizedBox(height: 10),

//                         // Verify Button
//                         SizedBox(
//                           width: double.infinity,
//                           height: 50,
//                           child: DecoratedBox(
//                             decoration: BoxDecoration(
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color(0xFF00A8E8),
//                                   Color(0xFF2BBBAD),
//                                 ],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: ElevatedButton(
//                               onPressed: authProvider.isLoading ? null : _verifyOtp,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.transparent,
//                                 shadowColor: Colors.transparent,
//                                 disabledBackgroundColor: Colors.transparent,
//                               ),
//                               child: authProvider.isLoading
//                                   ? const SizedBox(
//                                       height: 20,
//                                       width: 20,
//                                       child: CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                         valueColor: AlwaysStoppedAnimation<Color>(
//                                           Colors.white,
//                                         ),
//                                       ),
//                                     )
//                                   : const Text(
//                                       "Verify",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 18,
//                                       ),
//                                     ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 20),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


















// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:product_app/Provider/auth/otp_provider.dart';
import 'package:product_app/views/home/navbar_screen.dart';
import 'package:provider/provider.dart';
import 'package:product_app/views/home/option_screen.dart';

class OtpScreen extends StatefulWidget {
  final String? mobileNumber;
  final String otpToken; // Token received from send-otp API
  
  const OtpScreen({
    super.key,
    this.mobileNumber,
    required this.otpToken,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());

  final List<FocusNode> _focusNodes =
      List.generate(4, (index) => FocusNode());

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

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
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

    // Validate OTP length
    if (enteredOtp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter complete OTP"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final authProvider = context.read<OtpProvider>();
    
    // Call verify OTP
    final success = await authProvider.verifyOtp(
      otp: enteredOtp,
      token: widget.otpToken,
    );

    if (!mounted) return;

    if (success) {
      // Navigate to navbar screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavbarScreen()),
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login successful!"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Show error from provider
      final errorMsg = authProvider.errorMessage ?? "Invalid OTP";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _resendOtp() async {
    if (widget.mobileNumber == null || widget.mobileNumber!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mobile number not found"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authProvider = context.read<OtpProvider>();
    
    final success = await authProvider.resendOtp(
      mobile: widget.mobileNumber!,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP resent successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      final errorMsg = authProvider.errorMessage ?? "Failed to resend OTP";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWeb = size.width > 600;

    return Scaffold(
      body: Consumer<OtpProvider>(
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
                      // Title Section
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isWeb ? 40 : 20,
                          vertical: isWeb ? 60 : 40,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Verify OTP",
                              style: TextStyle(
                                fontSize: isWeb ? 40 : 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.mobileNumber != null
                                  ? "Enter the code sent to +91 ${widget.mobileNumber}"
                                  : "Enter the OTP sent to your mobile",
                              style: TextStyle(
                                fontSize: isWeb ? 16 : 14,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      // OTP Form Container
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            // OTP Input Fields
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(4, (index) {
                                return SizedBox(
                                  width: isWeb ? 70 : 50,
                                  child: TextField(
                                    controller: _controllers[index],
                                    focusNode: _focusNodes[index],
                                    enabled: !authProvider.isLoading,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: isWeb ? 20 : 15,
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: isWeb ? 24 : 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      _onOtpChanged(value, index);
                                      if (value.isEmpty) {
                                        _onBackspace(value, index);
                                      }
                                    },
                                  ),
                                );
                              }),
                            ),

                            const SizedBox(height: 20),

                            // Resend OTP Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: authProvider.isResending
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: authProvider.canResend
                                          ? _resendOtp
                                          : null,
                                      child: Text(
                                        authProvider.resendCountdown > 0
                                            ? "Resend OTP in ${authProvider.resendCountdown}s"
                                            : "Resend OTP",
                                        style: TextStyle(
                                          color: authProvider.canResend
                                              ? const Color(0xFF00A8E8)
                                              : Colors.grey,
                                          fontSize: isWeb ? 16 : 14,
                                        ),
                                      ),
                                    ),
                            ),

                            const SizedBox(height: 10),

                            // Verify Button
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
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ElevatedButton(
                                  onPressed: authProvider.isLoading
                                      ? null
                                      : _verifyOtp,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    disabledBackgroundColor: Colors.transparent,
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
                                      : Text(
                                          "Verify",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: isWeb ? 18 : 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              ),
                            ),

                            SizedBox(height: isWeb ? 10 : 0),
                          ],
                        ),
                      ),
                      SizedBox(height: isWeb ? 40 : 20),
                    ],
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