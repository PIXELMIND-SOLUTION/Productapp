
// lib/views/auth/otp_screen.dart
import 'package:flutter/material.dart';
import 'package:product_app/Provider/auth/login_provider.dart';
import 'package:product_app/views/splash/logo_screen.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

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

  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  // Firebase verificationId typically expires in ~2 minutes (120 seconds).
  // Matching the timer to this so the user knows when to request a new OTP.
  static const int _otpExpirySeconds = 120;

  int _start = _otpExpirySeconds;
  bool _canResend = false;
  bool _isOtpExpired = false;

  // Prevent multiple simultaneous verify/resend taps
  bool _isVerifying = false;
  bool _isResending = false;

  // Rate limiting for resend: track the last resend time
  DateTime? _lastResendTime;
  static const int _resendCooldownSeconds = 60;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _startSmsListener();
  }

  void _startSmsListener() {
    SmsAutoFill().listenForCode();
    SmsAutoFill().code.listen((otp) {
      if (!mounted) return;
      if (otp.length == 6) {
        // Fill all 6 boxes
        for (int i = 0; i < 6; i++) {
          _controllers[i].text = otp[i];
        }
        // Auto-trigger verify
        _verifyOtp();
      }
    });
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _canResend = false;
      _isOtpExpired = false;
      _start = _otpExpirySeconds;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return false;

      if (_start > 0) {
        setState(() {
          _start--;
        });
        return true;
      }

      // Timer hit zero: OTP has expired
      setState(() {
        _canResend = true;
        _isOtpExpired = true;
      });

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

  void _clearOtpBoxes() {
    for (var c in _controllers) {
      c.clear();
    }
    _focusNodes[0].requestFocus();
  }

  /// Returns a user-friendly message for Firebase OTP verification errors
  String _getFriendlyVerifyError(String? rawError) {
    if (rawError == null || rawError.isEmpty) {
      return "Verification failed. Please try again.";
    }

    final error = rawError.toLowerCase();

    if (error.contains('session-expired') ||
        error.contains('session expired') ||
        error.contains('verification-id') ||
        error.contains('verificationid') ||
        error.contains('expired')) {
      return "OTP has expired. Please go back and request a new one.";
    }

    if (error.contains('invalid-verification-code') ||
        error.contains('invalid verification code') ||
        error.contains('wrong-otp') ||
        error.contains('invalid otp')) {
      return "Incorrect OTP entered. Please check and try again.";
    }

    if (error.contains('network') ||
        error.contains('timeout') ||
        error.contains('socket') ||
        error.contains('connection') ||
        error.contains('no internet')) {
      return "Network issue. Please check your connection and try again.";
    }

    if (error.contains('too-many-requests') ||
        error.contains('too many requests') ||
        error.contains('blocked')) {
      return "Too many failed attempts. Firebase has temporarily blocked this number. Please try again after a few minutes.";
    }

    if (error.contains('user-disabled')) {
      return "This account has been disabled. Please contact support.";
    }

    if (error.contains('quota') || error.contains('limit')) {
      return "Request limit reached. Please wait a few minutes and try again.";
    }

    if (error.contains('unavailable') || error.contains('service')) {
      return "Firebase service is currently unavailable. Please try again shortly.";
    }

    return rawError;
  }

  /// Returns a user-friendly message for resend errors
  String _getFriendlyResendError(String? rawError) {
    if (rawError == null || rawError.isEmpty) {
      return "Failed to resend OTP. Please try again.";
    }

    final error = rawError.toLowerCase();

    if (error.contains('too-many-requests') ||
        error.contains('too many requests') ||
        error.contains('blocked') ||
        error.contains('quota')) {
      return "Too many OTP requests. Firebase has blocked this number temporarily. Please wait a few minutes before retrying.";
    }

    if (error.contains('network') ||
        error.contains('timeout') ||
        error.contains('connection')) {
      return "Network issue. Check your internet connection and try again.";
    }

    if (error.contains('invalid-phone-number')) {
      return "Invalid phone number. Please go back and re-enter your number.";
    }

    return rawError;
  }

  Future<void> _verifyOtp() async {
    // Prevent multiple simultaneous verify calls
    if (_isVerifying) return;

    final String enteredOtp = _controllers.map((c) => c.text.trim()).join("");

    if (enteredOtp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter the complete 6-digit OTP."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // If OTP timer has expired, don't attempt verification — it will fail
    if (_isOtpExpired) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Your OTP has expired. Please tap 'Resend' to get a new code.",
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }

    setState(() => _isVerifying = true);

    final authProvider = context.read<AuthProvider>();
    bool success = false;

    try {
      if (widget.mobileNumber == "+911234567890") {
        success =
            await authProvider.verifyOtp1(enteredOtp, widget.mobileNumber);
      } else {
        success = await authProvider.verifyOtp(enteredOtp);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isVerifying = false);
        final friendlyMessage = _getFriendlyVerifyError(e.toString());
        _showErrorSnackBar(friendlyMessage);
        // If expired error, clear boxes so user knows to resend
        if (e.toString().toLowerCase().contains('expired')) {
          _clearOtpBoxes();
        }
      }
      return;
    }

    if (!mounted) return;
    setState(() => _isVerifying = false);

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LogoScreen()),
      );
    } else {
      final String friendlyMessage =
          _getFriendlyVerifyError(authProvider.errorMessage);

      _showErrorSnackBar(friendlyMessage);

      // If the error is session/verificationId expired, update state
      final error = (authProvider.errorMessage ?? "").toLowerCase();
      if (error.contains('session-expired') ||
          error.contains('expired') ||
          error.contains('verificationid')) {
        setState(() {
          _isOtpExpired = true;
          _canResend = true;
          _start = 0;
        });
        _clearOtpBoxes();
      }
    }
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;
    // Prevent multiple simultaneous resend calls
    if (_isResending) return;

    // Rate limiting: enforce minimum interval between resend attempts
    if (_lastResendTime != null) {
      final elapsed = DateTime.now().difference(_lastResendTime!).inSeconds;
      if (elapsed < _resendCooldownSeconds) {
        final remaining = _resendCooldownSeconds - elapsed;
        _showWarningSnackBar(
          "Please wait $remaining more seconds before resending. "
          "Frequent requests may cause Firebase to block this number.",
        );
        return;
      }
    }

    setState(() => _isResending = true);

    final authProvider = context.read<AuthProvider>();
    bool success = false;

    try {
      success = await authProvider.resendOtp(widget.mobileNumber);
    } catch (e) {
      if (mounted) {
        setState(() => _isResending = false);
        _showErrorSnackBar(_getFriendlyResendError(e.toString()));
      }
      return;
    }

    if (!mounted) return;
    setState(() => _isResending = false);

    if (success) {
      _lastResendTime = DateTime.now();
      _clearOtpBoxes();
      _startTimer();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP resent successfully. Please check your SMS."),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      final friendlyMessage =
          _getFriendlyResendError(authProvider.errorMessage);
      _showErrorSnackBar(friendlyMessage);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  void _showWarningSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  String get _timerLabel {
    if (_start <= 0) return "";
    final minutes = (_start ~/ 60).toString().padLeft(2, '0');
    final seconds = (_start % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final bool isInteractionLocked = _isVerifying || _isResending;

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

              // Back Button — disabled during loading
              Positioned(
                top: 48,
                left: 16,
                child: GestureDetector(
                  onTap:
                      isInteractionLocked ? null : () => Navigator.pop(context),
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

                      // OTP expiry warning banner
                      if (_isOtpExpired) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            border: Border.all(color: Colors.orange.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.access_time,
                                  color: Colors.orange.shade700, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "OTP expired. Please tap 'Resend' to get a new code.",
                                  style: TextStyle(
                                    color: Colors.orange.shade800,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 20),

                      // OTP Boxes — disabled during loading
                      AbsorbPointer(
                        absorbing: isInteractionLocked,
                        child: Opacity(
                          opacity: isInteractionLocked ? 0.5 : 1.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              6,
                              (index) => _OtpBox(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                onChanged: (value) =>
                                    _onOtpChanged(value, index),
                                onBackspace: (value) =>
                                    _onBackspace(value, index),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: isInteractionLocked ? null : _verifyOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE33629),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isVerifying
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
                                      "Verifying...",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  "Verify",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Timer and Resend Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive code? ",
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          GestureDetector(
                            onTap: (_canResend && !_isResending)
                                ? _resendOtp
                                : null,
                            child: _isResending
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Color(0xFFE33629),
                                    ),
                                  )
                                : Text(
                                    _canResend
                                        ? "Resend"
                                        : "Resend in $_timerLabel",
                                    style: TextStyle(
                                      color: _canResend
                                          ? const Color(0xFFE33629)
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ],
                      ),

                      // Helper text to avoid Firebase blocking
                      if (_canResend && !_isOtpExpired) ...[
                        const SizedBox(height: 8),
                        Text(
                          "Tip: Avoid requesting OTP too many times to prevent being blocked by Firebase.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Full-screen loading overlay to block all taps during verify/resend
              if (isInteractionLocked)
                Positioned.fill(
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Container(color: Colors.transparent),
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
