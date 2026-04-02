// lib/views/login_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product_app/Provider/auth/login_provider.dart';
import 'package:product_app/views/auth/otp_screen.dart';
import 'package:product_app/views/splash/logo_screen.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sms_autofill/sms_autofill.dart';

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

  // Rate limiting: track last OTP request timestamp
  DateTime? _lastOtpRequestTime;
  static const int _otpRequestCooldownSeconds = 60;

  @override
  void initState() {
    super.initState();
    SmsAutoFill().getAppSignature.then((signature) {
      print("APP SIGNATURE: $signature");
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  /// Returns a user-friendly message for Firebase / network errors
  String _getFriendlyErrorMessage(String? rawError) {
    if (rawError == null || rawError.isEmpty) {
      return "Something went wrong. Please try again.";
    }

    final error = rawError.toLowerCase();

    if (error.contains('network') ||
        error.contains('no internet') ||
        error.contains('socket') ||
        error.contains('timeout') ||
        error.contains('connection')) {
      return "Network issue detected. Please check your internet connection and try again.";
    }

    if (error.contains('too-many-requests') ||
        error.contains('too many requests') ||
        error.contains('quota') ||
        error.contains('blocked')) {
      return "Too many OTP requests. Firebase has temporarily blocked this number. Please wait a few minutes before trying again.";
    }

    if (error.contains('invalid-phone-number') ||
        error.contains('invalid phone')) {
      return "The phone number entered is not valid. Please check and try again.";
    }

    if (error.contains('captcha') || error.contains('recaptcha')) {
      return "Verification check failed. Please restart the app and try again.";
    }

    if (error.contains('app-not-authorized') ||
        error.contains('not authorized')) {
      return "App not authorized for phone authentication. Please contact support.";
    }

    if (error.contains('missing-phone-number')) {
      return "Phone number is missing. Please enter your number and try again.";
    }

    if (error.contains('unavailable') || error.contains('service')) {
      return "Firebase service is currently unavailable. Please try again in a moment.";
    }

    return rawError;
  }

  /// Validate phone number: must be at least 10 digits
  String? _validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your mobile number';
    }
    // Strip non-digit characters for length check
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');
    if (digitsOnly.length < 10) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
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
          content: Text("Please enter your mobile number."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Rate limiting check: prevent rapid repeated taps
    if (_lastOtpRequestTime != null) {
      final elapsed = DateTime.now().difference(_lastOtpRequestTime!).inSeconds;
      if (elapsed < _otpRequestCooldownSeconds) {
        final remaining = _otpRequestCooldownSeconds - elapsed;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Please wait $remaining seconds before requesting a new OTP. "
              "Too many requests may cause Firebase to block this number.",
            ),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 4),
          ),
        );
        return;
      }
    }

    setState(() => _isLoading = true);

    final authProvider = context.read<AuthProvider>();
    final bool success;

    try {
      if (_phoneNumber == "+911234567890") {
        success = await authProvider.sendOtp1(_phoneNumber);
      } else {
        success = await authProvider.sendOtp(_phoneNumber);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_getFriendlyErrorMessage(e.toString())),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
      return;
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      _lastOtpRequestTime = DateTime.now();
      // Navigate to OTP screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            mobileNumber: _phoneNumber,
          ),
        ),
      );
    } else {
      final friendlyMessage =
          _getFriendlyErrorMessage(authProvider.errorMessage);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(friendlyMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  // Handle Google Sign In
  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    final authProvider = context.read<AuthProvider>();
    bool success = false;

    try {
      success = await authProvider.signInWithGoogle();
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_getFriendlyErrorMessage(e.toString())),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
      return;
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LogoScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getFriendlyErrorMessage(authProvider.errorMessage) ??
              "Google Sign-In failed. Please try again."),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
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

                        // Disable phone input during loading using AbsorbPointer
                        AbsorbPointer(
                          absorbing: _isLoading,
                          child: Opacity(
                            opacity: _isLoading ? 0.5 : 1.0,
                            child: InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                _phoneNumber = number.phoneNumber ?? '';
                              },
                              onInputValidated: (bool isValid) {},
                              selectorConfig: const SelectorConfig(
                                selectorType:
                                    PhoneInputSelectorType.BOTTOM_SHEET,
                              ),
                              ignoreBlank: false,
                              autoValidateMode: AutovalidateMode.disabled,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              initialValue: PhoneNumber(isoCode: 'IN'),
                              textFieldController: _phoneController,
                              formatInput: false,
                              keyboardType: TextInputType.phone,
                              inputBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              validator: (value) {
                                return _validatePhoneNumber(value);
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Get OTP Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleGetOtp,
                            child: _isLoading
                                ? const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Sending OTP...",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
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
                        if(                        Platform.isAndroid)
                        Row(
                          children: [
                            Expanded(
                                child: Divider(color: Colors.grey.shade300)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "Or",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(
                                child: Divider(color: Colors.grey.shade300)),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Google Sign In Button
                        Platform.isAndroid
                            ? SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: OutlinedButton.icon(
                                  onPressed:
                                      _isLoading ? null : _handleGoogleSignIn,
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
                                    side:
                                        BorderSide(color: Colors.grey.shade300),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ),

              // Full-screen loading overlay — prevents ALL interaction during loading
              if (_isLoading)
                Positioned.fill(
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      color: Colors.transparent,
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
