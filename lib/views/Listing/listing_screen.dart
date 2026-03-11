

// // lib/screens/create_listing_screen.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:product_app/Provider/product/product_provider.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'package:product_app/views/location/location_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class CreateListingScreen extends StatefulWidget {
//   final String? subcategoryId;
//   final String? name;
//   const CreateListingScreen({Key? key, this.subcategoryId, this.name})
//       : super(key: key);

//   @override
//   State<CreateListingScreen> createState() => _CreateListingScreenState();
// }

// class _CreateListingScreenState extends State<CreateListingScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final ImagePicker _picker = ImagePicker();

//   // Controllers
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _userNameController = TextEditingController();
  
//   // Category-specific controllers
//   final TextEditingController _rentAmountController = TextEditingController();
//   final TextEditingController _landAmountController = TextEditingController();
//   final TextEditingController _landDetailsController = TextEditingController();
//   final TextEditingController _openingTimeController = TextEditingController();
//   final TextEditingController _closingTimeController = TextEditingController();
//   List<TextEditingController> _serviceTypeControllers = [];

//   // State variables
//   String _selectedType = 'Sale';
//   double? _latitude;
//   double? _longitude;
//   List<File> _productImages = [];
//   List<File> _featureImages = [];
//   List<TextEditingController> _featureNameControllers = [];
//   int _featureCount = 0;
//   bool _isLoadingProfile = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchUserProfile();
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     _addressController.dispose();
//     _mobileController.dispose();
//     _emailController.dispose();
//     _userNameController.dispose();
//     _rentAmountController.dispose();
//     _landAmountController.dispose();
//     _landDetailsController.dispose();
//     _openingTimeController.dispose();
//     _closingTimeController.dispose();
//     for (var controller in _featureNameControllers) {
//       controller.dispose();
//     }
//     for (var controller in _serviceTypeControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   // Check if category needs specific fields
//   bool _needsRentAmount() {
//     final categoryName = widget.name?.toLowerCase() ?? '';
//     return categoryName == 'villas' || categoryName == 'house';
//   }

//   bool _needsServiceType() {
//     final categoryName = widget.name?.toLowerCase() ?? '';
//     return categoryName == 'shops' || categoryName == 'business' || categoryName == 'resturant';
//   }

//   bool _needsLandFields() {
//     final categoryName = widget.name?.toLowerCase() ?? '';
//     return categoryName == 'lands';
//   }

//   bool _needsOpeningHours() {
//     final categoryName = widget.name?.toLowerCase() ?? '';
//     return categoryName == 'shops' || categoryName == 'business' || categoryName == 'resturant';
//   }

//   // Fetch user profile from API
//   Future<void> _fetchUserProfile() async {
//     final userId = SharedPrefHelper.getUserId();
//     if (userId == null) {
//       setState(() => _isLoadingProfile = false);
//       _showSnackBar('User not found. Please login again.', isError: true);
//       return;
//     }

//     try {
//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:9174/api/auth/profile/$userId'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${SharedPrefHelper.getToken()}',
//         },
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['success'] == true && data['user'] != null) {
//           final user = data['user'];
//           setState(() {
//             _mobileController.text = user['mobile'] ?? '';
//             _emailController.text = user['email'] ?? '';
//             _userNameController.text = user['name'] ?? '';
//             _isLoadingProfile = false;
//           });
//         } else {
//           setState(() => _isLoadingProfile = false);
//           _showSnackBar('Failed to load profile', isError: true);
//         }
//       } else {
//         setState(() => _isLoadingProfile = false);
//         _showSnackBar('Failed to fetch profile', isError: true);
//       }
//     } catch (e) {
//       setState(() => _isLoadingProfile = false);
//       _showSnackBar('Error fetching profile: ${e.toString()}', isError: true);
//     }
//   }

//   bool _isLargeScreen(BuildContext context) {
//     return MediaQuery.of(context).size.width >= 768;
//   }

//   double _getMaxWidth(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     if (screenWidth >= 1200) return 900;
//     if (screenWidth >= 768) return 700;
//     return screenWidth;
//   }

//   Future<void> _pickProductImages() async {
//     final List<XFile> images = await _picker.pickMultiImage();
//     if (images.isNotEmpty) {
//       setState(() {
//         _productImages.addAll(images.map((image) => File(image.path)));
//       });
//     }
//   }

//   Future<void> _pickFeatureImage(int index) async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if (image != null) {
//       setState(() {
//         if (_featureImages.length > index) {
//           _featureImages[index] = File(image.path);
//         } else {
//           _featureImages.add(File(image.path));
//         }
//       });
//     }
//   }

//   void _addFeature() {
//     setState(() {
//       _featureCount++;
//       _featureNameControllers.add(TextEditingController());
//     });
//   }

//   void _removeFeature(int index) {
//     setState(() {
//       _featureNameControllers[index].dispose();
//       _featureNameControllers.removeAt(index);
//       if (_featureImages.length > index) {
//         _featureImages.removeAt(index);
//       }
//       _featureCount--;
//     });
//   }

//   void _addServiceType() {
//     setState(() {
//       _serviceTypeControllers.add(TextEditingController());
//     });
//   }

//   void _removeServiceType(int index) {
//     setState(() {
//       _serviceTypeControllers[index].dispose();
//       _serviceTypeControllers.removeAt(index);
//     });
//   }

//   void _removeProductImage(int index) {
//     setState(() {
//       _productImages.removeAt(index);
//     });
//   }

//   Future<void> _navigateToLocationScreen() async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => LocationFetchScreen(
//           userId: SharedPrefHelper.getUserId(),
//         ),
//       ),
//     );

//     if (result != null && result is Map<String, dynamic>) {
//       setState(() {
//         _latitude = result['latitude'];
//         _longitude = result['longitude'];
//         _addressController.text = result['address'] ?? '';
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
    
//     if (picked != null) {
//       setState(() {
//         controller.text = picked.format(context);
//       });
//     }
//   }

//   void _showSnackBar(String message, {bool isError = false}) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Row(
//           children: [
//             Icon(
//               isError ? Icons.error_outline : Icons.check_circle_outline,
//               color: Colors.white,
//             ),
//             const SizedBox(width: 12),
//             Expanded(child: Text(message)),
//           ],
//         ),
//         backgroundColor: isError ? Colors.red : Colors.green,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: const EdgeInsets.all(16),
//       ),
//     );
//   }

//   Future<void> _submitListing() async {
//     if (!_formKey.currentState!.validate()) return;

//     if (_productImages.isEmpty) {
//       _showSnackBar('Please add at least one product image', isError: true);
//       return;
//     }

//     if (_latitude == null || _longitude == null) {
//       _showSnackBar('Please select a location', isError: true);
//       return;
//     }

//     if (widget.subcategoryId == null || widget.subcategoryId!.isEmpty) {
//       _showSnackBar('Subcategory ID is required', isError: true);
//       return;
//     }

//     // Validate category-specific fields
//     if (_needsRentAmount() && _rentAmountController.text.trim().isEmpty) {
//       _showSnackBar('Please enter rent amount', isError: true);
//       return;
//     }

//     if (_needsServiceType() && _serviceTypeControllers.isEmpty) {
//       _showSnackBar('Please add at least one service type', isError: true);
//       return;
//     }

//     if (_needsOpeningHours()) {
//       if (_openingTimeController.text.trim().isEmpty || _closingTimeController.text.trim().isEmpty) {
//         _showSnackBar('Please select opening and closing hours', isError: true);
//         return;
//       }
//     }

//     if (_needsLandFields()) {
//       if (_landAmountController.text.trim().isEmpty) {
//         _showSnackBar('Please enter land amount', isError: true);
//         return;
//       }
//       if (_landDetailsController.text.trim().isEmpty) {
//         _showSnackBar('Please enter land details', isError: true);
//         return;
//       }
//     }

//     final userId = SharedPrefHelper.getUserId();
//     if (userId == null) {
//       _showSnackBar('User not found. Please login again.', isError: true);
//       return;
//     }

//     List<String> featureNames = _featureNameControllers
//         .map((controller) => controller.text.trim())
//         .where((text) => text.isNotEmpty)
//         .toList();

//     List<String> serviceTypes = _serviceTypeControllers
//         .map((controller) => controller.text.trim())
//         .where((text) => text.isNotEmpty)
//         .toList();

//     // Prepare opening hours map if needed
//     Map<String, dynamic>? openingHours;
//     if (_needsOpeningHours()) {
//       openingHours = {
//         'opening': _openingTimeController.text.trim(),
//         'closing': _closingTimeController.text.trim(),
//       };
//     }

//     // Prepare contact details
//     Map<String, String> contactDetails = {
//       'mobile': _mobileController.text.trim(),
//       'email': _emailController.text.trim(),
//       'name': _userNameController.text.trim(),
//     };

//     // Prepare category-specific data
//     Map<String, dynamic>? houseRent;
//     if (_needsRentAmount()) {
//       houseRent = {'amount': _rentAmountController.text.trim()};
//     }

//     Map<String, dynamic>? landDetails;
//     if (_needsLandFields()) {
//       landDetails = {
//         'amount': _landAmountController.text.trim(),
//         'details': _landDetailsController.text.trim(),
//       };
//     }

//     try {
//       final provider = context.read<ProductProvider>();

//       final success = await provider.createListing(
//         subCategoryId: widget.subcategoryId!,
//         name: _nameController.text.trim(),
//         type: _selectedType,
//         address: _addressController.text.trim(),
//         description: _descriptionController.text.trim(),
//         latitude: _latitude!,
//         longitude: _longitude!,
//         featureNames: featureNames,
//         images: _productImages,
//         featureImages: _featureImages.isNotEmpty ? _featureImages : null,
//         contactDetails: contactDetails,
//         openingHours: openingHours,
//         houseRent: houseRent,
//         shopServices: _needsServiceType() ? serviceTypes : null,
//         businessServices: _needsServiceType() ? serviceTypes : null,
//         restaurantServices: _needsServiceType() ? serviceTypes : null,
//         landDetails: landDetails,
//       );

//       if (success && mounted) {
//         _showSnackBar('Listing created successfully!');
//         await Future.delayed(const Duration(seconds: 1));
//         if (mounted) Navigator.pop(context, true);
//       } else if (mounted) {
//         _showSnackBar(
//           provider.errorMessage ?? 'Failed to create listing',
//           isError: true,
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         _showSnackBar('Error: ${e.toString()}', isError: true);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('categoryyyyyyyyyyyyy idddddddddd ${widget.subcategoryId}');
//     print('categorrrrrryyyyyyyyyyyyy naaaaaaaaaameeeeeeeeee ${widget.name}');

//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     final isLarge = _isLargeScreen(context);

//     return Scaffold(
//       backgroundColor:
//           isDark ? const Color(0xFF0A0A0A) : const Color(0xFFF8FAFC),
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: isDark ? Colors.white : const Color(0xFF374151),
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Create Listing - ${widget.name ?? "Property"}',
//           style: GoogleFonts.inter(
//             fontSize: 20,
//             fontWeight: FontWeight.w700,
//             color: isDark ? Colors.white : const Color(0xFF111827),
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer<ProductProvider>(
//         builder: (context, provider, child) {
//           if (provider.isLoading || _isLoadingProfile) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const CircularProgressIndicator(),
//                   const SizedBox(height: 16),
//                   Text(
//                     _isLoadingProfile
//                         ? 'Loading profile...'
//                         : 'Creating your listing...',
//                     style: GoogleFonts.inter(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                       color: isDark ? Colors.white70 : const Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }

//           return Center(
//             child: Container(
//               constraints: BoxConstraints(maxWidth: _getMaxWidth(context)),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.all(isLarge ? 32 : 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Contact Information Section
//                       _buildSectionHeader(
//                           'Contact Information', Icons.person_rounded),
//                       const SizedBox(height: 16),

//                       if (isLarge)
//                         _buildTwoColumnLayout(
//                           left: _buildTextField(
//                             controller: _userNameController,
//                             label: 'Your Name',
//                             hint: 'Your name',
//                             icon: Icons.person_outline_rounded,
//                             isDark: isDark,
//                             readOnly: true,
//                           ),
//                           right: _buildTextField(
//                             controller: _mobileController,
//                             label: 'Mobile Number',
//                             hint: 'Your mobile number',
//                             icon: Icons.phone_rounded,
//                             isDark: isDark,
//                             readOnly: true,
//                             keyboardType: TextInputType.phone,
//                           ),
//                         )
//                       else ...[
//                         _buildTextField(
//                           controller: _userNameController,
//                           label: 'Your Name',
//                           hint: 'Your name',
//                           icon: Icons.person_outline_rounded,
//                           isDark: isDark,
//                           readOnly: true,
//                         ),
//                         _buildTextField(
//                           controller: _mobileController,
//                           label: 'Mobile Number',
//                           hint: 'Your mobile number',
//                           icon: Icons.phone_rounded,
//                           isDark: isDark,
//                           readOnly: true,
//                           keyboardType: TextInputType.phone,
//                         ),
//                       ],

//                       _buildTextField(
//                         controller: _emailController,
//                         label: 'Email',
//                         hint: 'Your email address',
//                         icon: Icons.email_rounded,
//                         isDark: isDark,
//                         readOnly: true,
//                         keyboardType: TextInputType.emailAddress,
//                       ),

//                       const SizedBox(height: 24),

//                       // Property Details Section
//                       _buildSectionHeader(
//                           'Property Details', Icons.home_rounded),
//                       const SizedBox(height: 16),

//                       _buildTextField(
//                         controller: _nameController,
//                         label: 'Property Name',
//                         hint: 'e.g., Luxury House LakeView Estate',
//                         icon: Icons.business_rounded,
//                         isDark: isDark,
//                       ),

//                       _buildTextField(
//                         controller: _descriptionController,
//                         label: 'Description',
//                         hint: 'Describe your property...',
//                         icon: Icons.description_rounded,
//                         maxLines: 4,
//                         isDark: isDark,
//                       ),

//                       // Category-specific fields
//                       if (_needsRentAmount()) ...[
//                         const SizedBox(height: 16),
//                         _buildTextField(
//                           controller: _rentAmountController,
//                           label: 'Rent Amount',
//                           hint: 'e.g., 50000',
//                           icon: Icons.currency_rupee_rounded,
//                           isDark: isDark,
//                           keyboardType: TextInputType.number,
//                         ),
//                       ],

//                       if (_needsLandFields()) ...[
//                         const SizedBox(height: 16),
//                         _buildTextField(
//                           controller: _landAmountController,
//                           label: 'Land Amount',
//                           hint: 'e.g., 5000000',
//                           icon: Icons.currency_rupee_rounded,
//                           isDark: isDark,
//                           keyboardType: TextInputType.number,
//                         ),
//                         _buildTextField(
//                           controller: _landDetailsController,
//                           label: 'Land Details',
//                           hint: 'e.g., 5 acres, agricultural land',
//                           icon: Icons.landscape_rounded,
//                           isDark: isDark,
//                           maxLines: 3,
//                         ),
//                       ],

//                       const SizedBox(height: 24),

//                       // Opening Hours Section
//                       if (_needsOpeningHours()) ...[
//                         _buildSectionHeader(
//                             'Opening Hours', Icons.access_time_rounded),
//                         const SizedBox(height: 16),
                        
//                         if (isLarge)
//                           _buildTwoColumnLayout(
//                             left: _buildTimeField(
//                               controller: _openingTimeController,
//                               label: 'Opening Time',
//                               hint: 'Select opening time',
//                               icon: Icons.wb_sunny_rounded,
//                               isDark: isDark,
//                             ),
//                             right: _buildTimeField(
//                               controller: _closingTimeController,
//                               label: 'Closing Time',
//                               hint: 'Select closing time',
//                               icon: Icons.nightlight_round,
//                               isDark: isDark,
//                             ),
//                           )
//                         else ...[
//                           _buildTimeField(
//                             controller: _openingTimeController,
//                             label: 'Opening Time',
//                             hint: 'Select opening time',
//                             icon: Icons.wb_sunny_rounded,
//                             isDark: isDark,
//                           ),
//                           _buildTimeField(
//                             controller: _closingTimeController,
//                             label: 'Closing Time',
//                             hint: 'Select closing time',
//                             icon: Icons.nightlight_round,
//                             isDark: isDark,
//                           ),
//                         ],
                        
//                         const SizedBox(height: 24),
//                       ],

//                       // Service Types Section (for Shop, Business, Restaurant)
//                       if (_needsServiceType()) ...[
//                         _buildSectionHeader(
//                             'Service Types', Icons.medical_services_rounded),
//                         const SizedBox(height: 16),
//                         _buildServiceTypesSection(isDark, isLarge),
//                         const SizedBox(height: 24),
//                       ],

//                       // Location Section
//                       _buildSectionHeader(
//                           'Location', Icons.location_on_rounded),
//                       const SizedBox(height: 16),

//                       _buildLocationCard(isDark),

//                       const SizedBox(height: 24),

//                       // Product Images Section
//                       _buildSectionHeader(
//                           'Property Images', Icons.photo_library_rounded),
//                       const SizedBox(height: 16),

//                       _buildImagePicker(isDark, isLarge),

//                       const SizedBox(height: 24),

//                       // Features Section
//                       _buildSectionHeader('Features', Icons.stars_rounded),
//                       const SizedBox(height: 16),

//                       _buildFeaturesSection(isDark, isLarge),

//                       const SizedBox(height: 32),

//                       // Submit Button
//                       _buildSubmitButton(isDark, isLarge),

//                       const SizedBox(height: 20),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTimeField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     required bool isDark,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         readOnly: true,
//         onTap: () => _selectTime(context, controller),
//         style: GoogleFonts.inter(
//           fontSize: 15,
//           color: isDark ? Colors.white : const Color(0xFF111827),
//         ),
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           prefixIcon: Icon(icon, color: const Color(0xFF2BBBAD)),
//           suffixIcon: const Icon(Icons.arrow_drop_down, color: Color(0xFF2BBBAD)),
//           filled: true,
//           fillColor: isDark ? const Color(0xFF1F2937) : Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Color(0xFF2BBBAD), width: 2),
//           ),
//         ),
//         validator: (value) => value == null || value.trim().isEmpty
//             ? 'This field is required'
//             : null,
//       ),
//     );
//   }

//   Widget _buildServiceTypesSection(bool isDark, bool isLarge) {
//     return Column(
//       children: [
//         if (_serviceTypeControllers.isEmpty)
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: isDark ? const Color(0xFF1F2937) : Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 'No service types added yet',
//                 style: GoogleFonts.inter(
//                   fontSize: 14,
//                   color: isDark ? Colors.white70 : const Color(0xFF6B7280),
//                 ),
//               ),
//             ),
//           )
//         else if (isLarge)
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//               childAspectRatio: 4,
//             ),
//             itemCount: _serviceTypeControllers.length,
//             itemBuilder: (context, index) {
//               return _buildServiceTypeItem(
//                   index, _serviceTypeControllers[index], isDark);
//             },
//           )
//         else
//           ..._serviceTypeControllers.asMap().entries.map((entry) {
//             final index = entry.key;
//             final controller = entry.value;
//             return _buildServiceTypeItem(index, controller, isDark);
//           }),
//         const SizedBox(height: 16),
//         SizedBox(
//           width: isLarge ? 250 : double.infinity,
//           child: OutlinedButton.icon(
//             onPressed: _addServiceType,
//             icon: const Icon(Icons.add),
//             label: Text(
//               'Add Service Type',
//               style: GoogleFonts.inter(fontWeight: FontWeight.w600),
//             ),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: const Color(0xFF2BBBAD),
//               side: const BorderSide(color: Color(0xFF2BBBAD)),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildServiceTypeItem(
//       int index, TextEditingController controller, bool isDark) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//               controller: controller,
//               style: GoogleFonts.inter(
//                 fontSize: 15,
//                 color: isDark ? Colors.white : const Color(0xFF111827),
//               ),
//               decoration: InputDecoration(
//                 labelText: 'Service ${index + 1}',
//                 hintText: 'e.g., Home Delivery, Dine-in',
//                 prefixIcon: const Icon(Icons.room_service_rounded, 
//                     color: Color(0xFF2BBBAD)),
//                 filled: true,
//                 fillColor: isDark ? const Color(0xFF1F2937) : Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: isDark 
//                         ? const Color(0xFF374151) 
//                         : const Color(0xFFE5E7EB),
//                   ),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: BorderSide(
//                     color: isDark 
//                         ? const Color(0xFF374151) 
//                         : const Color(0xFFE5E7EB),
//                   ),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(
//                       color: Color(0xFF2BBBAD), width: 2),
//                 ),
//               ),
//               validator: (value) => value == null || value.trim().isEmpty
//                   ? 'Service type is required'
//                   : null,
//             ),
//           ),
//           const SizedBox(width: 12),
//           IconButton(
//             onPressed: () => _removeServiceType(index),
//             icon: const Icon(Icons.delete_outline, color: Colors.red),
//             style: IconButton.styleFrom(
//               backgroundColor: isDark 
//                   ? const Color(0xFF1F2937) 
//                   : const Color(0xFFFEF2F2),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTwoColumnLayout({required Widget left, required Widget right}) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(child: left),
//         const SizedBox(width: 16),
//         Expanded(child: right),
//       ],
//     );
//   }

//   Widget _buildSectionHeader(String title, IconData icon) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFF00A8E8), Color(0xFF2BBBAD)],
//             ),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(icon, color: Colors.white, size: 20),
//         ),
//         const SizedBox(width: 12),
//         Text(
//           title,
//           style: GoogleFonts.inter(
//             fontSize: 18,
//             fontWeight: FontWeight.w700,
//             color: isDark ? Colors.white : const Color(0xFF111827),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//     required bool isDark,
//     int maxLines = 1,
//     TextInputType keyboardType = TextInputType.text,
//     bool readOnly = false,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         readOnly: readOnly,
//         style: GoogleFonts.inter(
//           fontSize: 15,
//           color: isDark ? Colors.white : const Color(0xFF111827),
//         ),
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           prefixIcon: Icon(icon, color: const Color(0xFF2BBBAD)),
//           suffixIcon: readOnly
//               ? const Icon(Icons.lock_outline,
//                   size: 18, color: Color(0xFF6B7280))
//               : null,
//           filled: true,
//           fillColor: readOnly
//               ? (isDark ? const Color(0xFF111827) : const Color(0xFFF9FAFB))
//               : (isDark ? const Color(0xFF1F2937) : Colors.white),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
//             ),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(
//               color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Color(0xFF2BBBAD), width: 2),
//           ),
//         ),
//         validator: (value) => value == null || value.trim().isEmpty
//             ? 'This field is required'
//             : null,
//       ),
//     );
//   }

//   Widget _buildLocationCard(bool isDark) {
//     return GestureDetector(
//       onTap: _navigateToLocationScreen,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: isDark ? const Color(0xFF1F2937) : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: _latitude != null
//                 ? const Color(0xFF2BBBAD)
//                 : (isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB)),
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 gradient: const LinearGradient(
//                   colors: [Color(0xFF00A8E8), Color(0xFF2BBBAD)],
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: const Icon(Icons.location_on, color: Colors.white, size: 24),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _latitude != null ? 'Location Selected' : 'Select Location',
//                     style: GoogleFonts.inter(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: isDark ? Colors.white : const Color(0xFF111827),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     _latitude != null
//                         ? _addressController.text.isNotEmpty
//                             ? _addressController.text
//                             : 'Lat: ${_latitude!.toStringAsFixed(4)}, Long: ${_longitude!.toStringAsFixed(4)}'
//                         : 'Tap to select property location',
//                     style: GoogleFonts.inter(
//                       fontSize: 13,
//                       color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 12),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               size: 16,
//               color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImagePicker(bool isDark, bool isLarge) {
//     return Column(
//       children: [
//         if (_productImages.isEmpty)
//           GestureDetector(
//             onTap: _pickProductImages,
//             child: Container(
//               height: 200,
//               decoration: BoxDecoration(
//                 color: isDark ? const Color(0xFF1F2937) : const Color(0xFFF9FAFB),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
//                   style: BorderStyle.solid,
//                   width: 2,
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                         colors: [Color(0xFF00A8E8), Color(0xFF2BBBAD)],
//                       ),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: const Icon(Icons.add_photo_alternate, 
//                         color: Colors.white, size: 32),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'Tap to add images',
//                     style: GoogleFonts.inter(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: isDark ? Colors.white : const Color(0xFF111827),
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     'Add up to 10 images',
//                     style: GoogleFonts.inter(
//                       fontSize: 13,
//                       color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         else
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: isLarge ? 4 : 3,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 12,
//               childAspectRatio: 1,
//             ),
//             itemCount: _productImages.length + 1,
//             itemBuilder: (context, index) {
//               if (index == _productImages.length) {
//                 return GestureDetector(
//                   onTap: _pickProductImages,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: isDark 
//                           ? const Color(0xFF1F2937) 
//                           : const Color(0xFFF9FAFB),
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: isDark 
//                             ? const Color(0xFF374151) 
//                             : const Color(0xFFE5E7EB),
//                         style: BorderStyle.solid,
//                         width: 2,
//                       ),
//                     ),
//                     child: const Icon(Icons.add, color: Color(0xFF2BBBAD), size: 32),
//                   ),
//                 );
//               }

//               return Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(12),
//                   image: DecorationImage(
//                     image: FileImage(_productImages[index]),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       top: 4,
//                       right: 4,
//                       child: GestureDetector(
//                         onTap: () => _removeProductImage(index),
//                         child: Container(
//                           padding: const EdgeInsets.all(4),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: const Icon(Icons.close, 
//                               color: Colors.white, size: 16),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//       ],
//     );
//   }

//   Widget _buildFeaturesSection(bool isDark, bool isLarge) {
//     return Column(
//       children: [
//         if (_featureCount == 0)
//           Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: isDark ? const Color(0xFF1F2937) : Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(
//                 color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
//               ),
//             ),
//             child: Center(
//               child: Text(
//                 'No features added yet',
//                 style: GoogleFonts.inter(
//                   fontSize: 14,
//                   color: isDark ? Colors.white70 : const Color(0xFF6B7280),
//                 ),
//               ),
//             ),
//           )
//         else
//           ...List.generate(_featureCount, (index) {
//             return _buildFeatureItem(index, isDark, isLarge);
//           }),
//         const SizedBox(height: 16),
//         SizedBox(
//           width: isLarge ? 250 : double.infinity,
//           child: OutlinedButton.icon(
//             onPressed: _addFeature,
//             icon: const Icon(Icons.add),
//             label: Text(
//               'Add Feature',
//               style: GoogleFonts.inter(fontWeight: FontWeight.w600),
//             ),
//             style: OutlinedButton.styleFrom(
//               foregroundColor: const Color(0xFF2BBBAD),
//               side: const BorderSide(color: Color(0xFF2BBBAD)),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFeatureItem(int index, bool isDark, bool isLarge) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: isDark ? const Color(0xFF1F2937) : Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isDark ? const Color(0xFF374151) : const Color(0xFFE5E7EB),
//         ),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: TextFormField(
//                   controller: _featureNameControllers[index],
//                   style: GoogleFonts.inter(
//                     fontSize: 15,
//                     color: isDark ? Colors.white : const Color(0xFF111827),
//                   ),
//                   decoration: InputDecoration(
//                     labelText: 'Feature ${index + 1}',
//                     hintText: 'e.g., Swimming Pool, Garden',
//                     prefixIcon: const Icon(Icons.star_outline_rounded,
//                         color: Color(0xFF2BBBAD)),
//                     filled: true,
//                     fillColor: isDark 
//                         ? const Color(0xFF111827) 
//                         : const Color(0xFFF9FAFB),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: isDark 
//                             ? const Color(0xFF374151) 
//                             : const Color(0xFFE5E7EB),
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide(
//                         color: isDark 
//                             ? const Color(0xFF374151) 
//                             : const Color(0xFFE5E7EB),
//                       ),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                           color: Color(0xFF2BBBAD), width: 2),
//                     ),
//                   ),
//                   validator: (value) => value == null || value.trim().isEmpty
//                       ? 'Feature name is required'
//                       : null,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               IconButton(
//                 onPressed: () => _removeFeature(index),
//                 icon: const Icon(Icons.delete_outline, color: Colors.red),
//                 style: IconButton.styleFrom(
//                   backgroundColor: isDark 
//                       ? const Color(0xFF1F2937) 
//                       : const Color(0xFFFEF2F2),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           GestureDetector(
//             onTap: () => _pickFeatureImage(index),
//             child: Container(
//               height: 120,
//               decoration: BoxDecoration(
//                 color: isDark 
//                     ? const Color(0xFF111827) 
//                     : const Color(0xFFF9FAFB),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: _featureImages.length > index
//                       ? const Color(0xFF2BBBAD)
//                       : (isDark 
//                           ? const Color(0xFF374151) 
//                           : const Color(0xFFE5E7EB)),
//                   style: BorderStyle.solid,
//                   width: 2,
//                 ),
//                 image: _featureImages.length > index
//                     ? DecorationImage(
//                         image: FileImage(_featureImages[index]),
//                         fit: BoxFit.cover,
//                       )
//                     : null,
//               ),
//               child: _featureImages.length > index
//                   ? null
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(Icons.add_a_photo, 
//                             color: Color(0xFF2BBBAD), size: 28),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Add feature image',
//                           style: GoogleFonts.inter(
//                             fontSize: 13,
//                             color: isDark 
//                                 ? const Color(0xFF9CA3AF) 
//                                 : const Color(0xFF6B7280),
//                           ),
//                         ),
//                       ],
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubmitButton(bool isDark, bool isLarge) {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: _submitListing,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           padding: EdgeInsets.zero,
//         ),
//         child: Ink(
//           decoration: BoxDecoration(
//             gradient: const LinearGradient(
//               colors: [Color(0xFF00A8E8), Color(0xFF2BBBAD)],
//             ),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Container(
//             alignment: Alignment.center,
//             child: Text(
//               'Create Listing',
//               style: GoogleFonts.inter(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



















import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_app/Provider/product/product_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:product_app/views/location/location_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateListingScreen extends StatefulWidget {
  final String? subcategoryId;
  final String? name;
  const CreateListingScreen({Key? key, this.subcategoryId, this.name})
      : super(key: key);

  @override
  State<CreateListingScreen> createState() => _CreateListingScreenState();
}

class _CreateListingScreenState extends State<CreateListingScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  // Category-specific controllers
  final TextEditingController _rentAmountController = TextEditingController();
  final TextEditingController _landAmountController = TextEditingController();
  final TextEditingController _landDetailsController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();
  List<TextEditingController> _serviceTypeControllers = [];

  // State variables
  String _selectedType = 'Sale';
  double? _latitude;
  double? _longitude;
  List<File> _productImages = [];
  List<File> _featureImages = [];
  List<TextEditingController> _featureNameControllers = [];
  int _featureCount = 0;
  bool _isLoadingProfile = true;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    _fetchUserProfile();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _userNameController.dispose();
    _rentAmountController.dispose();
    _landAmountController.dispose();
    _landDetailsController.dispose();
    _openingTimeController.dispose();
    _closingTimeController.dispose();
    for (var controller in _featureNameControllers) {
      controller.dispose();
    }
    for (var controller in _serviceTypeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Check if category needs specific fields
  bool _needsRentAmount() {
    final categoryName = widget.name?.toLowerCase() ?? '';
    return categoryName == 'villas' || categoryName == 'house';
  }

  bool _needsServiceType() {
    final categoryName = widget.name?.toLowerCase() ?? '';
    return categoryName == 'shops' ||
        categoryName == 'business' ||
        categoryName == 'resturant';
  }

  bool _needsLandFields() {
    final categoryName = widget.name?.toLowerCase() ?? '';
    return categoryName == 'lands';
  }

  bool _needsOpeningHours() {
    final categoryName = widget.name?.toLowerCase() ?? '';
    return categoryName == 'shops' ||
        categoryName == 'business' ||
        categoryName == 'resturant';
  }

  // Fetch user profile from API
  Future<void> _fetchUserProfile() async {
    final userId = SharedPrefHelper.getUserId();
    if (userId == null) {
      setState(() => _isLoadingProfile = false);
      _showSnackBar('User not found. Please login again.', isError: true);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://31.97.206.144:9174/api/auth/profile/$userId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPrefHelper.getToken()}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success'] == true && data['user'] != null) {
          final user = data['user'];
          setState(() {
            _mobileController.text = user['mobile'] ?? '';
            _emailController.text = user['email'] ?? '';
            _userNameController.text = user['name'] ?? '';
            _isLoadingProfile = false;
          });
        } else {
          setState(() => _isLoadingProfile = false);
          _showSnackBar('Failed to load profile', isError: true);
        }
      } else {
        setState(() => _isLoadingProfile = false);
        _showSnackBar('Failed to fetch profile', isError: true);
      }
    } catch (e) {
      setState(() => _isLoadingProfile = false);
      _showSnackBar('Error fetching profile: ${e.toString()}', isError: true);
    }
  }

  bool _isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768;
  }

  double _getMaxWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 1200) return 1000;
    if (screenWidth >= 768) return 750;
    return screenWidth;
  }

  Future<void> _pickProductImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _productImages.addAll(images.map((image) => File(image.path)));
      });
    }
  }

  Future<void> _pickFeatureImage(int index) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (_featureImages.length > index) {
          _featureImages[index] = File(image.path);
        } else {
          _featureImages.add(File(image.path));
        }
      });
    }
  }

  void _addFeature() {
    setState(() {
      _featureCount++;
      _featureNameControllers.add(TextEditingController());
    });
  }

  void _removeFeature(int index) {
    setState(() {
      _featureNameControllers[index].dispose();
      _featureNameControllers.removeAt(index);
      if (_featureImages.length > index) {
        _featureImages.removeAt(index);
      }
      _featureCount--;
    });
  }

  void _addServiceType() {
    setState(() {
      _serviceTypeControllers.add(TextEditingController());
    });
  }

  void _removeServiceType(int index) {
    setState(() {
      _serviceTypeControllers[index].dispose();
      _serviceTypeControllers.removeAt(index);
    });
  }

  void _removeProductImage(int index) {
    setState(() {
      _productImages.removeAt(index);
    });
  }

  Future<void> _navigateToLocationScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationFetchScreen(
          userId: SharedPrefHelper.getUserId(),
        ),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _latitude = result['latitude'];
        _longitude = result['longitude'];
        _addressController.text = result['address'] ?? '';
      });
    }
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2BBBAD),
              onPrimary: Colors.white,
              onSurface: Color(0xFF111827),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isError ? Icons.error_outline : Icons.check_circle_outline,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.all(16),
        elevation: 8,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> _submitListing() async {
    if (!_formKey.currentState!.validate()) return;

    if (_productImages.isEmpty) {
      _showSnackBar('Please add at least one product image', isError: true);
      return;
    }

    if (_latitude == null || _longitude == null) {
      _showSnackBar('Please select a location', isError: true);
      return;
    }

    if (widget.subcategoryId == null || widget.subcategoryId!.isEmpty) {
      _showSnackBar('Subcategory ID is required', isError: true);
      return;
    }

    // Validate category-specific fields
    if (_needsRentAmount() && _rentAmountController.text.trim().isEmpty) {
      _showSnackBar('Please enter rent amount', isError: true);
      return;
    }

    if (_needsServiceType() && _serviceTypeControllers.isEmpty) {
      _showSnackBar('Please add at least one service type', isError: true);
      return;
    }

    if (_needsOpeningHours()) {
      if (_openingTimeController.text.trim().isEmpty ||
          _closingTimeController.text.trim().isEmpty) {
        _showSnackBar('Please select opening and closing hours',
            isError: true);
        return;
      }
    }

    if (_needsLandFields()) {
      if (_landAmountController.text.trim().isEmpty) {
        _showSnackBar('Please enter land amount', isError: true);
        return;
      }
      if (_landDetailsController.text.trim().isEmpty) {
        _showSnackBar('Please enter land details', isError: true);
        return;
      }
    }

    final userId = SharedPrefHelper.getUserId();
    if (userId == null) {
      _showSnackBar('User not found. Please login again.', isError: true);
      return;
    }

    List<String> featureNames = _featureNameControllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    List<String> serviceTypes = _serviceTypeControllers
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    // Prepare opening hours map if needed
    Map<String, dynamic>? openingHours;
    if (_needsOpeningHours()) {
      openingHours = {
        'opening': _openingTimeController.text.trim(),
        'closing': _closingTimeController.text.trim(),
      };
    }

    // Prepare contact details
    Map<String, String> contactDetails = {
      'mobile': _mobileController.text.trim(),
      'email': _emailController.text.trim(),
      'name': _userNameController.text.trim(),
    };

    // Prepare category-specific data
    Map<String, dynamic>? houseRent;
    if (_needsRentAmount()) {
      houseRent = {'amount': _rentAmountController.text.trim()};
    }

    Map<String, dynamic>? landDetails;
    if (_needsLandFields()) {
      landDetails = {
        'amount': _landAmountController.text.trim(),
        'details': _landDetailsController.text.trim(),
      };
    }

    try {
      final provider = context.read<ProductProvider>();

      final success = await provider.createListing(
        subCategoryId: widget.subcategoryId!,
        name: _nameController.text.trim(),
        type: _selectedType,
        address: _addressController.text.trim(),
        description: _descriptionController.text.trim(),
        latitude: _latitude!,
        longitude: _longitude!,
        featureNames: featureNames,
        images: _productImages,
        featureImages: _featureImages.isNotEmpty ? _featureImages : null,
        contactDetails: contactDetails,
        openingHours: openingHours,
        houseRent: houseRent,
        shopServices: _needsServiceType() ? serviceTypes : null,
        businessServices: _needsServiceType() ? serviceTypes : null,
        restaurantServices: _needsServiceType() ? serviceTypes : null,
        landDetails: landDetails,
      );

      if (success && mounted) {
        _showSnackBar('Listing created successfully!');
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) Navigator.pop(context, true);
      } else if (mounted) {
        _showSnackBar(
          provider.errorMessage ?? 'Failed to create listing',
          isError: true,
        );
      }
    } catch (e) {
      if (mounted) {
        _showSnackBar('Error: ${e.toString()}', isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLarge = _isLargeScreen(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F0F0F) : const Color(0xFFF5F7FA),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading || _isLoadingProfile) {
            return _buildLoadingState(isDark);
          }

          return CustomScrollView(
            slivers: [
              _buildAppBar(isDark),
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Center(
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: _getMaxWidth(context)),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.all(isLarge ? 32 : 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildProgressIndicator(isDark),
                              const SizedBox(height: 32),
                              _buildWelcomeCard(isDark),
                              const SizedBox(height: 32),
                              _buildContactSection(isDark, isLarge),
                              const SizedBox(height: 32),
                              _buildPropertyDetailsSection(isDark, isLarge),
                              const SizedBox(height: 32),
                              if (_needsOpeningHours()) ...[
                                _buildOpeningHoursSection(isDark, isLarge),
                                const SizedBox(height: 32),
                              ],
                              if (_needsServiceType()) ...[
                                _buildServiceTypesSection(isDark, isLarge),
                                const SizedBox(height: 32),
                              ],
                              _buildLocationSection(isDark),
                              const SizedBox(height: 32),
                              _buildImagesSection(isDark, isLarge),
                              const SizedBox(height: 32),
                              _buildFeaturesSection(isDark, isLarge),
                              const SizedBox(height: 48),
                              _buildSubmitButton(isDark),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ),
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

  Widget _buildLoadingState(bool isDark) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1F2937) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2BBBAD), Color(0xFF00A8E8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              _isLoadingProfile
                  ? 'Loading your profile...'
                  : 'Creating your listing...',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : const Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please wait a moment',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(bool isDark) {
    return SliverAppBar(
      expandedHeight: 140,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.white,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : const Color(0xFF111827),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 72, bottom: 16),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create Listing',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF111827),
              ),
            ),
            Text(
              widget.name ?? 'Property',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF2BBBAD),
              ),
            ),
          ],
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isDark
                  ? [
                      const Color(0xFF1A1A1A),
                      const Color(0xFF2D2D2D).withOpacity(0.8),
                    ]
                  : [
                      Colors.white,
                      const Color(0xFFF5F7FA),
                    ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2BBBAD).withOpacity(0.1),
            const Color(0xFF00A8E8).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2BBBAD).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          _buildStepIndicator(0, 'Details', isDark),
          _buildStepConnector(isDark),
          _buildStepIndicator(1, 'Location', isDark),
          _buildStepConnector(isDark),
          _buildStepIndicator(2, 'Images', isDark),
          _buildStepConnector(isDark),
          _buildStepIndicator(3, 'Done', isDark),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(int step, String label, bool isDark) {
    final isActive = _currentStep >= step;
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: isActive
                  ? const LinearGradient(
                      colors: [Color(0xFF2BBBAD), Color(0xFF00A8E8)],
                    )
                  : null,
              color: isActive
                  ? null
                  : isDark
                      ? const Color(0xFF374151)
                      : const Color(0xFFE5E7EB),
              shape: BoxShape.circle,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: const Color(0xFF2BBBAD).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: isActive
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : Text(
                      '${step + 1}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF6B7280),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive
                  ? const Color(0xFF2BBBAD)
                  : (isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(bool isDark) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF2BBBAD).withOpacity(0.3),
              const Color(0xFF00A8E8).withOpacity(0.3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2BBBAD), Color(0xFF00A8E8)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2BBBAD).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.home_work_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'List Your ${widget.name ?? "Property"}',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Fill in the details to create your listing',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(bool isDark, bool isLarge) {
    return _buildSection(
      title: 'Contact Information',
      icon: Icons.contacts_rounded,
      isDark: isDark,
      child: Column(
        children: [
          if (isLarge)
            Row(
              children: [
                Expanded(
                  child: _buildModernTextField(
                    controller: _userNameController,
                    label: 'Full Name',
                    hint: 'Your name',
                    icon: Icons.person_outline_rounded,
                    isDark: isDark,
                    readOnly: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildModernTextField(
                    controller: _mobileController,
                    label: 'Mobile Number',
                    hint: 'Your mobile',
                    icon: Icons.phone_android_rounded,
                    isDark: isDark,
                    readOnly: true,
                  ),
                ),
              ],
            )
          else ...[
            _buildModernTextField(
              controller: _userNameController,
              label: 'Full Name',
              hint: 'Your name',
              icon: Icons.person_outline_rounded,
              isDark: isDark,
              readOnly: true,
            ),
            const SizedBox(height: 16),
            _buildModernTextField(
              controller: _mobileController,
              label: 'Mobile Number',
              hint: 'Your mobile',
              icon: Icons.phone_android_rounded,
              isDark: isDark,
              readOnly: true,
            ),
          ],
          const SizedBox(height: 16),
          _buildModernTextField(
            controller: _emailController,
            label: 'Email Address',
            hint: 'Your email',
            icon: Icons.email_outlined,
            isDark: isDark,
            readOnly: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetailsSection(bool isDark, bool isLarge) {
    return _buildSection(
      title: 'Property Details',
      icon: Icons.villa_rounded,
      isDark: isDark,
      child: Column(
        children: [
          _buildModernTextField(
            controller: _nameController,
            label: 'Property Name',
            hint: 'Enter a catchy name',
            icon: Icons.business_rounded,
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _buildModernTextField(
            controller: _descriptionController,
            label: 'Description',
            hint: 'Describe what makes your property special...',
            icon: Icons.description_outlined,
            isDark: isDark,
            maxLines: 5,
          ),
          if (_needsRentAmount()) ...[
            const SizedBox(height: 16),
            _buildModernTextField(
              controller: _rentAmountController,
              label: 'Monthly Rent',
              hint: 'Enter amount',
              icon: Icons.currency_rupee_rounded,
              isDark: isDark,
              keyboardType: TextInputType.number,
              prefix: '₹ ',
            ),
          ],
          if (_needsLandFields()) ...[
            const SizedBox(height: 16),
            _buildModernTextField(
              controller: _landAmountController,
              label: 'Land Price',
              hint: 'Enter amount',
              icon: Icons.currency_rupee_rounded,
              isDark: isDark,
              keyboardType: TextInputType.number,
              prefix: '₹ ',
            ),
            const SizedBox(height: 16),
            _buildModernTextField(
              controller: _landDetailsController,
              label: 'Land Specifications',
              hint: 'Area, type, etc.',
              icon: Icons.landscape_rounded,
              isDark: isDark,
              maxLines: 3,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOpeningHoursSection(bool isDark, bool isLarge) {
    return _buildSection(
      title: 'Operating Hours',
      icon: Icons.schedule_rounded,
      isDark: isDark,
      child: isLarge
          ? Row(
              children: [
                Expanded(
                  child: _buildTimeField(
                    controller: _openingTimeController,
                    label: 'Opening Time',
                    hint: 'Select time',
                    icon: Icons.wb_sunny_outlined,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTimeField(
                    controller: _closingTimeController,
                    label: 'Closing Time',
                    hint: 'Select time',
                    icon: Icons.nightlight_outlined,
                    isDark: isDark,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                _buildTimeField(
                  controller: _openingTimeController,
                  label: 'Opening Time',
                  hint: 'Select time',
                  icon: Icons.wb_sunny_outlined,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                _buildTimeField(
                  controller: _closingTimeController,
                  label: 'Closing Time',
                  hint: 'Select time',
                  icon: Icons.nightlight_outlined,
                  isDark: isDark,
                ),
              ],
            ),
    );
  }

  Widget _buildServiceTypesSection(bool isDark, bool isLarge) {
    return _buildSection(
      title: 'Services Offered',
      icon: Icons.miscellaneous_services_rounded,
      isDark: isDark,
      child: Column(
        children: [
          if (_serviceTypeControllers.isEmpty)
            _buildEmptyState(
              'No services added yet',
              'Add the services you provide',
              Icons.add_business_rounded,
              isDark,
            )
          else
            ...List.generate(_serviceTypeControllers.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildServiceTypeItem(
                    index, _serviceTypeControllers[index], isDark),
              );
            }),
          const SizedBox(height: 16),
          _buildAddButton(
            label: 'Add Service',
            icon: Icons.add_rounded,
            onPressed: _addServiceType,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceTypeItem(
      int index, TextEditingController controller, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1F2937).withOpacity(0.5)
            : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2BBBAD).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : const Color(0xFF111827),
              ),
              decoration: InputDecoration(
                hintText: 'e.g., Home Delivery, Dine-in',
                hintStyle: GoogleFonts.inter(
                  color: isDark
                      ? const Color(0xFF9CA3AF)
                      : const Color(0xFF6B7280),
                ),
                prefixIcon: const Icon(Icons.room_service_outlined,
                    color: Color(0xFF2BBBAD)),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Required'
                  : null,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () => _removeServiceType(index),
              icon: const Icon(Icons.close, color: Colors.red, size: 20),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(bool isDark) {
    return _buildSection(
      title: 'Property Location',
      icon: Icons.location_on_rounded,
      isDark: isDark,
      child: GestureDetector(
        onTap: _navigateToLocationScreen,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: _latitude != null
                ? LinearGradient(
                    colors: [
                      const Color(0xFF2BBBAD).withOpacity(0.1),
                      const Color(0xFF00A8E8).withOpacity(0.1),
                    ],
                  )
                : null,
            color: _latitude == null
                ? (isDark
                    ? const Color(0xFF1F2937).withOpacity(0.5)
                    : Colors.white.withOpacity(0.5))
                : null,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _latitude != null
                  ? const Color(0xFF2BBBAD)
                  : (isDark
                      ? const Color(0xFF374151)
                      : const Color(0xFFE5E7EB)),
              width: _latitude != null ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2BBBAD), Color(0xFF00A8E8)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2BBBAD).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.my_location_rounded,
                    color: Colors.white, size: 28),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _latitude != null
                          ? '📍 Location Selected'
                          : 'Select Location',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color:
                            isDark ? Colors.white : const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _latitude != null
                          ? _addressController.text.isNotEmpty
                              ? _addressController.text
                              : 'Lat: ${_latitude!.toStringAsFixed(4)}, Long: ${_longitude!.toStringAsFixed(4)}'
                          : 'Tap to mark your property on the map',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: isDark
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF6B7280),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2BBBAD).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: Color(0xFF2BBBAD),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagesSection(bool isDark, bool isLarge) {
    return _buildSection(
      title: 'Property Images',
      icon: Icons.photo_library_rounded,
      isDark: isDark,
      child: Column(
        children: [
          if (_productImages.isEmpty)
            GestureDetector(
              onTap: _pickProductImages,
              child: Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF2BBBAD).withOpacity(0.1),
                      const Color(0xFF00A8E8).withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF2BBBAD).withOpacity(0.3),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2BBBAD), Color(0xFF00A8E8)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2BBBAD).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.add_photo_alternate_outlined,
                          color: Colors.white, size: 40),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Add Property Images',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color:
                            isDark ? Colors.white : const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Upload up to 10 high-quality images',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: isDark
                            ? const Color(0xFF9CA3AF)
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isLarge ? 4 : 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemCount: _productImages.length + 1,
              itemBuilder: (context, index) {
                if (index == _productImages.length) {
                  return GestureDetector(
                    onTap: _pickProductImages,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF2BBBAD).withOpacity(0.1),
                            const Color(0xFF00A8E8).withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF2BBBAD).withOpacity(0.3),
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: const Icon(Icons.add,
                          color: Color(0xFF2BBBAD), size: 36),
                    ),
                  );
                }

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          _productImages[index],
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () => _removeProductImage(index),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: const Icon(Icons.close,
                                  color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(bool isDark, bool isLarge) {
    return _buildSection(
      title: 'Special Features',
      icon: Icons.auto_awesome_rounded,
      isDark: isDark,
      child: Column(
        children: [
          if (_featureCount == 0)
            _buildEmptyState(
              'No features added',
              'Highlight what makes your property unique',
              Icons.star_outline_rounded,
              isDark,
            )
          else
            ...List.generate(_featureCount, (index) {
              return _buildFeatureItem(index, isDark);
            }),
          const SizedBox(height: 16),
          _buildAddButton(
            label: 'Add Feature',
            icon: Icons.add_rounded,
            onPressed: _addFeature,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(int index, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2BBBAD).withOpacity(0.05),
            const Color(0xFF00A8E8).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2BBBAD).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _featureNameControllers[index],
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : const Color(0xFF111827),
                  ),
                  decoration: InputDecoration(
                    labelText: 'Feature ${index + 1}',
                    hintText: 'e.g., Swimming Pool',
                    hintStyle: GoogleFonts.inter(
                      color: isDark
                          ? const Color(0xFF9CA3AF)
                          : const Color(0xFF6B7280),
                    ),
                    prefixIcon: const Icon(Icons.verified_outlined,
                        color: Color(0xFF2BBBAD)),
                    filled: true,
                    fillColor: isDark
                        ? const Color(0xFF1F2937).withOpacity(0.5)
                        : Colors.white.withOpacity(0.8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                  ),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Required' : null,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: () => _removeFeature(index),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  padding: const EdgeInsets.all(12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => _pickFeatureImage(index),
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1F2937).withOpacity(0.5)
                    : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _featureImages.length > index
                      ? const Color(0xFF2BBBAD)
                      : (isDark
                          ? const Color(0xFF374151)
                          : const Color(0xFFE5E7EB)),
                  width: _featureImages.length > index ? 2 : 1,
                ),
                image: _featureImages.length > index
                    ? DecorationImage(
                        image: FileImage(_featureImages[index]),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _featureImages.length > index
                  ? null
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2BBBAD).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add_a_photo_outlined,
                              color: Color(0xFF2BBBAD), size: 28),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Add Feature Image',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2BBBAD),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required bool isDark,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1A1A1A).withOpacity(0.6)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? const Color(0xFF374151).withOpacity(0.3)
              : const Color(0xFFE5E7EB).withOpacity(0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2BBBAD), Color(0xFF00A8E8)],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2BBBAD).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF111827),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    String? prefix,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: readOnly
            ? null
            : [
                BoxShadow(
                  color: const Color(0xFF2BBBAD).withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        readOnly: readOnly,
        style: GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: isDark ? Colors.white : const Color(0xFF111827),
        ),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixText: prefix,
          hintStyle: GoogleFonts.inter(
            color:
                isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280),
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2BBBAD).withOpacity(0.2),
                  const Color(0xFF00A8E8).withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF2BBBAD), size: 20),
          ),
          suffixIcon: readOnly
              ? Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF374151)
                          : const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.lock_outline,
                        size: 16, color: Color(0xFF6B7280)),
                  ),
                )
              : null,
          filled: true,
          fillColor: readOnly
              ? (isDark
                  ? const Color(0xFF111827).withOpacity(0.5)
                  : const Color(0xFFF9FAFB).withOpacity(0.5))
              : (isDark
                  ? const Color(0xFF1F2937).withOpacity(0.5)
                  : Colors.white.withOpacity(0.8)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDark
                  ? const Color(0xFF374151).withOpacity(0.3)
                  : const Color(0xFFE5E7EB).withOpacity(0.5),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF2BBBAD), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'This field is required' : null,
      ),
    );
  }

  Widget _buildTimeField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () => _selectTime(context, controller),
      child: AbsorbPointer(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2BBBAD).withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: isDark
                    ? const Color(0xFF9CA3AF)
                    : const Color(0xFF6B7280),
              ),
              prefixIcon: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF2BBBAD).withOpacity(0.2),
                      const Color(0xFF00A8E8).withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFF2BBBAD), size: 20),
              ),
              suffixIcon: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.access_time_rounded, color: Color(0xFF2BBBAD)),
              ),
              filled: true,
              fillColor: isDark
                  ? const Color(0xFF1F2937).withOpacity(0.5)
                  : Colors.white.withOpacity(0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: isDark
                      ? const Color(0xFF374151).withOpacity(0.3)
                      : const Color(0xFFE5E7EB).withOpacity(0.5),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide:
                    const BorderSide(color: Color(0xFF2BBBAD), width: 2),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            ),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'This field is required'
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(
      String title, String subtitle, IconData icon, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2BBBAD).withOpacity(0.05),
            const Color(0xFF00A8E8).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF2BBBAD).withOpacity(0.2),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2BBBAD).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF2BBBAD), size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: isDark
                  ? const Color(0xFF9CA3AF)
                  : const Color(0xFF6B7280),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2BBBAD).withOpacity(0.1),
            const Color(0xFF00A8E8).withOpacity(0.1),
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF2BBBAD).withOpacity(0.5),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF2BBBAD), Color(0xFF00A8E8)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2BBBAD),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(bool isDark) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF2BBBAD), Color(0xFF00A8E8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2BBBAD).withOpacity(0.4),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _submitListing,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.check_circle_outline,
                    color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Create Listing',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}