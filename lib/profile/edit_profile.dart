// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:product_app/Provider/profile/profile_provider.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'package:provider/provider.dart';

// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _mobileController = TextEditingController();
//   final _emailController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();

//   File? _selectedImage;
//   bool _isInitialLoading = true;
//   String? _userId;

//   @override
//   void initState() {
//     super.initState();
//     _loadProfile();
//   }

//   Future<void> _loadProfile() async {
//     final provider = context.read<ProfileProvider>();
    
//     _userId = SharedPrefHelper.getUserId();

//     print('userId: $_userId');
    
//     if (_userId == null || _userId!.isEmpty) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('User ID not found. Please login again.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//         Navigator.pop(context);
//       }
//       return;
//     }

//     final success = await provider.fetchProfile(_userId!);

//     if (mounted) {
//       setState(() {
//         _isInitialLoading = false;
//       });

//       if (success) {
//         _nameController.text = provider.name ?? '';
//         _emailController.text = provider.email ?? '';
//         _mobileController.text = provider.mobile ?? '';
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(provider.errorMessage ?? 'Failed to load profile'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     super.dispose();
//   }

//   Future<void> _pickImage() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 1080,
//         maxHeight: 1080,
//         imageQuality: 85,
//       );

//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to pick image: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   Future<void> _saveProfile() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     // Check if userId is available
//     if (_userId == null || _userId!.isEmpty) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('User ID not found. Please try again.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//       return;
//     }

//     final provider = context.read<ProfileProvider>();

//     final success = await provider.updateProfile(
//       userId: _userId!, 
//       name: _nameController.text.trim(),
//       email: _emailController.text.trim(),
//       profileImage: _selectedImage,
//     );

//     if (!mounted) return;

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Profile updated successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
//       Navigator.pop(context, true); 
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(provider.errorMessage ?? 'Failed to update profile'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Personal Information',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//       ),
//       body: _isInitialLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Consumer<ProfileProvider>(
//               builder: (context, provider, child) {
//                 return SingleChildScrollView(
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       children: [
//                         const Divider(),
//                         const SizedBox(height: 20),
//                         Center(
//                           child: Stack(
//                             children: [
//                               CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage: _selectedImage != null
//                                     ? FileImage(_selectedImage!)
//                                     : (provider.profileImageUrl != null
//                                         ? NetworkImage(provider.profileImageUrl!)
//                                         : const AssetImage(
//                                             'lib/assets/403079b6b3230e238d25d0e18c175d870e3223de.png',
//                                           )) as ImageProvider,
//                               ),
//                               Positioned(
//                                 bottom: 0,
//                                 right: 0,
//                                 child: GestureDetector(
//                                   onTap: _pickImage,
//                                   child: const CircleAvatar(
//                                     radius: 18,
//                                     backgroundColor: Colors.black,
//                                     child: Icon(
//                                       Icons.edit,
//                                       color: Colors.white,
//                                       size: 18,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         _buildInputField(
//                           label: 'Name',
//                           hint: 'Enter your name',
//                           controller: _nameController,
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please enter your name';
//                             }
//                             return null;
//                           },
//                         ),
//                         _buildInputField(
//                           label: 'Mobile Number',
//                           hint: 'Enter mobile number',
//                           controller: _mobileController,
//                           keyboardType: TextInputType.phone,
//                           enabled: false, // Mobile number is not editable
//                         ),
//                         _buildInputField(
//                           label: 'Email',
//                           hint: 'Enter your email',
//                           controller: _emailController,
//                           keyboardType: TextInputType.emailAddress,
//                           validator: (value) {
//                             if (value == null || value.trim().isEmpty) {
//                               return 'Please enter your email';
//                             }
//                             if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                                 .hasMatch(value)) {
//                               return 'Please enter a valid email';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 30),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           child: SizedBox(
//                             width: double.infinity,
//                             height: 52,
//                             child: DecoratedBox(
//                               decoration: BoxDecoration(
//                                 gradient: provider.isLoading
//                                     ? LinearGradient(
//                                         colors: [
//                                           Colors.grey.shade400,
//                                           Colors.grey.shade500,
//                                         ],
//                                       )
//                                     : const LinearGradient(
//                                         colors: [
//                                           Color(0xFF4F46E5), // Indigo
//                                           Color(0xFF6366F1), // Soft Purple
//                                         ],
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                       ),
//                                 borderRadius: BorderRadius.circular(14),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.15),
//                                     blurRadius: 10,
//                                     offset: const Offset(0, 6),
//                                   ),
//                                 ],
//                               ),
//                               child: ElevatedButton(
//                                 onPressed: provider.isLoading ? null : _saveProfile,
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.transparent,
//                                   shadowColor: Colors.transparent,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(14),
//                                   ),
//                                 ),
//                                 child: provider.isLoading
//                                     ? const SizedBox(
//                                         height: 22,
//                                         width: 22,
//                                         child: CircularProgressIndicator(
//                                           strokeWidth: 2.5,
//                                           color: Colors.white,
//                                         ),
//                                       )
//                                     : const Text(
//                                         'Save Changes',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w600,
//                                           letterSpacing: 0.5,
//                                           color: Colors.white,
//                                         ),
//                                       ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   Widget _buildInputField({
//     required String label,
//     required String hint,
//     required TextEditingController controller,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//     bool enabled = true,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         enabled: enabled,
//         validator: validator,
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           disabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide(color: Colors.grey.shade300),
//           ),
//         ),
//       ),
//     );
//   }
// }


















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

class _EditProfileState extends State<EditProfile> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? _selectedImage;
  bool _isInitialLoading = true;
  String? _userId;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
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

      if (success) {
        _nameController.text = provider.name ?? '';
        _emailController.text = provider.email ?? '';
        _mobileController.text = provider.mobile ?? '';
        _animationController.forward();
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
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Choose Photo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            _buildImageSourceOption(
              icon: Icons.photo_library_rounded,
              title: 'Choose from Gallery',
              onTap: () async {
                Navigator.pop(context);
                await _selectImage(ImageSource.gallery);
              },
            ),
            _buildImageSourceOption(
              icon: Icons.camera_alt_rounded,
              title: 'Take a Photo',
              onTap: () async {
                Navigator.pop(context);
                await _selectImage(ImageSource.camera);
              },
            ),
            if (_selectedImage != null || context.read<ProfileProvider>().profileImageUrl != null)
              _buildImageSourceOption(
                icon: Icons.delete_outline_rounded,
                title: 'Remove Photo',
                color: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedImage = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSourceOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: (color ?? const Color(0xFF4F46E5)).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: color ?? const Color(0xFF4F46E5),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

  Future<void> _selectImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to pick image: $e');
      }
    }
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

    final provider = context.read<ProfileProvider>();

    final success = await provider.updateProfile(
      userId: _userId!, 
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      profileImage: _selectedImage,
    );

    if (!mounted) return;

    if (success) {
      _showSuccessSnackBar('Profile updated successfully!');
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        Navigator.pop(context, true);
      }
    } else {
      _showErrorSnackBar(provider.errorMessage ?? 'Failed to update profile');
    }
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF1E293B),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF1E293B),
              size: 18,
            ),
          ),
        ),
      ),
      body: _isInitialLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4F46E5)),
              ),
            )
          : Consumer<ProfileProvider>(
              builder: (context, provider, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Picture Section
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFE2E8F0),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF4F46E5).withOpacity(0.2),
                                            blurRadius: 20,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundColor: const Color(0xFFF1F5F9),
                                        backgroundImage: _selectedImage != null
                                            ? FileImage(_selectedImage!)
                                            : (provider.profileImageUrl != null
                                                ? NetworkImage(provider.profileImageUrl!)
                                                : const AssetImage(
                                                    'lib/assets/403079b6b3230e238d25d0e18c175d870e3223de.png',
                                                  )) as ImageProvider,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 4,
                                      right: 4,
                                      child: GestureDetector(
                                        onTap: _pickImage,
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF4F46E5),
                                                Color(0xFF6366F1),
                                              ],
                                            ),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.15),
                                                blurRadius: 8,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Change Profile Picture',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Form Fields Section
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Personal Information',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          _buildModernInputField(
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            controller: _nameController,
                            icon: Icons.person_outline_rounded,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),

                          _buildModernInputField(
                            label: 'Mobile Number',
                            hint: 'Enter mobile number',
                            controller: _mobileController,
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            enabled: false,
                          ),

                          _buildModernInputField(
                            label: 'Email Address',
                            hint: 'Enter your email',
                            controller: _emailController,
                            icon: Icons.email_outlined,
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

                          const SizedBox(height: 32),

                          // Save Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: double.infinity,
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: provider.isLoading
                                    ? LinearGradient(
                                        colors: [
                                          Colors.grey.shade300,
                                          Colors.grey.shade400,
                                        ],
                                      )
                                    : const LinearGradient(
                                        colors: [
                                          Color(0xFF4F46E5),
                                          Color(0xFF6366F1),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: provider.isLoading
                                    ? []
                                    : [
                                        BoxShadow(
                                          color: const Color(0xFF4F46E5).withOpacity(0.4),
                                          blurRadius: 16,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                              ),
                              child: ElevatedButton(
                                onPressed: provider.isLoading ? null : _saveProfile,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: provider.isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline_rounded,
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                            'Save Changes',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.5,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildModernInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool enabled = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          validator: validator,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1E293B),
          ),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: enabled ? const Color(0xFF64748B) : Colors.grey.shade400,
            ),
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                icon,
                color: enabled ? const Color(0xFF4F46E5) : Colors.grey.shade400,
                size: 22,
              ),
            ),
            filled: true,
            fillColor: enabled ? Colors.white : const Color(0xFFF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFE2E8F0),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF4F46E5),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFEF4444),
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFFEF4444),
                width: 2,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
          ),
        ),
      ),
    );
  }
}