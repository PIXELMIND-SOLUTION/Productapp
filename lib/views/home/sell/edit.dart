// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:product_app/helper/helper_function.dart';
// import 'package:http/http.dart' as http;
// import 'package:product_app/views/home/navbar_screen.dart';
// import 'dart:convert';
// import 'package:geocoding/geocoding.dart' as geocoding;

// class Edit extends StatefulWidget {
//   final Map<String, dynamic>? productToEdit;
  
//   const Edit({
//     super.key,
//     this.productToEdit,
//   });

//   @override
//   State<Edit> createState() => _EditState();
// }

// class _EditState extends State<Edit> {
//   // Dynamic Categories from API
//   List<Map<String, dynamic>> categories = [];
//   String? selectedCategoryId;
//   String? selectedCategoryName;
//   bool isLoadingCategories = true;

//   // Form Controllers
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _addressController = TextEditingController();
//   final _contactNumberController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _websiteController = TextEditingController();
  
//   // Location Controllers
//   final _latitudeController = TextEditingController();
//   final _longitudeController = TextEditingController();
//   bool _isGettingLocation = false;

//   // Image Picker
//   final ImagePicker _picker = ImagePicker();
//   List<File> _selectedImages = [];
//   List<String> _existingImages = [];
//   bool _isUploading = false;

//   // Feature Images & Names
//   List<File> _featureImages = [];
//   List<String> _existingFeatureImages = [];
//   List<TextEditingController> _featureNameControllers = [];
//   List<String> _existingFeatureNames = [];

//   // Dynamic Attributes Map
//   Map<String, dynamic> attributeValues = {};
//   Map<String, TextEditingController> attributeControllers = {};
//   Map<String, bool> booleanAttributes = {};
//   Map<String, String> dropdownAttributes = {};
//   Map<String, List<String>> dropdownOptions = {};
//   Map<String, List<String>> multiSelectValues = {};

//   // Product ID for editing
//   String? _productId;

//   // Predefined dropdown options
//   final Map<String, List<String>> predefinedOptions = {
//     'unit': ['sqft', 'acres', 'sqm', 'yards'],
//     'furnishing': ['Fully Furnished', 'Semi Furnished', 'Unfurnished'],
//     'availability': ['Ready to Move', 'Under Construction', 'Upcoming'],
//     'ownership': ['Freehold', 'Leasehold', 'Co-operative'],
//     'waterSource': ['Borewell', 'Municipal', 'Well', 'Canal', 'Tanker'],
//     'landType': ['Residential', 'Commercial', 'Agricultural', 'Industrial', 'Mixed Use'],
//     'parking': ['Yes', 'No'],
//     'roomTypes': ['Single', 'Double', 'Suite', 'Deluxe', 'Executive', 'Presidential'],
//     'businessType': ['Startup', 'Small Business', 'Enterprise', 'Co-working', 'Freelance'],
//     'serviceType': ['Gold Purchase', 'Gold Sale', 'Exchange', 'Custom Design', 'Repairs'],
//     'companySize': ['1-10', '11-50', '51-200', '201-500', '500+'],
//     'workingDays': ['Mon-Fri', 'Mon-Sat', 'All Days', 'Weekends Only'],
//     'amenities': ['WiFi', 'Parking', 'Cafeteria', 'Conference Room', 'Security', 'Power Backup'],
//   };

//   // Category-specific attribute templates
//   final Map<String, List<Map<String, dynamic>>> categoryAttributes = {
//     'villa': [
//       {'key': 'bedrooms', 'label': 'Bedrooms', 'type': 'number', 'hint': 'e.g., 3', 'isRequired': true},
//       {'key': 'bathrooms', 'label': 'Bathrooms', 'type': 'number', 'hint': 'e.g., 2', 'isRequired': true},
//       {'key': 'sqft', 'label': 'Area (sq.ft)', 'type': 'number', 'hint': 'e.g., 2500', 'isRequired': true},
//       {'key': 'floors', 'label': 'Floors', 'type': 'number', 'hint': 'e.g., 2'},
//       {'key': 'furnishing', 'label': 'Furnishing', 'type': 'dropdown', 'options': 'furnishing'},
//       {'key': 'privatePool', 'label': 'Private Pool', 'type': 'boolean'},
//       {'key': 'garden', 'label': 'Garden', 'type': 'boolean'},
//       {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
//       {'key': 'security', 'label': '24/7 Security', 'type': 'boolean'},
//       {'key': 'backupGenerator', 'label': 'Power Backup', 'type': 'boolean'},
//       {'key': 'servantRoom', 'label': 'Servant Room', 'type': 'boolean'},
//     ],
//     'hotel': [
//       {'key': 'totalRooms', 'label': 'Total Rooms', 'type': 'number', 'hint': 'e.g., 30', 'isRequired': true},
//       {'key': 'roomTypes', 'label': 'Room Types', 'type': 'multiselect', 'options': 'roomTypes'},
//       {'key': 'pricePerNight', 'label': 'Price per Night (₹)', 'type': 'number', 'hint': 'e.g., 2500', 'isRequired': true},
//       {'key': 'starRating', 'label': 'Star Rating', 'type': 'dropdown', 'options': ['1 Star', '2 Star', '3 Star', '4 Star', '5 Star']},
//       {'key': 'restaurantAvailable', 'label': 'Restaurant', 'type': 'boolean'},
//       {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
//       {'key': 'wifi', 'label': 'WiFi', 'type': 'boolean'},
//       {'key': 'swimmingPool', 'label': 'Swimming Pool', 'type': 'boolean'},
//       {'key': 'gym', 'label': 'Gym', 'type': 'boolean'},
//       {'key': 'spa', 'label': 'Spa', 'type': 'boolean'},
//       {'key': 'conferenceHall', 'label': 'Conference Hall', 'type': 'boolean'},
//       {'key': 'breakfastIncluded', 'label': 'Breakfast Included', 'type': 'boolean'},
//       {'key': 'checkInTime', 'label': 'Check-in Time', 'type': 'text', 'hint': 'e.g., 2:00 PM'},
//       {'key': 'checkOutTime', 'label': 'Check-out Time', 'type': 'text', 'hint': 'e.g., 11:00 AM'},
//     ],
//     'apartment': [
//       {'key': 'bedrooms', 'label': 'Bedrooms', 'type': 'number', 'hint': 'e.g., 2', 'isRequired': true},
//       {'key': 'bathrooms', 'label': 'Bathrooms', 'type': 'number', 'hint': 'e.g., 2', 'isRequired': true},
//       {'key': 'sqft', 'label': 'Area (sq.ft)', 'type': 'number', 'hint': 'e.g., 1200', 'isRequired': true},
//       {'key': 'floorNumber', 'label': 'Floor Number', 'type': 'number', 'hint': 'e.g., 5'},
//       {'key': 'totalFloors', 'label': 'Total Floors', 'type': 'number', 'hint': 'e.g., 10'},
//       {'key': 'furnishing', 'label': 'Furnishing', 'type': 'dropdown', 'options': 'furnishing'},
//       {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
//       {'key': 'balcony', 'label': 'Balcony', 'type': 'boolean'},
//       {'key': 'lift', 'label': 'Lift', 'type': 'boolean'},
//       {'key': 'gym', 'label': 'Gym', 'type': 'boolean'},
//       {'key': 'swimmingPool', 'label': 'Swimming Pool', 'type': 'boolean'},
//       {'key': 'clubhouse', 'label': 'Clubhouse', 'type': 'boolean'},
//       {'key': 'security', 'label': 'Security', 'type': 'boolean'},
//       {'key': 'maintenance', 'label': 'Maintenance (₹)', 'type': 'number', 'hint': 'e.g., 2000'},
//     ],
//     'farmhouse': [
//       {'key': 'landSize', 'label': 'Land Size', 'type': 'number', 'hint': 'Enter size', 'isRequired': true},
//       {'key': 'unit', 'label': 'Unit', 'type': 'dropdown', 'options': 'unit', 'isRequired': true},
//       {'key': 'bedrooms', 'label': 'Bedrooms', 'type': 'number', 'hint': 'e.g., 3', 'isRequired': true},
//       {'key': 'bathrooms', 'label': 'Bathrooms', 'type': 'number', 'hint': 'e.g., 2'},
//       {'key': 'farmHouseBuilt', 'label': 'Main House Built', 'type': 'boolean'},
//       {'key': 'waterSource', 'label': 'Water Source', 'type': 'dropdown', 'options': 'waterSource'},
//       {'key': 'electricityAvailable', 'label': 'Electricity', 'type': 'boolean'},
//       {'key': 'borewell', 'label': 'Borewell', 'type': 'boolean'},
//       {'key': 'swimmingPool', 'label': 'Swimming Pool', 'type': 'boolean'},
//       {'key': 'garden', 'label': 'Garden', 'type': 'boolean'},
//       {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
//       {'key': 'crops', 'label': 'Crops Grown', 'type': 'text', 'hint': 'e.g., Rice, Sugarcane'},
//       {'key': 'animals', 'label': 'Animals', 'type': 'text', 'hint': 'e.g., Cows, Goats'},
//     ],
//     'goldshop': [
//       {'key': 'shopName', 'label': 'Shop Name', 'type': 'text', 'hint': 'e.g., Sri Lakshmi Gold Palace', 'isRequired': true},
//       {'key': 'establishedYear', 'label': 'Established Year', 'type': 'number', 'hint': 'e.g., 2010'},
//       {'key': 'services', 'label': 'Services Offered', 'type': 'multiselect', 'options': 'serviceType'},
//       {'key': 'certified', 'label': 'BIS Certified', 'type': 'boolean'},
//       {'key': 'hallmarkAvailable', 'label': 'Hallmark Jewellery', 'type': 'boolean'},
//       {'key': 'exchangeAvailable', 'label': 'Exchange Available', 'type': 'boolean'},
//       {'key': 'customDesign', 'label': 'Custom Design', 'type': 'boolean'},
//       {'key': 'repairsService', 'label': 'Repairs Service', 'type': 'boolean'},
//       {'key': 'goldRate', 'label': 'Today\'s Gold Rate (per gram)', 'type': 'number', 'hint': 'e.g., 5200'},
//       {'key': 'silverRate', 'label': 'Today\'s Silver Rate (per gram)', 'type': 'number', 'hint': 'e.g., 65'},
//       {'key': 'makingCharge', 'label': 'Making Charge (per gram)', 'type': 'number', 'hint': 'e.g., 450'},
//       {'key': 'schemesAvailable', 'label': 'Monthly Schemes', 'type': 'boolean'},
//       {'key': 'parking', 'label': 'Customer Parking', 'type': 'boolean'},
//       {'key': 'security', 'label': 'Security', 'type': 'boolean'},
//       {'key': 'workingHours', 'label': 'Working Hours', 'type': 'text', 'hint': 'e.g., 10:00 AM - 9:00 PM'},
//       {'key': 'workingDays', 'label': 'Working Days', 'type': 'dropdown', 'options': 'workingDays'},
//     ],
//     'company': [
//       {'key': 'companyName', 'label': 'Company/Startup Name', 'type': 'text', 'hint': 'e.g., TechInnovate Solutions', 'isRequired': true},
//       {'key': 'businessType', 'label': 'Business Type', 'type': 'dropdown', 'options': 'businessType', 'isRequired': true},
//       {'key': 'industry', 'label': 'Industry', 'type': 'text', 'hint': 'e.g., Mobile App Development', 'isRequired': true},
//       {'key': 'foundedYear', 'label': 'Founded Year', 'type': 'number', 'hint': 'e.g., 2020'},
//       {'key': 'companySize', 'label': 'Company Size', 'type': 'dropdown', 'options': 'companySize'},
//       {'key': 'services', 'label': 'Services Offered', 'type': 'text', 'hint': 'e.g., App Development, UI/UX Design', 'isRequired': true},
//       {'key': 'technologies', 'label': 'Technologies', 'type': 'text', 'hint': 'e.g., Flutter, React, Node.js'},
//       {'key': 'portfolio', 'label': 'Portfolio/Projects', 'type': 'text', 'hint': 'e.g., 50+ apps delivered'},
//       {'key': 'clients', 'label': 'Notable Clients', 'type': 'text', 'hint': 'e.g., Startup Name, Enterprise Name'},
//       {'key': 'officeSpace', 'label': 'Office Space (sq.ft)', 'type': 'number', 'hint': 'e.g., 1500'},
//       {'key': 'seatingCapacity', 'label': 'Seating Capacity', 'type': 'number', 'hint': 'e.g., 30'},
//       {'key': 'meetingRooms', 'label': 'Meeting Rooms', 'type': 'number', 'hint': 'e.g., 2'},
//       {'key': 'amenities', 'label': 'Amenities', 'type': 'multiselect', 'options': 'amenities'},
//       {'key': 'wifi', 'label': 'WiFi Available', 'type': 'boolean'},
//       {'key': 'parking', 'label': 'Parking Available', 'type': 'boolean'},
//       {'key': 'cafeteria', 'label': 'Cafeteria', 'type': 'boolean'},
//       {'key': 'powerBackup', 'label': 'Power Backup', 'type': 'boolean'},
//       {'key': 'workingHours', 'label': 'Working Hours', 'type': 'text', 'hint': 'e.g., 9:00 AM - 6:00 PM'},
//       {'key': 'workingDays', 'label': 'Working Days', 'type': 'dropdown', 'options': 'workingDays'},
//       {'key': 'remoteWork', 'label': 'Remote Work Options', 'type': 'boolean'},
//       {'key': 'hiring', 'label': 'Currently Hiring', 'type': 'boolean'},
//     ],
//   };

//   bool get _isEditing => widget.productToEdit != null;

//   @override
//   void initState() {
//     super.initState();
//     fetchCategories();
//     _addFeatureField();
    
//     if (_isEditing) {
//       _loadProductData();
//     }
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _addressController.dispose();
//     _contactNumberController.dispose();
//     _emailController.dispose();
//     _websiteController.dispose();
//     _latitudeController.dispose();
//     _longitudeController.dispose();
    
//     for (var controller in attributeControllers.values) {
//       controller.dispose();
//     }
    
//     for (var controller in _featureNameControllers) {
//       controller.dispose();
//     }
    
//     super.dispose();
//   }

//   void _loadProductData() {
//     final product = widget.productToEdit!;
    
//     _productId = product['_id']?.toString();
//     _titleController.text = product['name']?.toString() ?? '';
//     _descriptionController.text = product['description']?.toString() ?? '';
//     _addressController.text = product['address']?.toString() ?? '';
//     _contactNumberController.text = product['contactNumber']?.toString() ?? '';
//     _emailController.text = product['email']?.toString() ?? '';
//     _websiteController.text = product['website']?.toString() ?? '';
    
//     // Parse location
//     if (product['location'] != null) {
//       final location = product['location'];
//       if (location['coordinates'] != null && location['coordinates'].length >= 2) {
//         _longitudeController.text = location['coordinates'][0].toString();
//         _latitudeController.text = location['coordinates'][1].toString();
//       }
//     }
    
//     // Load existing images
//     if (product['images'] != null) {
//       _existingImages = List<String>.from(product['images']);
//     }
    
//     // Parse attributes
//     Map<String, dynamic> parsedAttributes = {};
//     if (product['attributes'] is String) {
//       try {
//         parsedAttributes = json.decode(product['attributes']);
//       } catch (e) {
//         parsedAttributes = {};
//       }
//     } else if (product['attributes'] is Map) {
//       parsedAttributes = Map<String, dynamic>.from(product['attributes']);
//     }
    
//     // Load features
//     if (product['features'] != null && product['features'] is List) {
//       final features = product['features'] as List;
//       for (var i = 0; i < features.length; i++) {
//         final feature = features[i];
//         if (i >= _featureNameControllers.length) {
//           _addFeatureField();
//         }
//         _featureNameControllers[i].text = feature['name']?.toString() ?? '';
//         if (feature['image'] != null && feature['image'].toString().isNotEmpty) {
//           _existingFeatureImages.add(feature['image'].toString());
//           _existingFeatureNames.add(feature['name']?.toString() ?? '');
//         }
//       }
//     }
    
//     // Set category
//     if (product['category'] != null) {
//       if (product['category'] is Map) {
//         selectedCategoryId = product['category']['_id']?.toString();
//         selectedCategoryName = product['category']['name']?.toString();
//       } else {
//         selectedCategoryId = product['category'].toString();
//       }
//     }
    
//     // Store attributes for later initialization
//     Future.delayed(Duration.zero, () {
//       if (selectedCategoryName != null) {
//         _initializeAttributeFields(selectedCategoryName!);
        
//         // Set attribute values after controllers are created
//         parsedAttributes.forEach((key, value) {
//           if (attributeControllers.containsKey(key)) {
//             if (value is num || value is String) {
//               attributeControllers[key]?.text = value.toString();
//             }
//           } else if (booleanAttributes.containsKey(key)) {
//             booleanAttributes[key] = value == true;
//           } else if (dropdownAttributes.containsKey(key)) {
//             dropdownAttributes[key] = value.toString();
//           } else if (attributeValues.containsKey(key) && attributeValues[key]['type'] == 'multiselect') {
//             if (value is List) {
//               multiSelectValues[key] = List<String>.from(value.map((e) => e.toString()));
//             }
//           }
//         });
//       }
//     });
//   }

//   Future<void> fetchCategories() async {
//     setState(() {
//       isLoadingCategories = true;
//     });

//     try {
//       final response = await http.get(
//         Uri.parse('${ApiConstants.baseUrl}/api/auth/getall-categories'),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['success'] == true) {
//           setState(() {
//             categories = List<Map<String, dynamic>>.from(
//               data['categories'].map((category) => {
//                 'id': category['_id']?.toString() ?? '',
//                 'name': category['name']?.toString() ?? '',
//                 'image': category['image']?.toString() ?? '',
//               }),
//             );
//             isLoadingCategories = false;
//           });
//         }
//       }
//     } catch (e) {
//       print("Category error $e");
//       setState(() {
//         isLoadingCategories = false;
//       });
      
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error loading categories: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   void _initializeAttributeFields(String categoryName) {
//     // Clear existing controllers
//     for (var controller in attributeControllers.values) {
//       controller.dispose();
//     }
//     attributeControllers.clear();
//     attributeValues.clear();
//     booleanAttributes.clear();
//     dropdownAttributes.clear();
//     multiSelectValues.clear();

//     // Add price field with dynamic label
//     String priceLabel = 'Price/Monthly Rent';
//     if (categoryName.toLowerCase().contains('gold')) {
//       priceLabel = 'Starting Price (₹)';
//     } else if (categoryName.toLowerCase().contains('company') || 
//                categoryName.toLowerCase().contains('startup') ||
//                categoryName.toLowerCase().contains('business')) {
//       priceLabel = 'Monthly Budget/Rent (₹)';
//     } else if (categoryName.toLowerCase().contains('hotel')) {
//       priceLabel = 'Price per Night (₹)';
//     }
//     _addAttributeField('price', priceLabel, 'Enter amount', isRequired: true, isNumber: true);

//     // Get category-specific attributes
//     final String lowerCategory = categoryName.toLowerCase();
//     List<Map<String, dynamic>>? attributes;

//     // Better category matching
//     if (lowerCategory.contains('villa')) {
//       attributes = categoryAttributes['villa'];
//     } else if (lowerCategory.contains('hotel')) {
//       attributes = categoryAttributes['hotel'];
//     } else if (lowerCategory.contains('apartment')) {
//       attributes = categoryAttributes['apartment'];
//     } else if (lowerCategory.contains('farm') || lowerCategory.contains('farmhouse')) {
//       attributes = categoryAttributes['farmhouse'];
//     } else if (lowerCategory.contains('gold') || lowerCategory.contains('jewel')) {
//       attributes = categoryAttributes['goldshop'];
//     } else if (lowerCategory.contains('company') || 
//                lowerCategory.contains('startup') || 
//                lowerCategory.contains('business') ||
//                lowerCategory.contains('corp')) {
//       attributes = categoryAttributes['company'];
//     } else {
//       // Default attributes
//       attributes = [
//         {'key': 'bedrooms', 'label': 'Bedrooms', 'type': 'number', 'hint': 'e.g., 2'},
//         {'key': 'bathrooms', 'label': 'Bathrooms', 'type': 'number', 'hint': 'e.g., 2'},
//         {'key': 'sqft', 'label': 'Area (sq.ft)', 'type': 'number', 'hint': 'e.g., 1200'},
//       ];
//     }

//     // Add all attributes
//     for (var attr in attributes!) {
//       final key = attr['key'];
//       final type = attr['type'];
//       final label = attr['label'];
//       final hint = attr['hint'] ?? 'Enter $label';
//       final isRequired = attr['isRequired'] ?? false;
//       final optionsKey = attr['options'];

//       switch (type) {
//         case 'number':
//           _addAttributeField(key, label, hint, isNumber: true, isRequired: isRequired);
//           break;
//         case 'text':
//           _addAttributeField(key, label, hint, isNumber: false, isRequired: isRequired);
//           break;
//         case 'boolean':
//           _addBooleanField(key, label);
//           break;
//         case 'dropdown':
//           List<String> options;
//           if (optionsKey is String) {
//             options = predefinedOptions[optionsKey] ?? [];
//           } else if (optionsKey is List) {
//             options = List<String>.from(optionsKey);
//           } else {
//             options = [];
//           }
//           _addDropdownField(key, label, options);
//           break;
//         case 'multiselect':
//           _addMultiSelectField(key, label, optionsKey);
//           break;
//       }
//     }

//     setState(() {});
//   }

//   void _addAttributeField(String key, String label, String hint, 
//       {bool isNumber = false, bool isRequired = false}) {
//     attributeControllers[key] = TextEditingController();
//     attributeValues[key] = {
//       'label': label,
//       'hint': hint,
//       'isNumber': isNumber,
//       'isRequired': isRequired,
//       'type': 'text',
//     };
//   }

//   void _addBooleanField(String key, String label) {
//     booleanAttributes[key] = false;
//     attributeValues[key] = {
//       'label': label,
//       'type': 'boolean',
//     };
//   }

//   void _addDropdownField(String key, String label, List<String> options) {
//     if (options.isNotEmpty) {
//       dropdownAttributes[key] = options.first;
//     }
//     dropdownOptions[key] = options;
//     attributeValues[key] = {
//       'label': label,
//       'type': 'dropdown',
//       'options': options,
//     };
//   }

//   void _addMultiSelectField(String key, String label, dynamic optionsKey) {
//     List<String> options = [];
//     if (optionsKey is String) {
//       options = predefinedOptions[optionsKey] ?? [];
//     } else if (optionsKey is List) {
//       options = List<String>.from(optionsKey);
//     }
    
//     multiSelectValues[key] = [];
//     attributeValues[key] = {
//       'label': label,
//       'type': 'multiselect',
//       'options': options,
//     };
//   }

//   void _addFeatureField() {
//     _featureNameControllers.add(TextEditingController());
//     setState(() {});
//   }

//   void _removeFeatureField(int index) {
//     if (_featureNameControllers.length > 1) {
//       _featureNameControllers[index].dispose();
//       _featureNameControllers.removeAt(index);
//       if (index < _featureImages.length) {
//         _featureImages.removeAt(index);
//       }
//       if (index < _existingFeatureImages.length) {
//         _existingFeatureImages.removeAt(index);
//       }
//       if (index < _existingFeatureNames.length) {
//         _existingFeatureNames.removeAt(index);
//       }
//       setState(() {});
//     }
//   }

//   Future<void> _pickFeatureImage(int index) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 80,
//         maxWidth: 1080,
//         maxHeight: 1080,
//       );

//       if (pickedFile != null) {
//         setState(() {
//           while (_featureImages.length <= index) {
//             _featureImages.add(File(''));
//           }
//           _featureImages[index] = File(pickedFile.path);
//           // Remove existing image if new one is picked
//           if (index < _existingFeatureImages.length) {
//             _existingFeatureImages[index] = '';
//           }
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking image: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _pickImages() async {
//     try {
//       final List<XFile> pickedFiles = await _picker.pickMultiImage(
//         imageQuality: 80,
//         maxWidth: 1080,
//         maxHeight: 1080,
//       );

//       if (pickedFiles.isNotEmpty) {
//         setState(() {
//           _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error picking images: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   Future<void> _takePhoto() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 80,
//         maxWidth: 1080,
//         maxHeight: 1080,
//       );

//       if (pickedFile != null) {
//         setState(() {
//           _selectedImages.add(File(pickedFile.path));
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error taking photo: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }

//   void _removeImage(int index) {
//     setState(() {
//       if (index < _selectedImages.length) {
//         _selectedImages.removeAt(index);
//       } else {
//         final existingIndex = index - _selectedImages.length;
//         _existingImages.removeAt(existingIndex);
//       }
//     });
//   }

//   void _showImagePickerSheet() {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (_) => SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Add Photos",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black87,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                         _takePhoto();
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 18),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFE33629).withOpacity(0.06),
//                           borderRadius: BorderRadius.circular(14),
//                           border: Border.all(
//                             color: const Color(0xFFE33629).withOpacity(0.2),
//                           ),
//                         ),
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.camera_alt_outlined,
//                               size: 30,
//                               color: const Color(0xFFE33629),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               "Camera",
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                                 color: const Color(0xFFE33629),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 14),
//                   Expanded(
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                         _pickImages();
//                       },
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(vertical: 18),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(14),
//                           border: Border.all(color: Colors.grey.shade200),
//                         ),
//                         child: Column(
//                           children: [
//                             Icon(
//                               Icons.photo_library_outlined,
//                               size: 30,
//                               color: Colors.grey.shade600,
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               "Gallery",
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _getCurrentLocation() async {
//     setState(() {
//       _isGettingLocation = true;
//     });

//     try {
//       // For demo purposes, using static coordinates
//       // In real app, use Geolocator to get current position
//       const double latitude = 17.4065;
//       const double longitude = 78.4483;

//       _latitudeController.text = latitude.toString();
//       _longitudeController.text = longitude.toString();

//       // Get address from coordinates
//       List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
//         latitude,
//         longitude,
//       );

//       if (placemarks.isNotEmpty) {
//         final place = placemarks.first;
//         final address = [
//           place.street,
//           place.locality,
//           place.administrativeArea,
//           place.country,
//         ].where((e) => e != null && e.isNotEmpty).join(', ');
        
//         _addressController.text = address;
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error getting location: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         _isGettingLocation = false;
//       });
//     }
//   }

//   Map<String, dynamic> _buildAttributes() {
//     final Map<String, dynamic> attributes = {};

//     // Add price from controller
//     if (_priceController.text.isNotEmpty) {
//       attributes['price'] = num.tryParse(_priceController.text) ?? 0;
//     }

//     // Add all attribute fields
//     attributeControllers.forEach((key, controller) {
//       if (controller.text.isNotEmpty) {
//         if (attributeValues[key]?['isNumber'] == true) {
//           attributes[key] = num.tryParse(controller.text) ?? 0;
//         } else {
//           attributes[key] = controller.text;
//         }
//       }
//     });

//     // Add boolean fields
//     booleanAttributes.forEach((key, value) {
//       attributes[key] = value;
//     });

//     // Add dropdown fields
//     dropdownAttributes.forEach((key, value) {
//       attributes[key] = value;
//     });

//     // Add multi-select fields
//     multiSelectValues.forEach((key, value) {
//       if (value.isNotEmpty) {
//         attributes[key] = value;
//       }
//     });

//     return attributes;
//   }

//   Widget _buildMultiSelectField(String key, Map<String, dynamic> fieldData) {
//     final options = fieldData['options'] as List<String>;
//     final selectedValues = multiSelectValues[key] ?? [];

//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             fieldData['label'],
//             style: TextStyle(
//               fontSize: 12,
//               color: Colors.grey.shade600,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Wrap(
//               spacing: 8,
//               runSpacing: 8,
//               children: options.map((option) {
//                 final isSelected = selectedValues.contains(option);
//                 return FilterChip(
//                   label: Text(option),
//                   selected: isSelected,
//                   onSelected: (selected) {
//                     setState(() {
//                       if (selected) {
//                         selectedValues.add(option);
//                       } else {
//                         selectedValues.remove(option);
//                       }
//                       multiSelectValues[key] = selectedValues;
//                     });
//                   },
//                   backgroundColor: Colors.grey.shade100,
//                   selectedColor: const Color(0xFFE33629).withOpacity(0.2),
//                   checkmarkColor: const Color(0xFFE33629),
//                   labelStyle: TextStyle(
//                     color: isSelected ? const Color(0xFFE33629) : Colors.black87,
//                     fontSize: 12,
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _submitListing() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     if (selectedCategoryId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please select a category'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     if (_selectedImages.isEmpty && _existingImages.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please add at least one image'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     // Validate required attributes
//     bool hasRequiredFields = true;
//     attributeValues.forEach((key, value) {
//       if (value['isRequired'] == true) {
//         if (attributeControllers.containsKey(key) && attributeControllers[key]!.text.isEmpty) {
//           hasRequiredFields = false;
//         }
//         if (value['type'] == 'multiselect' && (multiSelectValues[key]?.isEmpty ?? true)) {
//           hasRequiredFields = false;
//         }
//       }
//     });

//     if (!hasRequiredFields) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please fill all required fields'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }

//     setState(() {
//       _isUploading = true;
//     });

//     try {
//       final userId = await SharedPrefHelper.getUserId();
//       if (userId == null) {
//         throw Exception('User not logged in');
//       }

//       final String method = _isEditing ? 'PUT' : 'POST';
//       final String url = _isEditing
//           ? '${ApiConstants.baseUrl}/api/update/$_productId'
//           : '${ApiConstants.baseUrl}/api/create/$selectedCategoryId';

//       var request = http.MultipartRequest(method, Uri.parse(url));

//       // Add basic fields
//       request.fields['userId'] = userId;
//       request.fields['name'] = _titleController.text;
//       request.fields['description'] = _descriptionController.text;
//       request.fields['address'] = _addressController.text;
//       request.fields['contactNumber'] = _contactNumberController.text;
//       request.fields['email'] = _emailController.text;
//       request.fields['website'] = _websiteController.text;
//       request.fields['latitude'] = _latitudeController.text.isNotEmpty 
//           ? _latitudeController.text 
//           : '17.4065';
//       request.fields['longitude'] = _longitudeController.text.isNotEmpty 
//           ? _longitudeController.text 
//           : '78.4483';
      
//       // Add attributes as JSON
//       request.fields['attributes'] = json.encode(_buildAttributes());

//       // Add existing images as JSON
//       if (_existingImages.isNotEmpty) {
//         request.fields['existingImages'] = json.encode(_existingImages);
//       }

//       // Add feature names
//       List<String> featureNames = [];
      
//       // Add existing feature names
//       if (_existingFeatureNames.isNotEmpty) {
//         featureNames.addAll(_existingFeatureNames);
//       }
      
//       // Add new feature names
//       if (_featureNameControllers.isNotEmpty) {
//         featureNames.addAll(
//           _featureNameControllers
//               .where((c) => c.text.isNotEmpty)
//               .map((c) => c.text)
//               .toList()
//         );
//       }
      
//       if (featureNames.isNotEmpty) {
//         request.fields['featureNames'] = json.encode(featureNames);
//       }

//       // Add existing feature images as JSON
//       if (_existingFeatureImages.isNotEmpty) {
//         request.fields['existingFeatureImages'] = json.encode(
//           _existingFeatureImages.where((img) => img.isNotEmpty).toList()
//         );
//       }

//       // Add new images
//       for (var i = 0; i < _selectedImages.length; i++) {
//         var file = await http.MultipartFile.fromPath(
//           'images',
//           _selectedImages[i].path,
//         );
//         request.files.add(file);
//       }

//       // Add new feature images
//       for (var i = 0; i < _featureImages.length; i++) {
//         if (_featureImages[i].path.isNotEmpty) {
//           var file = await http.MultipartFile.fromPath(
//             'featureImages',
//             _featureImages[i].path,
//           );
//           request.files.add(file);
//         }
//       }

//       // Send request
//       var response = await request.send();
//       var responseData = await response.stream.bytesToString();
//       var decodedData = json.decode(responseData);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(_isEditing ? 'Property updated successfully!' : 'Property listed successfully!'),
//               backgroundColor: Colors.green,
//             ),
//           );
          
//           // Return true to indicate success and refresh previous screen
//           Navigator.pop(context, true);
//         }
//       } else {
//         throw Exception(decodedData['message'] ?? 'Failed to ${_isEditing ? 'update' : 'list'} property');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Error: $e'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isUploading = false;
//         });
//       }
//     }
//   }

//   String _getExampleTitle(String? categoryName) {
//     if (categoryName == null) return 'Luxurious Villa';
    
//     switch(categoryName.toLowerCase()) {
//       case 'villa':
//         return '3 BHK Luxurious Villa with Pool';
//       case 'hotel':
//         return '5 Star Business Hotel in City Center';
//       case 'apartment':
//         return '2 BHK Modern Apartment';
//       case 'farmhouse':
//         return 'Spacious Farmhouse with Garden';
//       case 'goldshop':
//         return 'Sri Lakshmi Gold Palace - BIS Certified';
//       case 'company':
//         return 'TechInnovate Solutions - App Development Startup';
//       default:
//         return 'Luxurious Property';
//     }
//   }

//   String _getDescriptionHint(String? categoryName) {
//     if (categoryName == null) return 'Describe your property...';
    
//     switch(categoryName.toLowerCase()) {
//       case 'villa':
//         return 'Describe the villa, its amenities, location advantages, etc.';
//       case 'hotel':
//         return 'Describe your hotel, room types, amenities, services, nearby attractions...';
//       case 'apartment':
//         return 'Describe the apartment, facilities, society amenities, etc.';
//       case 'farmhouse':
//         return 'Describe the farmhouse, land, crops, facilities, etc.';
//       case 'goldshop':
//         return 'Describe your gold shop, services, special offers, certification, etc.';
//       case 'company':
//         return 'Describe your company, services, expertise, team, projects, etc.';
//       default:
//         return 'Describe your property...';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context, false),
//         ),
//         title: Text(
//           _isEditing ? "Edit Property" : "List Property",
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//             color: Colors.black87,
//           ),
//         ),
//         centerTitle: true,
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(1),
//           child: Divider(height: 1, color: Colors.grey.shade200),
//         ),
//       ),
//       body: _isUploading
//           ? Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const CircularProgressIndicator(),
//                   const SizedBox(height: 16),
//                   Text(_isEditing ? 'Updating property...' : 'Uploading property...'),
//                 ],
//               ),
//             )
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Category Selection Section
//                     const Text(
//                       "Select Category",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
                    
//                     isLoadingCategories
//                         ? _buildCategorySkeleton()
//                         : categories.isEmpty
//                             ? Center(
//                                 child: Column(
//                                   children: [
//                                     const Text('No categories found'),
//                                     TextButton(
//                                       onPressed: fetchCategories,
//                                       child: const Text('Retry'),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : Container(
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.grey.shade200),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: GridView.builder(
//                                   shrinkWrap: true,
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 4,
//                                     childAspectRatio: 0.9,
//                                     crossAxisSpacing: 8,
//                                     mainAxisSpacing: 8,
//                                   ),
//                                   padding: const EdgeInsets.all(12),
//                                   itemCount: categories.length,
//                                   itemBuilder: (context, index) {
//                                     final category = categories[index];
//                                     final isSelected = selectedCategoryId == category['id'];

//                                     return GestureDetector(
//                                       onTap: _isEditing 
//                                           ? null // Disable category change during edit
//                                           : () {
//                                               setState(() {
//                                                 selectedCategoryId = category['id'];
//                                                 selectedCategoryName = category['name'];
//                                               });
//                                               _initializeAttributeFields(category['name']);
//                                             },
//                                       child: Opacity(
//                                         opacity: _isEditing && !isSelected ? 0.5 : 1.0,
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             gradient: isSelected
//                                                 ? const LinearGradient(
//                                                     colors: [
//                                                       Color(0xFFE33629),
//                                                       Color(0xFF9D0D0D),
//                                                     ],
//                                                     begin: Alignment.topLeft,
//                                                     end: Alignment.bottomRight,
//                                                   )
//                                                 : null,
//                                             color: isSelected ? null : Colors.grey.shade50,
//                                             borderRadius: BorderRadius.circular(12),
//                                             border: Border.all(
//                                               color: isSelected
//                                                   ? const Color(0xFFE33629)
//                                                   : Colors.grey.shade200,
//                                             ),
//                                           ),
//                                           child: Column(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 width: 30,
//                                                 height: 30,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   shape: BoxShape.circle,
//                                                 ),
//                                                 child: category['image'] != null && category['image'].isNotEmpty
//                                                     ? Image.network(
//                                                         category['image'],
//                                                         width: 20,
//                                                         height: 20,
//                                                         errorBuilder: (_, __, ___) {
//                                                           return Icon(
//                                                             Icons.category,
//                                                             size: 20,
//                                                             color: isSelected
//                                                                 ? const Color(0xFFE33629)
//                                                                 : Colors.grey,
//                                                           );
//                                                         },
//                                                       )
//                                                     : Icon(
//                                                         Icons.category,
//                                                         size: 20,
//                                                         color: isSelected
//                                                             ? const Color(0xFFE33629)
//                                                             : Colors.grey,
//                                                       ),
//                                               ),
//                                               const SizedBox(height: 4),
//                                               Text(
//                                                 category['name']!.length > 6
//                                                     ? '${category['name']!.substring(0, 5)}.'
//                                                     : category['name']!,
//                                                 style: TextStyle(
//                                                   fontSize: 11,
//                                                   color: isSelected
//                                                       ? Colors.white
//                                                       : Colors.black87,
//                                                   fontWeight: FontWeight.w500,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),

//                     const SizedBox(height: 24),

//                     // Images Section
//                     const Text(
//                       "Property Photos",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
                    
//                     // Image Grid (Existing + New)
//                     if (_existingImages.isNotEmpty || _selectedImages.isNotEmpty)
//                       Container(
//                         height: 100,
//                         margin: const EdgeInsets.only(bottom: 12),
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: _existingImages.length + _selectedImages.length,
//                           itemBuilder: (context, index) {
//                             return Stack(
//                               children: [
//                                 Container(
//                                   width: 100,
//                                   height: 100,
//                                   margin: const EdgeInsets.only(right: 8),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     image: DecorationImage(
//                                       image: index < _selectedImages.length
//                                           ? FileImage(_selectedImages[index])
//                                           : NetworkImage(_existingImages[index - _selectedImages.length]) as ImageProvider,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 4,
//                                   right: 12,
//                                   child: GestureDetector(
//                                     onTap: () => _removeImage(index),
//                                     child: Container(
//                                       padding: const EdgeInsets.all(4),
//                                       decoration: const BoxDecoration(
//                                         color: Colors.red,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: const Icon(
//                                         Icons.close,
//                                         size: 12,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 if (index >= _selectedImages.length)
//                                   Positioned(
//                                     bottom: 4,
//                                     left: 4,
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: Colors.blue,
//                                         borderRadius: BorderRadius.circular(4),
//                                       ),
//                                       child: const Text(
//                                         'Existing',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 8,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
                    
//                     // Add Image Button
//                     GestureDetector(
//                       onTap: _showImagePickerSheet,
//                       child: Container(
//                         height: 80,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(
//                             color: Colors.grey.shade300,
//                             style: BorderStyle.solid,
//                           ),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.add_photo_alternate_outlined,
//                               size: 28,
//                               color: Colors.grey.shade400,
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               'Add Photos (${_selectedImages.length + _existingImages.length}/10)',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey.shade600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // Basic Details Section
//                     const Text(
//                       "Basic Details",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     // Title
//                     _buildTextField(
//                       controller: _titleController,
//                       label: selectedCategoryName != null 
//                           ? "${selectedCategoryName!} Title" 
//                           : "Property Title",
//                       hint: "e.g., ${_getExampleTitle(selectedCategoryName)}",
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter title';
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 16),

//                     // Description
//                     _buildTextField(
//                       controller: _descriptionController,
//                       label: "Description",
//                       hint: _getDescriptionHint(selectedCategoryName),
//                       maxLines: 4,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter description';
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 16),

//                     // Contact Information
//                     const Text(
//                       "Contact Information",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     // Contact Number
//                     _buildTextField(
//                       controller: _contactNumberController,
//                       label: "Contact Number",
//                       hint: "e.g., +91 9876543210",
//                       keyboardType: TextInputType.phone,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter contact number';
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 12),

//                     // Email
//                     _buildTextField(
//                       controller: _emailController,
//                       label: "Email",
//                       hint: "e.g., contact@example.com",
//                       keyboardType: TextInputType.emailAddress,
//                     ),

//                     const SizedBox(height: 12),

//                     // Website (optional)
//                     if (selectedCategoryName?.toLowerCase().contains('company') == true || 
//                         selectedCategoryName?.toLowerCase().contains('gold') == true)
//                       _buildTextField(
//                         controller: _websiteController,
//                         label: "Website",
//                         hint: "e.g., www.example.com",
//                       ),

//                     const SizedBox(height: 16),

//                     // Location Section
//                     const Text(
//                       "Location Details",
//                       style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 12),

//                     // Address
//                     _buildTextField(
//                       controller: _addressController,
//                       label: "Address",
//                       hint: "Enter full address",
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter address';
//                         }
//                         return null;
//                       },
//                     ),

//                     const SizedBox(height: 12),

//                     // Latitude & Longitude
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildTextField(
//                             controller: _latitudeController,
//                             label: "Latitude",
//                             hint: "e.g., 17.4065",
//                             keyboardType: TextInputType.number,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: _buildTextField(
//                             controller: _longitudeController,
//                             label: "Longitude",
//                             hint: "e.g., 78.4483",
//                             keyboardType: TextInputType.number,
//                           ),
//                         ),
//                       ],
//                     ),

//                     const SizedBox(height: 12),

//                     // Get Current Location Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: OutlinedButton.icon(
//                         onPressed: _isGettingLocation ? null : _getCurrentLocation,
//                         icon: _isGettingLocation
//                             ? const SizedBox(
//                                 width: 16,
//                                 height: 16,
//                                 child: CircularProgressIndicator(strokeWidth: 2),
//                               )
//                             : const Icon(Icons.my_location, size: 18),
//                         label: Text(_isGettingLocation ? 'Getting Location...' : 'Get Current Location'),
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: const Color(0xFFE33629),
//                           side: const BorderSide(color: Color(0xFFE33629)),
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 24),

//                     // Dynamic Attribute Fields based on Category
//                     if (selectedCategoryId != null) ...[
//                       const Text(
//                         "Property Details",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       // Price Field (always show)
//                       _buildTextField(
//                         controller: attributeControllers['price'] ?? TextEditingController(),
//                         label: attributeValues['price']?['label'] ?? 'Price',
//                         hint: attributeValues['price']?['hint'] ?? 'Enter price',
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Price is required';
//                           }
//                           return null;
//                         },
//                       ),

//                       const SizedBox(height: 16),

//                       // Dynamic Fields
//                       ...attributeValues.keys
//                           .where((key) => key != 'price')
//                           .map((key) {
//                             final fieldData = attributeValues[key];
//                             if (fieldData == null) return const SizedBox();

//                             switch (fieldData['type']) {
//                               case 'boolean':
//                                 return Container(
//                                   margin: const EdgeInsets.only(bottom: 16),
//                                   child: Row(
//                                     children: [
//                                       Checkbox(
//                                         value: booleanAttributes[key] ?? false,
//                                         onChanged: (value) {
//                                           setState(() {
//                                             booleanAttributes[key] = value ?? false;
//                                           });
//                                         },
//                                         activeColor: const Color(0xFFE33629),
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           fieldData['label'],
//                                           style: const TextStyle(fontSize: 14),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
                              
//                               case 'dropdown':
//                                 return Container(
//                                   margin: const EdgeInsets.only(bottom: 16),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         fieldData['label'],
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey.shade600,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 6),
//                                       Container(
//                                         padding: const EdgeInsets.symmetric(horizontal: 14),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: Colors.grey.shade300),
//                                           borderRadius: BorderRadius.circular(10),
//                                         ),
//                                         child: DropdownButton<String>(
//                                           value: dropdownAttributes.containsKey(key) 
//                                               ? dropdownAttributes[key] 
//                                               : (fieldData['options'] as List<String>?)?.isNotEmpty == true
//                                                   ? (fieldData['options'] as List<String>).first
//                                                   : null,
//                                           isExpanded: true,
//                                           underline: const SizedBox(),
//                                           icon: const Icon(Icons.arrow_drop_down),
//                                           onChanged: (value) {
//                                             setState(() {
//                                               dropdownAttributes[key] = value!;
//                                             });
//                                           },
//                                           items: (fieldData['options'] as List<String>)
//                                               .map((String item) {
//                                             return DropdownMenuItem<String>(
//                                               value: item,
//                                               child: Text(
//                                                 item,
//                                                 style: const TextStyle(fontSize: 14),
//                                               ),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
                              
//                               case 'multiselect':
//                                 return _buildMultiSelectField(key, fieldData);
                              
//                               default:
//                                 return Column(
//                                   children: [
//                                     _buildTextField(
//                                       controller: attributeControllers[key]!,
//                                       label: fieldData['label'],
//                                       hint: fieldData['hint'] ?? 'Enter ${fieldData['label']}',
//                                       keyboardType: fieldData['isNumber'] == true
//                                           ? TextInputType.number
//                                           : TextInputType.text,
//                                       validator: fieldData['isRequired'] == true
//                                           ? (value) {
//                                               if (value == null || value.isEmpty) {
//                                                 return '${fieldData['label']} is required';
//                                               }
//                                               return null;
//                                             }
//                                           : null,
//                                     ),
//                                     const SizedBox(height: 16),
//                                   ],
//                                 );
//                             }
//                           }).toList(),
//                     ],

//                     const SizedBox(height: 24),

//                     // Features Section (Optional)
//                     if (selectedCategoryId != null) ...[
//                       const Text(
//                         "Features (Optional)",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       // Existing Features
//                       if (_existingFeatureNames.isNotEmpty)
//                         ...List.generate(_existingFeatureNames.length, (index) {
//                           return Container(
//                             margin: const EdgeInsets.only(bottom: 12),
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey.shade200),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     _existingFeatureNames[index],
//                                     style: const TextStyle(fontSize: 14),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 if (_existingFeatureImages.isNotEmpty && 
//                                     index < _existingFeatureImages.length &&
//                                     _existingFeatureImages[index].isNotEmpty)
//                                   Container(
//                                     width: 50,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8),
//                                       image: DecorationImage(
//                                         image: NetworkImage(_existingFeatureImages[index]),
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                                 IconButton(
//                                   icon: const Icon(Icons.close, color: Colors.red),
//                                   onPressed: () {
//                                     setState(() {
//                                       _existingFeatureNames.removeAt(index);
//                                       if (index < _existingFeatureImages.length) {
//                                         _existingFeatureImages.removeAt(index);
//                                       }
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),

//                       // New Feature Fields
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: _featureNameControllers.length,
//                         itemBuilder: (context, index) {
//                           return Container(
//                             margin: const EdgeInsets.only(bottom: 12),
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey.shade200),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: TextFormField(
//                                         controller: _featureNameControllers[index],
//                                         decoration: InputDecoration(
//                                           labelText: 'Feature Name',
//                                           labelStyle: TextStyle(
//                                             fontSize: 12,
//                                             color: Colors.grey.shade600,
//                                           ),
//                                           hintText: _getFeatureHint(selectedCategoryName),
//                                           border: OutlineInputBorder(
//                                             borderRadius: BorderRadius.circular(8),
//                                           ),
//                                           contentPadding: const EdgeInsets.symmetric(
//                                             horizontal: 12,
//                                             vertical: 12,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 8),
//                                     GestureDetector(
//                                       onTap: () => _pickFeatureImage(index),
//                                       child: Container(
//                                         width: 50,
//                                         height: 50,
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey.shade100,
//                                           borderRadius: BorderRadius.circular(8),
//                                           border: Border.all(color: Colors.grey.shade300),
//                                           image: _featureImages.length > index && 
//                                                 _featureImages[index].path.isNotEmpty
//                                               ? DecorationImage(
//                                                   image: FileImage(_featureImages[index]),
//                                                   fit: BoxFit.cover,
//                                                 )
//                                               : null,
//                                         ),
//                                         child: _featureImages.length <= index || 
//                                                _featureImages[index].path.isEmpty
//                                             ? Icon(
//                                                 Icons.add_photo_alternate,
//                                                 size: 24,
//                                                 color: Colors.grey.shade400,
//                                               )
//                                             : null,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 if (_featureNameControllers.length > 1)
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: TextButton(
//                                       onPressed: () => _removeFeatureField(index),
//                                       child: const Text(
//                                         'Remove',
//                                         style: TextStyle(color: Colors.red),
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),

//                       // Add More Feature Button
//                       TextButton.icon(
//                         onPressed: _addFeatureField,
//                         icon: const Icon(Icons.add),
//                         label: const Text('Add Feature'),
//                         style: TextButton.styleFrom(
//                           foregroundColor: const Color(0xFFE33629),
//                         ),
//                       ),

//                       const SizedBox(height: 16),
//                     ],

//                     const SizedBox(height: 32),

//                     // Submit Button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: _submitListing,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFE33629),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Text(
//                           _isEditing ? "Update Property" : "List Property",
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   String _getFeatureHint(String? categoryName) {
//     if (categoryName == null) return 'e.g., Swimming Pool';
    
//     switch(categoryName.toLowerCase()) {
//       case 'villa':
//         return 'e.g., Private Pool, Garden';
//       case 'hotel':
//         return 'e.g., Rooftop Restaurant, Spa';
//       case 'apartment':
//         return 'e.g., Gym, Clubhouse';
//       case 'farmhouse':
//         return 'e.g., Organic Farming, Lake';
//       case 'goldshop':
//         return 'e.g., Custom Design, Free Hallmark';
//       case 'company':
//         return 'e.g., Free Consultation, 24/7 Support';
//       default:
//         return 'e.g., Special Feature';
//     }
//   }

//   Widget _buildCategorySkeleton() {
//     return Container(
//       height: 120,
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 4,
//           childAspectRatio: 0.9,
//           crossAxisSpacing: 8,
//           mainAxisSpacing: 8,
//         ),
//         itemCount: 8,
//         itemBuilder: (context, index) {
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(12),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     TextInputType keyboardType = TextInputType.text,
//     int maxLines = 1,
//     String? Function(String?)? validator,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: Colors.grey.shade600,
//           ),
//         ),
//         const SizedBox(height: 6),
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           maxLines: maxLines,
//           validator: validator,
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: TextStyle(
//               fontSize: 13,
//               color: Colors.grey.shade400,
//             ),
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 14,
//               vertical: 14,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: const BorderSide(color: Color(0xFFE33629)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // Price controller getter
//   TextEditingController get _priceController => 
//       attributeControllers.containsKey('price') 
//           ? attributeControllers['price']! 
//           : TextEditingController();
// }




































import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geocoding/geocoding.dart' as geocoding;

class Edit extends StatefulWidget {
  final Map<String, dynamic>? productToEdit;
  
  const Edit({
    super.key,
    this.productToEdit,
  });

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  // Dynamic Categories from API
  List<Map<String, dynamic>> categories = [];
  String? selectedCategoryId;
  String? selectedCategoryName;
  bool isLoadingCategories = true;

  // Form Controllers
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  
  // Location Controllers
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  bool _isGettingLocation = false;

  // Image Picker
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  List<String> _existingImages = [];
  bool _isUploading = false;

  // Feature Images & Names
  List<File> _featureImages = [];
  List<String> _existingFeatureImages = [];
  List<TextEditingController> _featureNameControllers = [];
  List<String> _existingFeatureNames = [];

  // ===== NEW: Portfolio Section (copied from SellScreen) =====
  List<Map<String, dynamic>> _portfolioItems = [];
  List<Map<String, dynamic>> _existingPortfolio = [];
  
  // ===== NEW: Previous Events Section (copied from SellScreen) =====
  List<Map<String, dynamic>> _previousEvents = [];
  List<Map<String, dynamic>> _existingEvents = [];

  // Dynamic Attributes Map
  Map<String, dynamic> attributeValues = {};
  Map<String, TextEditingController> attributeControllers = {};
  Map<String, bool> booleanAttributes = {};
  Map<String, String> dropdownAttributes = {};
  Map<String, List<String>> dropdownOptions = {};
  Map<String, List<String>> multiSelectValues = {};

  // Product ID for editing
  String? _productId;

  // Predefined dropdown options (copied from SellScreen)
  final Map<String, List<String>> predefinedOptions = {
    'unit': ['sqft', 'acres', 'sqm', 'yards'],
    'furnishing': ['Fully Furnished', 'Semi Furnished', 'Unfurnished'],
    'availability': ['Ready to Move', 'Under Construction', 'Upcoming'],
    'ownership': ['Freehold', 'Leasehold', 'Co-operative'],
    'waterSource': ['Borewell', 'Municipal', 'Well', 'Canal', 'Tanker'],
    'landType': ['Residential', 'Commercial', 'Agricultural', 'Industrial', 'Mixed Use'],
    'parking': ['Yes', 'No'],
    'roomTypes': ['Single', 'Double', 'Suite', 'Deluxe', 'Executive', 'Presidential'],
    'businessType': ['Startup', 'Small Business', 'Enterprise', 'Co-working', 'Freelance'],
    'serviceType': ['Gold Purchase', 'Gold Sale', 'Exchange', 'Custom Design', 'Repairs'],
    'companySize': ['1-10', '11-50', '51-200', '201-500', '500+'],
    'workingDays': ['Mon-Fri', 'Mon-Sat', 'All Days', 'Weekends Only'],
    'amenities': ['WiFi', 'Parking', 'Cafeteria', 'Conference Room', 'Security', 'Power Backup'],
    'industry': [
      'App Development',
      'Web Development',
      'Digital Marketing',
      'AI/ML',
      'Cloud Computing',
      'Cybersecurity',
      'Data Science',
      'Game Development',
      'IoT',
      'Blockchain'
    ]
  };

  // Category-specific attribute templates (copied from SellScreen)
  final Map<String, List<Map<String, dynamic>>> categoryAttributes = {
    'villa': [
      {'key': 'bedrooms', 'label': 'Bedrooms', 'type': 'number', 'hint': 'e.g., 3', 'isRequired': true},
      {'key': 'bathrooms', 'label': 'Bathrooms', 'type': 'number', 'hint': 'e.g., 2', 'isRequired': true},
      {'key': 'sqft', 'label': 'Area (sq.ft)', 'type': 'number', 'hint': 'e.g., 2500', 'isRequired': true},
      {'key': 'floors', 'label': 'Floors', 'type': 'number', 'hint': 'e.g., 2'},
      {'key': 'furnishing', 'label': 'Furnishing', 'type': 'dropdown', 'options': 'furnishing'},
      {'key': 'privatePool', 'label': 'Private Pool', 'type': 'boolean'},
      {'key': 'garden', 'label': 'Garden', 'type': 'boolean'},
      {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
      {'key': 'security', 'label': '24/7 Security', 'type': 'boolean'},
      {'key': 'backupGenerator', 'label': 'Power Backup', 'type': 'boolean'},
      {'key': 'servantRoom', 'label': 'Servant Room', 'type': 'boolean'},
    ],
    'hotel': [
      {'key': 'totalRooms', 'label': 'Total Rooms', 'type': 'number', 'hint': 'e.g., 30', 'isRequired': true},
      {'key': 'roomTypes', 'label': 'Room Types', 'type': 'multiselect', 'options': 'roomTypes'},
      {'key': 'pricePerNight', 'label': 'Price per Night (₹)', 'type': 'number', 'hint': 'e.g., 2500', 'isRequired': true},
      {'key': 'starRating', 'label': 'Star Rating', 'type': 'dropdown', 'options': ['1 Star', '2 Star', '3 Star', '4 Star', '5 Star']},
      {'key': 'restaurantAvailable', 'label': 'Restaurant', 'type': 'boolean'},
      {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
      {'key': 'wifi', 'label': 'WiFi', 'type': 'boolean'},
      {'key': 'swimmingPool', 'label': 'Swimming Pool', 'type': 'boolean'},
      {'key': 'gym', 'label': 'Gym', 'type': 'boolean'},
      {'key': 'spa', 'label': 'Spa', 'type': 'boolean'},
      {'key': 'conferenceHall', 'label': 'Conference Hall', 'type': 'boolean'},
      {'key': 'breakfastIncluded', 'label': 'Breakfast Included', 'type': 'boolean'},
      {'key': 'checkInTime', 'label': 'Check-in Time', 'type': 'text', 'hint': 'e.g., 2:00 PM'},
      {'key': 'checkOutTime', 'label': 'Check-out Time', 'type': 'text', 'hint': 'e.g., 11:00 AM'},
    ],
    'apartment': [
      {'key': 'bedrooms', 'label': 'Bedrooms', 'type': 'number', 'hint': 'e.g., 2', 'isRequired': true},
      {'key': 'bathrooms', 'label': 'Bathrooms', 'type': 'number', 'hint': 'e.g., 2', 'isRequired': true},
      {'key': 'sqft', 'label': 'Area (sq.ft)', 'type': 'number', 'hint': 'e.g., 1200', 'isRequired': true},
      {'key': 'floorNumber', 'label': 'Floor Number', 'type': 'number', 'hint': 'e.g., 5'},
      {'key': 'totalFloors', 'label': 'Total Floors', 'type': 'number', 'hint': 'e.g., 10'},
      {'key': 'furnishing', 'label': 'Furnishing', 'type': 'dropdown', 'options': 'furnishing'},
      {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
      {'key': 'balcony', 'label': 'Balcony', 'type': 'boolean'},
      {'key': 'lift', 'label': 'Lift', 'type': 'boolean'},
      {'key': 'gym', 'label': 'Gym', 'type': 'boolean'},
      {'key': 'swimmingPool', 'label': 'Swimming Pool', 'type': 'boolean'},
      {'key': 'clubhouse', 'label': 'Clubhouse', 'type': 'boolean'},
      {'key': 'security', 'label': 'Security', 'type': 'boolean'},
      {'key': 'maintenance', 'label': 'Maintenance (₹)', 'type': 'number', 'hint': 'e.g., 2000'},
    ],
    'farmhouse': [
      {'key': 'landSize', 'label': 'Land Size', 'type': 'number', 'hint': 'Enter size', 'isRequired': true},
      {'key': 'unit', 'label': 'Unit', 'type': 'dropdown', 'options': 'unit', 'isRequired': true},
      {'key': 'bedrooms', 'label': 'Bedrooms', 'type': 'number', 'hint': 'e.g., 3', 'isRequired': true},
      {'key': 'bathrooms', 'label': 'Bathrooms', 'type': 'number', 'hint': 'e.g., 2'},
      {'key': 'farmHouseBuilt', 'label': 'Main House Built', 'type': 'boolean'},
      {'key': 'waterSource', 'label': 'Water Source', 'type': 'dropdown', 'options': 'waterSource'},
      {'key': 'electricityAvailable', 'label': 'Electricity', 'type': 'boolean'},
      {'key': 'borewell', 'label': 'Borewell', 'type': 'boolean'},
      {'key': 'swimmingPool', 'label': 'Swimming Pool', 'type': 'boolean'},
      {'key': 'garden', 'label': 'Garden', 'type': 'boolean'},
      {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
      {'key': 'crops', 'label': 'Crops Grown', 'type': 'text', 'hint': 'e.g., Rice, Sugarcane'},
      {'key': 'animals', 'label': 'Animals', 'type': 'text', 'hint': 'e.g., Cows, Goats'},
    ],
    'gold shops': [
      {'key': 'shopName', 'label': 'Shop Name', 'type': 'text', 'hint': 'e.g., Sri Lakshmi Gold Palace', 'isRequired': true},
      {'key': 'establishedYear', 'label': 'Established Year', 'type': 'number', 'hint': 'e.g., 2010'},
      {'key': 'services', 'label': 'Services Offered', 'type': 'multiselect', 'options': 'serviceType'},
      {'key': 'certified', 'label': 'BIS Certified', 'type': 'boolean'},
      {'key': 'hallmarkAvailable', 'label': 'Hallmark Jewellery', 'type': 'boolean'},
      {'key': 'exchangeAvailable', 'label': 'Exchange Available', 'type': 'boolean'},
      {'key': 'customDesign', 'label': 'Custom Design', 'type': 'boolean'},
      {'key': 'repairsService', 'label': 'Repairs Service', 'type': 'boolean'},
      {'key': 'goldRate', 'label': 'Today\'s Gold Rate (per gram)', 'type': 'number', 'hint': 'e.g., 5200'},
      {'key': 'silverRate', 'label': 'Today\'s Silver Rate (per gram)', 'type': 'number', 'hint': 'e.g., 65'},
      {'key': 'makingCharge', 'label': 'Making Charge (per gram)', 'type': 'number', 'hint': 'e.g., 450'},
      {'key': 'schemesAvailable', 'label': 'Monthly Schemes', 'type': 'boolean'},
      {'key': 'parking', 'label': 'Customer Parking', 'type': 'boolean'},
      {'key': 'security', 'label': 'Security', 'type': 'boolean'},
      {'key': 'workingHours', 'label': 'Working Hours', 'type': 'text', 'hint': 'e.g., 10:00 AM - 9:00 PM'},
      {'key': 'workingDays', 'label': 'Working Days', 'type': 'dropdown', 'options': 'workingDays'},
    ],
    'companies': [
      {'key': 'businessType', 'label': 'Business Type', 'type': 'dropdown', 'options': 'businessType', 'isRequired': true},
      {'key': 'industry', 'label': 'Industry', 'type': 'dropdown', 'options': 'industry', 'isRequired': true},
      {'key': 'foundedYear', 'label': 'Founded Year', 'type': 'number', 'hint': 'e.g., 2020'},
      {'key': 'services', 'label': 'Services Offered', 'type': 'text', 'hint': 'e.g., App Development, UI/UX Design, Cloud Solutions', 'isRequired': true},
      {'key': 'technologies', 'label': 'Technologies', 'type': 'text', 'hint': 'e.g., Flutter, React, Node.js, Python'},
      {'key': 'clients', 'label': 'Notable Clients', 'type': 'text', 'hint': 'e.g., Startup Name, Enterprise Name'},
      {'key': 'officeSpace', 'label': 'Office Space (sq.ft)', 'type': 'number', 'hint': 'e.g., 1500'},
      {'key': 'meetingRooms', 'label': 'Meeting Rooms', 'type': 'number', 'hint': 'e.g., 2'},
      // {'key': 'amenities', 'label': 'Amenities', 'type': 'multiselect', 'options': 'amenities'},
      // {'key': 'wifi', 'label': 'WiFi Available', 'type': 'boolean'},
      // {'key': 'parking', 'label': 'Parking Available', 'type': 'boolean'},
      // {'key': 'cafeteria', 'label': 'Cafeteria', 'type': 'boolean'},
      // {'key': 'powerBackup', 'label': 'Power Backup', 'type': 'boolean'},
      {'key': 'workingHours', 'label': 'Working Hours', 'type': 'text', 'hint': 'e.g., 10:00 AM - 07:00 PM'},
      {'key': 'workingDays', 'label': 'Working Days', 'type': 'dropdown', 'options': 'workingDays'},
      {'key': 'remoteWork', 'label': 'Remote Work Options', 'type': 'boolean'},
      {'key': 'hiring', 'label': 'Currently Hiring', 'type': 'boolean'},
    ],
  };

  bool get _isEditing => widget.productToEdit != null;

  @override
  void initState() {
    super.initState();
    fetchCategories();
    _addFeatureField(); // Add one empty feature field
    
    if (_isEditing) {
      _loadProductData();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    
    for (var controller in attributeControllers.values) {
      controller.dispose();
    }
    
    for (var controller in _featureNameControllers) {
      controller.dispose();
    }
    
    // Dispose portfolio controllers
    for (var item in _portfolioItems) {
      (item['name'] as TextEditingController).dispose();
      (item['playStoreLink'] as TextEditingController).dispose();
      (item['appStoreLink'] as TextEditingController).dispose();
      (item['website'] as TextEditingController).dispose();
      (item['description'] as TextEditingController).dispose();
    }
    
    // Dispose events controllers
    for (var event in _previousEvents) {
      (event['title'] as TextEditingController).dispose();
      (event['description'] as TextEditingController).dispose();
      (event['location'] as TextEditingController).dispose();
    }
    
    super.dispose();
  }

  void _loadProductData() {
    final product = widget.productToEdit!;
    
    _productId = product['_id']?.toString();
    _titleController.text = product['name']?.toString() ?? '';
    _descriptionController.text = product['description']?.toString() ?? '';
    _addressController.text = product['address']?.toString() ?? '';
    
    // Load contact info
    if (product['contact'] != null) {
      final contact = product['contact'];
      _contactNumberController.text = contact['callNumber']?.toString() ?? '';
      _emailController.text = contact['email']?.toString() ?? '';
      _websiteController.text = contact['website']?.toString() ?? '';
    }
    
    // Parse location
    if (product['location'] != null) {
      final location = product['location'];
      if (location['coordinates'] != null && location['coordinates'].length >= 2) {
        _longitudeController.text = location['coordinates'][0].toString();
        _latitudeController.text = location['coordinates'][1].toString();
      }
    }
    
    // Load existing images
    if (product['images'] != null) {
      _existingImages = List<String>.from(product['images']);
    }
    
    // Parse attributes
    Map<String, dynamic> parsedAttributes = {};
    if (product['attributes'] != null) {
      if (product['attributes'] is String) {
        try {
          parsedAttributes = json.decode(product['attributes']);
        } catch (e) {
          parsedAttributes = {};
        }
      } else if (product['attributes'] is Map) {
        parsedAttributes = Map<String, dynamic>.from(product['attributes']);
      }
    }
    
    // Load features
    if (product['features'] != null && product['features'] is List) {
      final features = product['features'] as List;
      for (var i = 0; i < features.length; i++) {
        final feature = features[i];
        if (i >= _featureNameControllers.length) {
          _addFeatureField();
        }
        if (i < _featureNameControllers.length) {
          _featureNameControllers[i].text = feature['name']?.toString() ?? '';
        }
        if (feature['image'] != null && feature['image'].toString().isNotEmpty) {
          _existingFeatureImages.add(feature['image'].toString());
          _existingFeatureNames.add(feature['name']?.toString() ?? '');
        }
      }
    }
    
    // ===== NEW: Load portfolio items =====
    if (product['portfolio'] != null && product['portfolio'] is List) {
      final portfolio = product['portfolio'] as List;
      for (var item in portfolio) {
        _existingPortfolio.add({
          'logo': item['logo']?.toString() ?? '',
          'name': item['name']?.toString() ?? '',
          'playStoreLink': item['playStoreLink']?.toString() ?? '',
          'appStoreLink': item['appStoreLink']?.toString() ?? '',
          'website': item['website']?.toString() ?? '',
          'description': item['description']?.toString() ?? '',
          'id': item['_id']?.toString() ?? '',
        });
      }
    }
    
    // ===== NEW: Load previous events =====
    if (product['previousEvents'] != null && product['previousEvents'] is List) {
      final events = product['previousEvents'] as List;
      for (var event in events) {
        _existingEvents.add({
          'image': event['image']?.toString() ?? '',
          'title': event['title']?.toString() ?? '',
          'description': event['description']?.toString() ?? '',
          'location': event['location']?.toString() ?? '',
          'eventDate': event['eventDate'] != null ? DateTime.parse(event['eventDate']) : null,
          'id': event['_id']?.toString() ?? '',
        });
      }
    }
    
    // Set category
    if (product['category'] != null) {
      if (product['category'] is Map) {
        selectedCategoryId = product['category']['_id']?.toString();
        selectedCategoryName = product['category']['name']?.toString();
      } else {
        selectedCategoryId = product['category'].toString();
      }
    }
    
    // Store attributes for later initialization
    Future.delayed(Duration.zero, () {
      if (selectedCategoryName != null) {
        _initializeAttributeFields(selectedCategoryName!);
        
        // Set attribute values after controllers are created
        parsedAttributes.forEach((key, value) {
          if (attributeControllers.containsKey(key)) {
            if (value is num || value is String) {
              attributeControllers[key]?.text = value.toString();
            }
          } else if (booleanAttributes.containsKey(key)) {
            booleanAttributes[key] = value == true;
          } else if (dropdownAttributes.containsKey(key)) {
            dropdownAttributes[key] = value.toString();
          } else if (attributeValues.containsKey(key) && attributeValues[key]['type'] == 'multiselect') {
            if (value is List) {
              multiSelectValues[key] = List<String>.from(value.map((e) => e.toString()));
            }
          }
        });
      }
    });
  }

  Future<void> fetchCategories() async {
    setState(() {
      isLoadingCategories = true;
    });

    try {
      final response = await http.get(
        Uri.parse('${ApiConstants.baseUrl}/api/auth/getall-categories'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          setState(() {
            categories = List<Map<String, dynamic>>.from(
              data['categories'].map((category) => {
                'id': category['_id']?.toString() ?? '',
                'name': category['name']?.toString() ?? '',
                'image': category['image']?.toString() ?? '',
              }),
            );
            isLoadingCategories = false;
          });
        }
      }
    } catch (e) {
      print("Category error $e");
      setState(() {
        isLoadingCategories = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading categories: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _initializeAttributeFields(String categoryName) {
    // Clear existing controllers
    for (var controller in attributeControllers.values) {
      controller.dispose();
    }
    attributeControllers.clear();
    attributeValues.clear();
    booleanAttributes.clear();
    dropdownAttributes.clear();
    multiSelectValues.clear();

    // Add price field for all categories (as monthly rent/salary/price)
    String priceLabel = 'Price/Monthly Rent';
    if (categoryName.toLowerCase() == 'gold shops') {
      priceLabel = 'Starting Price (₹)';
    } else if (categoryName.toLowerCase() == 'companies') {
      priceLabel = 'Monthly Budget/Rent (₹)';
    } else if (categoryName.toLowerCase() == 'hotel') {
      priceLabel = 'Price per Night (₹)';
    }
    _addAttributeField('price', priceLabel, 'Enter amount', isRequired: true, isNumber: true);

    // Get category-specific attributes
    final String lowerCategory = categoryName.toLowerCase();
    List<Map<String, dynamic>>? attributes;

    // Map category names to our predefined keys
    if (lowerCategory.contains('villa')) {
      attributes = categoryAttributes['villa'];
    } else if (lowerCategory.contains('hotel')) {
      attributes = categoryAttributes['hotel'];
    } else if (lowerCategory.contains('apartment')) {
      attributes = categoryAttributes['apartment'];
    } else if (lowerCategory.contains('farm') || lowerCategory.contains('farmhouse')) {
      attributes = categoryAttributes['farmhouse'];
    } else if (lowerCategory.contains('gold') || lowerCategory.contains('shop')) {
      attributes = categoryAttributes['gold shops'];
    } else if (lowerCategory.contains('companies') || lowerCategory.contains('startup')) {
      attributes = categoryAttributes['companies'];
    } else {
      // Default attributes for unknown categories
      attributes = [
        {'key': 'bedrooms', 'label': 'Bedrooms', 'type': 'number', 'hint': 'e.g., 2'},
        {'key': 'bathrooms', 'label': 'Bathrooms', 'type': 'number', 'hint': 'e.g., 2'},
        {'key': 'sqft', 'label': 'Area (sq.ft)', 'type': 'number', 'hint': 'e.g., 1200'},
      ];
    }

    // Add all attributes
    for (var attr in attributes!) {
      final key = attr['key'];
      final type = attr['type'];
      final label = attr['label'];
      final hint = attr['hint'] ?? 'Enter $label';
      final isRequired = attr['isRequired'] ?? false;
      final optionsKey = attr['options'];

      switch (type) {
        case 'number':
          _addAttributeField(key, label, hint, isNumber: true, isRequired: isRequired);
          break;
        case 'text':
          _addAttributeField(key, label, hint, isNumber: false, isRequired: isRequired);
          break;
        case 'boolean':
          _addBooleanField(key, label);
          break;
        case 'dropdown':
          List<String> options;
          if (optionsKey is String) {
            options = predefinedOptions[optionsKey] ?? [];
          } else if (optionsKey is List) {
            options = List<String>.from(optionsKey);
          } else {
            options = [];
          }
          _addDropdownField(key, label, options);
          break;
        case 'multiselect':
          _addMultiSelectField(key, label, optionsKey);
          break;
      }
    }

    setState(() {});
  }

  void _addAttributeField(String key, String label, String hint, 
      {bool isNumber = false, bool isRequired = false}) {
    attributeControllers[key] = TextEditingController();
    attributeValues[key] = {
      'label': label,
      'hint': hint,
      'isNumber': isNumber,
      'isRequired': isRequired,
      'type': 'text',
    };
  }

  void _addBooleanField(String key, String label) {
    booleanAttributes[key] = false;
    attributeValues[key] = {
      'label': label,
      'type': 'boolean',
    };
  }

  void _addDropdownField(String key, String label, List<String> options) {
    if (options.isNotEmpty) {
      dropdownAttributes[key] = options.first;
    }
    dropdownOptions[key] = options;
    attributeValues[key] = {
      'label': label,
      'type': 'dropdown',
      'options': options,
    };
  }

  void _addMultiSelectField(String key, String label, dynamic optionsKey) {
    List<String> options = [];
    if (optionsKey is String) {
      options = predefinedOptions[optionsKey] ?? [];
    } else if (optionsKey is List) {
      options = List<String>.from(optionsKey);
    }
    
    multiSelectValues[key] = [];
    attributeValues[key] = {
      'label': label,
      'type': 'multiselect',
      'options': options,
    };
  }

  void _addFeatureField() {
    _featureNameControllers.add(TextEditingController());
    setState(() {});
  }

  void _removeFeatureField(int index) {
    if (_featureNameControllers.length > 1) {
      _featureNameControllers[index].dispose();
      _featureNameControllers.removeAt(index);
      if (index < _featureImages.length) {
        _featureImages.removeAt(index);
      }
      if (index < _existingFeatureImages.length) {
        _existingFeatureImages.removeAt(index);
      }
      if (index < _existingFeatureNames.length) {
        _existingFeatureNames.removeAt(index);
      }
      setState(() {});
    }
  }

  // ===== NEW: Portfolio Functions (copied from SellScreen) =====
  void _addPortfolioItem() {
    setState(() {
      _portfolioItems.add({
        'logo': null,
        'name': TextEditingController(),
        'playStoreLink': TextEditingController(),
        'appStoreLink': TextEditingController(),
        'website': TextEditingController(),
        'description': TextEditingController(),
      });
    });
  }

  void _removePortfolioItem(int index, {bool isExisting = false}) {
    if (isExisting) {
      setState(() {
        _existingPortfolio.removeAt(index);
      });
    } else {
      final item = _portfolioItems[index];
      (item['name'] as TextEditingController).dispose();
      (item['playStoreLink'] as TextEditingController).dispose();
      (item['appStoreLink'] as TextEditingController).dispose();
      (item['website'] as TextEditingController).dispose();
      (item['description'] as TextEditingController).dispose();
      
      setState(() {
        _portfolioItems.removeAt(index);
      });
    }
  }

  Future<void> _pickPortfolioLogo(int index, {bool isExisting = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 500,
        maxHeight: 500,
      );

      if (pickedFile != null) {
        setState(() {
          if (isExisting) {
            // For existing items, we'll mark that we're replacing the logo
            _existingPortfolio[index]['newLogo'] = File(pickedFile.path);
          } else {
            _portfolioItems[index]['logo'] = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking logo: $e'), backgroundColor: Colors.red),
      );
    }
  }

  // ===== NEW: Previous Events Functions (copied from SellScreen) =====
  void _addPreviousEvent() {
    setState(() {
      _previousEvents.add({
        'image': null,
        'title': TextEditingController(),
        'description': TextEditingController(),
        'eventDate': null,
        'location': TextEditingController(),
      });
    });
  }

  void _removePreviousEvent(int index, {bool isExisting = false}) {
    if (isExisting) {
      setState(() {
        _existingEvents.removeAt(index);
      });
    } else {
      final event = _previousEvents[index];
      (event['title'] as TextEditingController).dispose();
      (event['description'] as TextEditingController).dispose();
      (event['location'] as TextEditingController).dispose();
      
      setState(() {
        _previousEvents.removeAt(index);
      });
    }
  }

  Future<void> _pickEventImage(int index, {bool isExisting = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        setState(() {
          if (isExisting) {
            _existingEvents[index]['newImage'] = File(pickedFile.path);
          } else {
            _previousEvents[index]['image'] = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _selectEventDate(int index, {bool isExisting = false}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    
    if (picked != null) {
      setState(() {
        if (isExisting) {
          _existingEvents[index]['eventDate'] = picked;
        } else {
          _previousEvents[index]['eventDate'] = picked;
        }
      });
    }
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFiles.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(pickedFiles.map((file) => File(file.path)));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking images: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImages.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error taking photo: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      if (index < _selectedImages.length) {
        _selectedImages.removeAt(index);
      } else {
        final existingIndex = index - _selectedImages.length;
        _existingImages.removeAt(existingIndex);
      }
    });
  }

  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
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
                "Add Photos",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _takePhoto();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE33629).withOpacity(0.06),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE33629).withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 30,
                              color: const Color(0xFFE33629),
                            ),
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
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _pickImages();
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
                            Icon(
                              Icons.photo_library_outlined,
                              size: 30,
                              color: Colors.grey.shade600,
                            ),
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isGettingLocation = true;
    });

    try {
      // For demo purposes, using static coordinates
      // In real app, use Geolocator to get current position
      const double latitude = 17.4065;
      const double longitude = 78.4483;

      _latitudeController.text = latitude.toString();
      _longitudeController.text = longitude.toString();

      // Get address from coordinates
      List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(
        latitude,
        longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address = [
          place.street,
          place.locality,
          place.administrativeArea,
          place.country,
        ].where((e) => e != null && e.isNotEmpty).join(', ');
        
        _addressController.text = address;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error getting location: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  Map<String, dynamic> _buildAttributes() {
    final Map<String, dynamic> attributes = {};

    // Add price from controller
    if (_priceController.text.isNotEmpty) {
      attributes['price'] = num.tryParse(_priceController.text) ?? 0;
    }

    // Add all attribute fields
    attributeControllers.forEach((key, controller) {
      if (controller.text.isNotEmpty) {
        if (attributeValues[key]?['isNumber'] == true) {
          attributes[key] = num.tryParse(controller.text) ?? 0;
        } else {
          attributes[key] = controller.text;
        }
      }
    });

    // Add boolean fields
    booleanAttributes.forEach((key, value) {
      attributes[key] = value;
    });

    // Add dropdown fields
    dropdownAttributes.forEach((key, value) {
      attributes[key] = value;
    });

    // Add multi-select fields
    multiSelectValues.forEach((key, value) {
      if (value.isNotEmpty) {
        attributes[key] = value;
      }
    });

    return attributes;
  }

  // ===== NEW: Build portfolio items for API =====
  List<Map<String, dynamic>> _buildPortfolioData() {
    final List<Map<String, dynamic>> result = [];
    
    // Add new portfolio items
    for (var item in _portfolioItems) {
      final name = (item['name'] as TextEditingController?)?.text ?? '';
      if (name.isNotEmpty) {
        result.add({
          'name': name,
          'playStoreLink': (item['playStoreLink'] as TextEditingController?)?.text ?? '',
          'appStoreLink': (item['appStoreLink'] as TextEditingController?)?.text ?? '',
          'website': (item['website'] as TextEditingController?)?.text ?? '',
          'description': (item['description'] as TextEditingController?)?.text ?? '',
        });
      }
    }
    
    return result;
  }

  // ===== NEW: Build existing portfolio items for API =====
  List<Map<String, dynamic>> _buildExistingPortfolioData() {
    return _existingPortfolio.map((item) {
      return {
        'id': item['id'] ?? '',
        'name': item['name'] ?? '',
        'playStoreLink': item['playStoreLink'] ?? '',
        'appStoreLink': item['appStoreLink'] ?? '',
        'website': item['website'] ?? '',
        'description': item['description'] ?? '',
        'logo': item['logo'] ?? '',
      };
    }).toList();
  }

  // ===== NEW: Build previous events for API =====
  List<Map<String, dynamic>> _buildEventsData() {
    final List<Map<String, dynamic>> result = [];
    
    for (var event in _previousEvents) {
      final title = (event['title'] as TextEditingController?)?.text ?? '';
      if (title.isNotEmpty) {
        result.add({
          'title': title,
          'description': (event['description'] as TextEditingController?)?.text ?? '',
          'location': (event['location'] as TextEditingController?)?.text ?? '',
          'eventDate': event['eventDate']?.toIso8601String(),
        });
      }
    }
    
    return result;
  }

  // ===== NEW: Build existing events for API =====
  List<Map<String, dynamic>> _buildExistingEventsData() {
    return _existingEvents.map((event) {
      return {
        'id': event['id'] ?? '',
        'title': event['title'] ?? '',
        'description': event['description'] ?? '',
        'location': event['location'] ?? '',
        'eventDate': event['eventDate']?.toIso8601String(),
        'image': event['image'] ?? '',
      };
    }).toList();
  }

  Widget _buildMultiSelectField(String key, Map<String, dynamic> fieldData) {
    final options = fieldData['options'] as List<String>;
    final selectedValues = multiSelectValues[key] ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldData['label'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: options.map((option) {
                final isSelected = selectedValues.contains(option);
                return FilterChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedValues.add(option);
                      } else {
                        selectedValues.remove(option);
                      }
                      multiSelectValues[key] = selectedValues;
                    });
                  },
                  backgroundColor: Colors.grey.shade100,
                  selectedColor: const Color(0xFFE33629).withOpacity(0.2),
                  checkmarkColor: const Color(0xFFE33629),
                  labelStyle: TextStyle(
                    color: isSelected ? const Color(0xFFE33629) : Colors.black87,
                    fontSize: 12,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickFeatureImage(int index) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        setState(() {
          while (_featureImages.length <= index) {
            _featureImages.add(File(''));
          }
          _featureImages[index] = File(pickedFile.path);
          // Remove existing image if new one is picked
          if (index < _existingFeatureImages.length) {
            _existingFeatureImages[index] = '';
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _submitListing() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a category'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedImages.isEmpty && _existingImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate required attributes
    bool hasRequiredFields = true;
    attributeValues.forEach((key, value) {
      if (key == 'price' && 
          (selectedCategoryName?.toLowerCase() == 'gold shops' || 
           selectedCategoryName?.toLowerCase() == 'companies')) {
        return; // Skip price validation for these categories
      }
      
      if (value['isRequired'] == true) {
        if (attributeControllers.containsKey(key) && attributeControllers[key]!.text.isEmpty) {
          hasRequiredFields = false;
        }
        if (value['type'] == 'multiselect' && (multiSelectValues[key]?.isEmpty ?? true)) {
          hasRequiredFields = false;
        }
      }
    });

    if (!hasRequiredFields) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final userId = await SharedPrefHelper.getUserId();
      if (userId == null) {
        throw Exception('User not logged in');
      }

      final String method = _isEditing ? 'PUT' : 'POST';
      final String url = _isEditing
          ? '${ApiConstants.baseUrl}/api/$_productId'
          : '${ApiConstants.baseUrl}/api/create/$selectedCategoryId';

      var request = http.MultipartRequest(method, Uri.parse(url));

      // Add basic fields
      request.fields['userId'] = userId;
      request.fields['name'] = _titleController.text;
      request.fields['description'] = _descriptionController.text;
      request.fields['address'] = _addressController.text;
      request.fields['latitude'] = _latitudeController.text.isNotEmpty 
          ? _latitudeController.text 
          : '17.4065';
      request.fields['longitude'] = _longitudeController.text.isNotEmpty 
          ? _longitudeController.text 
          : '78.4483';

      // Create contact object
      Map<String, dynamic> contactInfo = {};
      if (_contactNumberController.text.isNotEmpty) {
        contactInfo['callNumber'] = _contactNumberController.text;
      }
      if (_emailController.text.isNotEmpty) {
        contactInfo['email'] = _emailController.text;
      }
      if (_websiteController.text.isNotEmpty) {
        contactInfo['website'] = _websiteController.text;
      }
      
      if (contactInfo.isNotEmpty) {
        request.fields['contact'] = json.encode(contactInfo);
      }
      
      // Add attributes as JSON
      final attributes = _buildAttributes();
      if (attributes.isNotEmpty) {
        request.fields['attributes'] = json.encode(attributes);
      }

      // ===== NEW: Add portfolio data =====
      final portfolioData = _buildPortfolioData();
      if (portfolioData.isNotEmpty) {
        request.fields['portfolio'] = json.encode(portfolioData);
      }
      
      // ===== NEW: Add existing portfolio data =====
      if (_existingPortfolio.isNotEmpty) {
        request.fields['existingPortfolio'] = json.encode(_buildExistingPortfolioData());
      }

      // ===== NEW: Add previous events data =====
      final eventsData = _buildEventsData();
      if (eventsData.isNotEmpty) {
        request.fields['previousEvents'] = json.encode(eventsData);
      }
      
      // ===== NEW: Add existing events data =====
      if (_existingEvents.isNotEmpty) {
        request.fields['existingEvents'] = json.encode(_buildExistingEventsData());
      }

      // Add feature names
      List<String> featureNames = [];
      
      // Add existing feature names
      if (_existingFeatureNames.isNotEmpty) {
        featureNames.addAll(_existingFeatureNames);
      }
      
      // Add new feature names
      if (_featureNameControllers.isNotEmpty) {
        featureNames.addAll(
          _featureNameControllers
              .where((c) => c.text.isNotEmpty)
              .map((c) => c.text)
              .toList()
        );
      }
      
      if (featureNames.isNotEmpty) {
        request.fields['featureNames'] = json.encode(featureNames);
      }

      // Add existing feature images as JSON
      if (_existingFeatureImages.isNotEmpty) {
        request.fields['existingFeatureImages'] = json.encode(
          _existingFeatureImages.where((img) => img.isNotEmpty).toList()
        );
      }

      // Add existing images as JSON
      if (_existingImages.isNotEmpty) {
        request.fields['existingImages'] = json.encode(_existingImages);
      }

      // Add main images
      for (var i = 0; i < _selectedImages.length; i++) {
        var file = await http.MultipartFile.fromPath(
          'images',
          _selectedImages[i].path,
        );
        request.files.add(file);
      }

      // Add feature images
      for (var i = 0; i < _featureImages.length; i++) {
        if (_featureImages[i].path.isNotEmpty) {
          var file = await http.MultipartFile.fromPath(
            'featureImages',
            _featureImages[i].path,
          );
          request.files.add(file);
        }
      }

      // ===== NEW: Add portfolio logos =====
      for (var i = 0; i < _portfolioItems.length; i++) {
        final logo = _portfolioItems[i]['logo'];
        if (logo != null && logo.path.isNotEmpty) {
          var file = await http.MultipartFile.fromPath(
            'portfolioLogos',
            logo.path,
          );
          request.files.add(file);
        }
      }
      
      // ===== NEW: Add updated logos for existing portfolio =====
      for (var i = 0; i < _existingPortfolio.length; i++) {
        final newLogo = _existingPortfolio[i]['newLogo'];
        if (newLogo != null && newLogo.path.isNotEmpty) {
          var file = await http.MultipartFile.fromPath(
            'portfolioLogos',
            newLogo.path,
          );
          request.files.add(file);
          // Add flag to indicate which portfolio item this logo belongs to
          request.fields['portfolioLogo_${_existingPortfolio[i]['id']}'] = 'update';
        }
      }

      // ===== NEW: Add event images =====
      for (var i = 0; i < _previousEvents.length; i++) {
        final image = _previousEvents[i]['image'];
        if (image != null && image.path.isNotEmpty) {
          var file = await http.MultipartFile.fromPath(
            'eventImages',
            image.path,
          );
          request.files.add(file);
        }
      }
      
      // ===== NEW: Add updated images for existing events =====
      for (var i = 0; i < _existingEvents.length; i++) {
        final newImage = _existingEvents[i]['newImage'];
        if (newImage != null && newImage.path.isNotEmpty) {
          var file = await http.MultipartFile.fromPath(
            'eventImages',
            newImage.path,
          );
          request.files.add(file);
          // Add flag to indicate which event this image belongs to
          request.fields['eventImage_${_existingEvents[i]['id']}'] = 'update';
        }
      }

      // Send request
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var decodedData = json.decode(responseData);

      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk$decodedData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_isEditing ? 'Property updated successfully!' : 'Property listed successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          
          // Return true to indicate success and refresh previous screen
          Navigator.pop(context, true);
        }
      } else {
        throw Exception(decodedData['message'] ?? 'Failed to ${_isEditing ? 'update' : 'list'} property');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  String _getExampleTitle(String? categoryName) {
    if (categoryName == null) return 'Luxurious Villa';
    
    switch(categoryName.toLowerCase()) {
      case 'villa':
        return '3 BHK Luxurious Villa with Pool';
      case 'hotel':
        return '5 Star Business Hotel in City Center';
      case 'apartment':
        return '2 BHK Modern Apartment';
      case 'farmhouse':
        return 'Spacious Farmhouse with Garden';
      case 'gold shops':
        return 'Sri Lakshmi Gold Palace - BIS Certified';
      case 'companies':
        return 'TechInnovate Solutions - App Development Startup';
      default:
        return 'Luxurious Property';
    }
  }

  String _getDescriptionHint(String? categoryName) {
    if (categoryName == null) return 'Describe your property...';
    
    switch(categoryName.toLowerCase()) {
      case 'villa':
        return 'Describe the villa, its amenities, location advantages, etc.';
      case 'hotel':
        return 'Describe your hotel, room types, amenities, services, nearby attractions...';
      case 'apartment':
        return 'Describe the apartment, facilities, society amenities, etc.';
      case 'farmhouse':
        return 'Describe the farmhouse, land, crops, facilities, etc.';
      case 'gold shops':
        return 'Describe your gold shop, services, special offers, certification, etc.';
      case 'companies':
        return 'Describe your companies, services, expertise, team, projects, etc.';
      default:
        return 'Describe your property...';
    }
  }

  String _getFeatureHint(String? categoryName) {
    if (categoryName == null) return 'e.g., Swimming Pool';
    
    switch(categoryName.toLowerCase()) {
      case 'villa':
        return 'e.g., Private Pool, Garden';
      case 'hotel':
        return 'e.g., Rooftop Restaurant, Spa';
      case 'apartment':
        return 'e.g., Gym, Clubhouse';
      case 'farmhouse':
        return 'e.g., Organic Farming, Lake';
      case 'gold shops':
        return 'e.g., Custom Design, Free Hallmark';
      case 'companies':
        return 'e.g., Free Consultation, 24/7 Support';
      default:
        return 'e.g., Special Feature';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text(
          _isEditing ? "Edit Property" : "List Property",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: _isUploading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(_isEditing ? 'Updating property...' : 'Uploading property...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Selection Section
                    const Text(
                      "Select Category",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    isLoadingCategories
                        ? _buildCategorySkeleton()
                        : categories.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    const Text('No categories found'),
                                    TextButton(
                                      onPressed: fetchCategories,
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade200),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 0.9,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    final category = categories[index];
                                    final isSelected = selectedCategoryId == category['id'];

                                    return GestureDetector(
                                      onTap: _isEditing 
                                          ? null // Disable category change during edit
                                          : () {
                                              setState(() {
                                                selectedCategoryId = category['id'];
                                                selectedCategoryName = category['name'];
                                              });
                                              _initializeAttributeFields(category['name']);
                                            },
                                      child: Opacity(
                                        opacity: _isEditing && !isSelected ? 0.5 : 1.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: isSelected
                                                ? const LinearGradient(
                                                    colors: [
                                                      Color(0xFFE33629),
                                                      Color(0xFF9D0D0D),
                                                    ],
                                                    begin: Alignment.topLeft,
                                                    end: Alignment.bottomRight,
                                                  )
                                                : null,
                                            color: isSelected ? null : Colors.grey.shade50,
                                            borderRadius: BorderRadius.circular(12),
                                            border: Border.all(
                                              color: isSelected
                                                  ? const Color(0xFFE33629)
                                                  : Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: category['image'] != null && category['image'].isNotEmpty
                                                    ? Image.network(
                                                        category['image'],
                                                        width: 20,
                                                        height: 20,
                                                        errorBuilder: (_, __, ___) {
                                                          return Icon(
                                                            Icons.category,
                                                            size: 20,
                                                            color: isSelected
                                                                ? const Color(0xFFE33629)
                                                                : Colors.grey,
                                                          );
                                                        },
                                                      )
                                                    : Icon(
                                                        Icons.category,
                                                        size: 20,
                                                        color: isSelected
                                                            ? const Color(0xFFE33629)
                                                            : Colors.grey,
                                                      ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                category['name']!.length > 6
                                                    ? '${category['name']!.substring(0, 5)}.'
                                                    : category['name']!,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black87,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),

                    const SizedBox(height: 24),

                    // Images Section
                    const Text(
                      "Property Photos",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Image Grid (Existing + New)
                    if (_existingImages.isNotEmpty || _selectedImages.isNotEmpty)
                      Container(
                        height: 100,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _existingImages.length + _selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: const EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(
                                      image: index < _selectedImages.length
                                          ? FileImage(_selectedImages[index])
                                          : NetworkImage(_existingImages[index - _selectedImages.length]) as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 12,
                                  child: GestureDetector(
                                    onTap: () => _removeImage(index),
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                if (index >= _selectedImages.length)
                                  Positioned(
                                    bottom: 4,
                                    left: 4,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        'Existing',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    
                    // Add Image Button
                    GestureDetector(
                      onTap: _showImagePickerSheet,
                      child: Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 28,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Add Photos (${_selectedImages.length + _existingImages.length}/10)',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Basic Details Section
                    const Text(
                      "Basic Details",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Title
                    _buildTextField(
                      controller: _titleController,
                      label: selectedCategoryName != null 
                          ? "${selectedCategoryName!} Title" 
                          : "Property Title",
                      hint: "e.g., ${_getExampleTitle(selectedCategoryName)}",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter title';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Description
                    _buildTextField(
                      controller: _descriptionController,
                      label: "Description",
                      hint: _getDescriptionHint(selectedCategoryName),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter description';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Contact Information
                    const Text(
                      "Contact Information",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Contact Number
                    _buildTextField(
                      controller: _contactNumberController,
                      label: "Contact Number",
                      hint: "e.g., +91 9876543210",
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter contact number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    // Email
                    _buildTextField(
                      controller: _emailController,
                      label: "Email",
                      hint: "e.g., contact@example.com",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 12),

                    // Website (optional)
                    if (selectedCategoryName?.toLowerCase() == 'companies' || 
                        selectedCategoryName?.toLowerCase() == 'gold shops')
                      _buildTextField(
                        controller: _websiteController,
                        label: "Website",
                        hint: "e.g., www.example.com",
                      ),

                    const SizedBox(height: 16),

                    // Location Section
                    const Text(
                      "Location Details",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Address
                    _buildTextField(
                      controller: _addressController,
                      label: "Address",
                      hint: "Enter full address",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter address';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    // Latitude & Longitude
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            controller: _latitudeController,
                            label: "Latitude",
                            hint: "e.g., 17.4065",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildTextField(
                            controller: _longitudeController,
                            label: "Longitude",
                            hint: "e.g., 78.4483",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Get Current Location Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _isGettingLocation ? null : _getCurrentLocation,
                        icon: _isGettingLocation
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.my_location, size: 18),
                        label: Text(_isGettingLocation ? 'Getting Location...' : 'Get Current Location'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFE33629),
                          side: const BorderSide(color: Color(0xFFE33629)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Dynamic Attribute Fields based on Category
                    if (selectedCategoryId != null) ...[
                      const Text(
                        "Property Details",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Price Field (always show)
                      if (selectedCategoryName?.toLowerCase() != 'companies' && 
                          selectedCategoryName?.toLowerCase() != 'gold shops') ...[
                        _buildTextField(
                          controller: attributeControllers['price'] ?? TextEditingController(),
                          label: attributeValues['price']?['label'] ?? 'Price',
                          hint: attributeValues['price']?['hint'] ?? 'Enter price',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Price is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Dynamic Fields
                      ...attributeValues.keys
                          .where((key) => key != 'price')
                          .map((key) {
                            final fieldData = attributeValues[key];
                            if (fieldData == null) return const SizedBox();

                            switch (fieldData['type']) {
                              case 'boolean':
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: booleanAttributes[key] ?? false,
                                        onChanged: (value) {
                                          setState(() {
                                            booleanAttributes[key] = value ?? false;
                                          });
                                        },
                                        activeColor: const Color(0xFFE33629),
                                      ),
                                      Expanded(
                                        child: Text(
                                          fieldData['label'],
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              
                              case 'dropdown':
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fieldData['label'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 14),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: DropdownButton<String>(
                                          value: dropdownAttributes.containsKey(key) 
                                              ? dropdownAttributes[key] 
                                              : (fieldData['options'] as List<String>?)?.isNotEmpty == true
                                                  ? (fieldData['options'] as List<String>).first
                                                  : null,
                                          isExpanded: true,
                                          underline: const SizedBox(),
                                          icon: const Icon(Icons.arrow_drop_down),
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownAttributes[key] = value!;
                                            });
                                          },
                                          items: (fieldData['options'] as List<String>)
                                              .map((String item) {
                                            return DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              
                              case 'multiselect':
                                return _buildMultiSelectField(key, fieldData);
                              
                              default:
                                return Column(
                                  children: [
                                    _buildTextField(
                                      controller: attributeControllers[key]!,
                                      label: fieldData['label'],
                                      hint: fieldData['hint'] ?? 'Enter ${fieldData['label']}',
                                      keyboardType: fieldData['isNumber'] == true
                                          ? TextInputType.number
                                          : TextInputType.text,
                                      validator: fieldData['isRequired'] == true
                                          ? (value) {
                                              if (value == null || value.isEmpty) {
                                                return '${fieldData['label']} is required';
                                              }
                                              return null;
                                            }
                                          : null,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                );
                            }
                          }).toList(),
                    ],

                    const SizedBox(height: 24),

                    // ===== NEW: Portfolio Section (copied from SellScreen) =====
                    if (selectedCategoryName?.toLowerCase() == 'companies') ...[
                      const Text(
                        "Portfolio (Optional)",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Existing Portfolio Items
                      if (_existingPortfolio.isNotEmpty)
                        ...List.generate(_existingPortfolio.length, (index) {
                          final item = _existingPortfolio[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.blue.shade50,
                            ),
                            child: Column(
                              children: [
                                // Logo
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _pickPortfolioLogo(index, isExisting: true),
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey.shade300),
                                          image: item['newLogo'] != null
                                              ? DecorationImage(
                                                  image: FileImage(item['newLogo']),
                                                  fit: BoxFit.cover,
                                                )
                                              : (item['logo'] != null && item['logo'].isNotEmpty
                                                  ? DecorationImage(
                                                      image: NetworkImage(item['logo']),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : null),
                                        ),
                                        child: item['logo'] == null && item['newLogo'] == null
                                            ? Icon(
                                                Icons.add_photo_alternate,
                                                size: 24,
                                                color: Colors.grey.shade400,
                                              )
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Logo',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item['newLogo'] != null 
                                                ? 'New logo selected' 
                                                : (item['logo'] != null && item['logo'].isNotEmpty
                                                    ? 'Existing logo'
                                                    : 'Tap to upload logo'),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: item['newLogo'] != null 
                                                  ? Colors.green 
                                                  : Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                
                                // Name
                                TextFormField(
                                  initialValue: item['name'],
                                  decoration: InputDecoration(
                                    labelText: 'Project/App Name',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'e.g., E-commerce App',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    item['name'] = value;
                                  },
                                ),
                                const SizedBox(height: 8),
                                
                                // Play Store Link
                                TextFormField(
                                  initialValue: item['playStoreLink'],
                                  decoration: InputDecoration(
                                    labelText: 'Play Store Link',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'https://play.google.com/...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    item['playStoreLink'] = value;
                                  },
                                ),
                                const SizedBox(height: 8),
                                
                                // App Store Link
                                TextFormField(
                                  initialValue: item['appStoreLink'],
                                  decoration: InputDecoration(
                                    labelText: 'App Store Link',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'https://apps.apple.com/...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    item['appStoreLink'] = value;
                                  },
                                ),
                                const SizedBox(height: 8),
                                
                                // Website
                                TextFormField(
                                  initialValue: item['website'],
                                  decoration: InputDecoration(
                                    labelText: 'Website',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'https://www.example.com',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    item['website'] = value;
                                  },
                                ),
                                const SizedBox(height: 8),
                                
                                // Description
                                TextFormField(
                                  initialValue: item['description'],
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'Brief description of the project',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    item['description'] = value;
                                  },
                                ),
                                
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () => _removePortfolioItem(index, isExisting: true),
                                    child: const Text(
                                      'Remove',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      
                      // New Portfolio Items
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _portfolioItems.length,
                        itemBuilder: (context, index) {
                          final item = _portfolioItems[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                // Logo
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _pickPortfolioLogo(index),
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey.shade300),
                                          image: item['logo'] != null
                                              ? DecorationImage(
                                                  image: FileImage(item['logo']),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                        child: item['logo'] == null
                                            ? Icon(
                                                Icons.add_photo_alternate,
                                                size: 24,
                                                color: Colors.grey.shade400,
                                              )
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Tap to upload logo',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                
                                // Name
                                TextFormField(
                                  controller: item['name'],
                                  decoration: InputDecoration(
                                    labelText: 'Project/App Name',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'e.g., E-commerce App',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Play Store Link
                                TextFormField(
                                  controller: item['playStoreLink'],
                                  decoration: InputDecoration(
                                    labelText: 'Play Store Link',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'https://play.google.com/...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // App Store Link
                                TextFormField(
                                  controller: item['appStoreLink'],
                                  decoration: InputDecoration(
                                    labelText: 'App Store Link',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'https://apps.apple.com/...',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Website
                                TextFormField(
                                  controller: item['website'],
                                  decoration: InputDecoration(
                                    labelText: 'Website',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'https://www.example.com',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Description
                                TextFormField(
                                  controller: item['description'],
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'Brief description of the project',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                
                                if (_portfolioItems.length > 1 || _existingPortfolio.isNotEmpty)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () => _removePortfolioItem(index),
                                      child: const Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                      
                      // Add Portfolio Button
                      TextButton.icon(
                        onPressed: _addPortfolioItem,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Portfolio Item'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFE33629),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                    ],

                    // ===== NEW: Previous Events Section (copied from SellScreen) =====
                    if (selectedCategoryName?.toLowerCase() == 'companies' || 
                        selectedCategoryName?.toLowerCase() == 'hotel' ||
                        selectedCategoryName?.toLowerCase() == 'gold shops') ...[
                      const Text(
                        "Previous Events (Optional)",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      // Existing Events
                      if (_existingEvents.isNotEmpty)
                        ...List.generate(_existingEvents.length, (index) {
                          final event = _existingEvents[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green.shade50,
                            ),
                            child: Column(
                              children: [
                                // Image
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _pickEventImage(index, isExisting: true),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey.shade300),
                                          image: event['newImage'] != null
                                              ? DecorationImage(
                                                  image: FileImage(event['newImage']),
                                                  fit: BoxFit.cover,
                                                )
                                              : (event['image'] != null && event['image'].isNotEmpty
                                                  ? DecorationImage(
                                                      image: NetworkImage(event['image']),
                                                      fit: BoxFit.cover,
                                                    )
                                                  : null),
                                        ),
                                        child: event['image'] == null && event['newImage'] == null
                                            ? Icon(
                                                Icons.add_photo_alternate,
                                                size: 24,
                                                color: Colors.grey.shade400,
                                              )
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Event Image',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            event['newImage'] != null 
                                                ? 'New image selected' 
                                                : (event['image'] != null && event['image'].isNotEmpty
                                                    ? 'Existing image'
                                                    : 'Tap to upload'),
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: event['newImage'] != null 
                                                  ? Colors.green 
                                                  : Colors.grey.shade500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                
                                // Title
                                TextFormField(
                                  initialValue: event['title'],
                                  decoration: InputDecoration(
                                    labelText: 'Event Title',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'e.g., Annual Tech Conference 2024',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    event['title'] = value;
                                  },
                                ),
                                const SizedBox(height: 8),
                                
                                // Description
                                TextFormField(
                                  initialValue: event['description'],
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'Brief description of the event',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    event['description'] = value;
                                  },
                                ),
                                const SizedBox(height: 8),
                                
                                // Location
                                TextFormField(
                                  initialValue: event['location'],
                                  decoration: InputDecoration(
                                    labelText: 'Event Location',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'e.g., Mumbai, India',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                  onChanged: (value) {
                                    event['location'] = value;
                                  },
                                ),
                                const SizedBox(height: 8),
                                
                                // Event Date
                                GestureDetector(
                                  onTap: () => _selectEventDate(index, isExisting: true),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 16,
                                          color: Colors.grey.shade600,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            event['eventDate'] != null
                                                ? '${event['eventDate'].day}/${event['eventDate'].month}/${event['eventDate'].year}'
                                                : 'Select Event Date',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: event['eventDate'] != null
                                                  ? Colors.black87
                                                  : Colors.grey.shade500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () => _removePreviousEvent(index, isExisting: true),
                                    child: const Text(
                                      'Remove',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      
                      // New Events
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _previousEvents.length,
                        itemBuilder: (context, index) {
                          final event = _previousEvents[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                // Image
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _pickEventImage(index),
                                      child: Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey.shade300),
                                          image: event['image'] != null
                                              ? DecorationImage(
                                                  image: FileImage(event['image']),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                        child: event['image'] == null
                                            ? Icon(
                                                Icons.add_photo_alternate,
                                                size: 24,
                                                color: Colors.grey.shade400,
                                              )
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'Tap to upload event image',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                
                                // Title
                                TextFormField(
                                  controller: event['title'],
                                  decoration: InputDecoration(
                                    labelText: 'Event Title',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'e.g., Annual Tech Conference 2024',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Description
                                TextFormField(
                                  controller: event['description'],
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'Brief description of the event',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Location
                                TextFormField(
                                  controller: event['location'],
                                  decoration: InputDecoration(
                                    labelText: 'Event Location',
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                    ),
                                    hintText: 'e.g., Mumbai, India',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                // Event Date
                                GestureDetector(
                                  onTap: () => _selectEventDate(index),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 16,
                                          color: Colors.grey.shade600,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            event['eventDate'] != null
                                                ? '${event['eventDate'].day}/${event['eventDate'].month}/${event['eventDate'].year}'
                                                : 'Select Event Date',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: event['eventDate'] != null
                                                  ? Colors.black87
                                                  : Colors.grey.shade500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                
                                if (_previousEvents.length > 1 || _existingEvents.isNotEmpty)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () => _removePreviousEvent(index),
                                      child: const Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                      
                      // Add Event Button
                      TextButton.icon(
                        onPressed: _addPreviousEvent,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Previous Event'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFE33629),
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                    ],

                    // Features Section (Optional)
                    if (selectedCategoryId != null) ...[
                      const Text(
                        "Features (Optional)",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Existing Features
                      if (_existingFeatureNames.isNotEmpty)
                        ...List.generate(_existingFeatureNames.length, (index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.orange.shade50,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _existingFeatureNames[index],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                if (_existingFeatureImages.isNotEmpty && 
                                    index < _existingFeatureImages.length &&
                                    _existingFeatureImages[index].isNotEmpty)
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(_existingFeatureImages[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _existingFeatureNames.removeAt(index);
                                      if (index < _existingFeatureImages.length) {
                                        _existingFeatureImages.removeAt(index);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        }),

                      // New Feature Fields
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _featureNameControllers.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: _featureNameControllers[index],
                                        decoration: InputDecoration(
                                          labelText: 'Feature Name',
                                          labelStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600,
                                          ),
                                          hintText: _getFeatureHint(selectedCategoryName),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () => _pickFeatureImage(index),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(color: Colors.grey.shade300),
                                          image: _featureImages.length > index && 
                                                _featureImages[index].path.isNotEmpty
                                              ? DecorationImage(
                                                  image: FileImage(_featureImages[index]),
                                                  fit: BoxFit.cover,
                                                )
                                              : null,
                                        ),
                                        child: _featureImages.length <= index || 
                                               _featureImages[index].path.isEmpty
                                            ? Icon(
                                                Icons.add_photo_alternate,
                                                size: 24,
                                                color: Colors.grey.shade400,
                                              )
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                                if (_featureNameControllers.length > 1)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () => _removeFeatureField(index),
                                      child: const Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),

                      // Add More Feature Button
                      TextButton.icon(
                        onPressed: _addFeatureField,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Feature'),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFFE33629),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],

                    const SizedBox(height: 32),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitListing,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE33629),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          _isEditing ? "Update Property" : "List Property",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildCategorySkeleton() {
    return Container(
      height: 120,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.9,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade400,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE33629)),
            ),
          ),
        ),
      ],
    );
  }

  // Price controller getter
  TextEditingController get _priceController => 
      attributeControllers.containsKey('price') 
          ? attributeControllers['price']! 
          : TextEditingController();
}










