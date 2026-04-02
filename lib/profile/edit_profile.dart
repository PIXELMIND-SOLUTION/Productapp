import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_app/Provider/profile/profile_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  bool _isInitialLoading = true;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final provider = context.read<ProfileProvider>();

    _userId = SharedPrefHelper.getUserId();

    print('userId: $_userId');

    if (_userId == null || _userId!.isEmpty) {
      if (mounted) {
        _showErrorSnackBar('User ID not found. Please login again.');
        Navigator.pop(context);
      }
      return;
    }

    final success = await provider.fetchProfile(_userId!);

    if (mounted) {
      setState(() {
        _isInitialLoading = false;
      });
      print("llllllllllllllllllllllllll${provider.email}");
      print("llllllllllllllllllllllllll${provider.name}");

      print("llllllllllllllllllllllllll${provider.mobile}");

      if (success) {
        _nameController.text = provider.name ?? '';
        _emailController.text = provider.email ?? '';
        _mobileController.text = provider.mobile ?? '';
      } else {
        _showErrorSnackBar(provider.errorMessage ?? 'Failed to load profile');
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _showImagePickerSheet() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Photo",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Camera
                  Expanded(
                    child: GestureDetector(
      onTap: () async {
  Navigator.pop(context);

  try {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    print("Camera result: $file");

    if (file != null) {
      setState(() => _selectedImage = File(file.path));
    } else {
      print("User cancelled or camera not available");
    }
  } catch (e) {
    print("Camera error: $e");
  }
},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE33629).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                              color: const Color(0xFFE33629).withOpacity(0.2)),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.camera_alt_outlined,
                                size: 30, color: const Color(0xFFE33629)),
                            const SizedBox(height: 8),
                            Text(
                              "Camera",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFE33629),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Gallery
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        final XFile? file = await _picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                        );
                        if (file != null) {
                          setState(() => _selectedImage = File(file.path));
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.photo_library_outlined,
                                size: 30, color: Colors.grey.shade600),
                            const SizedBox(height: 8),
                            Text(
                              "Gallery",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Remove photo option (if image is picked)
              if (_selectedImage != null)
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => _selectedImage = null);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade100),
                    ),
                    child: const Center(
                      child: Text(
                        "Remove Photo",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_userId == null || _userId!.isEmpty) {
      if (mounted) {
        _showErrorSnackBar('User ID not found. Please try again.');
      }
      return;
    }

    String mobileNumber = _mobileController.text.trim();

    if (mobileNumber.isNotEmpty) {
      // Remove all spaces, dashes, parentheses, and dots
      mobileNumber = mobileNumber.replaceAll(RegExp(r'[\s\-\(\)\.]'), '');

      // Check if it already has a country code (starts with +)
      if (!mobileNumber.startsWith('+')) {
        // Common country code patterns
        if (mobileNumber.startsWith('00')) {
          // International format with 00 instead of +
          mobileNumber = '+${mobileNumber.substring(2)}';
        } else if (mobileNumber.length == 10) {
          // 10 digit number - assume Indian and add +91
          mobileNumber = '+91$mobileNumber';
        } else if (mobileNumber.length == 11 && mobileNumber.startsWith('0')) {
          // 11 digit starting with 0 - remove 0 and add +91
          mobileNumber = '+91${mobileNumber.substring(1)}';
        } else if (mobileNumber.length == 12 && mobileNumber.startsWith('91')) {
          // 12 digit starting with 91 - just add +
          mobileNumber = '+$mobileNumber';
        } else if (mobileNumber.length > 10) {
          // Any other length, just add + as fallback
          mobileNumber = '+$mobileNumber';
        } else {
          // Default case - add +91
          mobileNumber = '+91$mobileNumber';
        }
      }

      // Final validation: ensure it starts with + followed by digits
      if (!RegExp(r'^\+\d+$').hasMatch(mobileNumber)) {
        _showErrorSnackBar('Invalid mobile number format');
        return;
      }
    }

    final provider = context.read<ProfileProvider>();

    final success = await provider.updateProfile(
      userId: _userId!,
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      profileImage: _selectedImage,
      mobile: mobileNumber,
    );

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile Updated")),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        // Navigator.pop(context, true);
      }
    } else {
      _showErrorSnackBar(provider.errorMessage ?? 'Failed to update profile');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade300),
            ),
            child:
                const Icon(Icons.arrow_back, size: 18, color: Colors.black87),
          ),
        ),
        title: const Text(
          "Personal Information",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: _isInitialLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                return SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // ── Avatar with edit button ──
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 44,
                                backgroundColor: Colors.orange.shade400,
                                backgroundImage: _selectedImage != null
                                    ? FileImage(_selectedImage!)
                                    : (provider.profileImageUrl != null
                                        ? NetworkImage(
                                                provider.profileImageUrl!)
                                            as ImageProvider
                                        : null),
                                child: _selectedImage == null &&
                                        provider.profileImageUrl == null
                                    ? const Icon(Icons.person,
                                        color: Colors.white, size: 40)
                                    : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: _showImagePickerSheet,
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ── Name ──
                        _OutlinedField(
                          controller: _nameController,
                          label: "Name",
                          hintText: "Manoj kumar",
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // ── Mobile (disabled) ──
                        _OutlinedField(
                          controller: _mobileController,
                          label: "Mobile Number",
                          hintText: "+6265165165",
                          // enabled: false,  // ← Remove or comment out this line
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            // Add validation if needed
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        // ── Email ──
                        _OutlinedField(
                          controller: _emailController,
                          label: "Email",
                          hintText: "Manojkumar@gmail.com",
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 36),

                        // ── Save button ──
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE33629),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0,
                            ),
                            onPressed: provider.isLoading ? null : _saveProfile,
                            child: provider.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// ── Outlined Field (exact same as first UI) ───────────────────────────────────

class _OutlinedField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final bool enabled;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _OutlinedField({
    required this.controller,
    required this.label,
    required this.hintText,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
      style: TextStyle(
        fontSize: 14,
        color: enabled ? Colors.black87 : Colors.grey.shade500,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade600,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade400,
        ),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade50,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE33629), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
