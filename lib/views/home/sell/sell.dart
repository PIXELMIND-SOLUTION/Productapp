import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_app/constant/api_constant.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:http/http.dart' as http;
import 'package:product_app/views/home/navbar_screen.dart';
import 'dart:convert';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:product_app/views/widgets/app_back_control.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
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
  bool _isUploading = false;

  // Feature Images & Names
  List<File> _featureImages = [];
  List<TextEditingController> _featureNameControllers = [];

  // ===== NEW: Portfolio Section =====
  List<Map<String, dynamic>> _portfolioItems = [];

  // ===== NEW: Previous Events Section =====
  List<Map<String, dynamic>> _previousEvents = [];

  // Dynamic Attributes Map
  Map<String, dynamic> attributeValues = {};
  Map<String, TextEditingController> attributeControllers = {};
  Map<String, bool> booleanAttributes = {};
  Map<String, String> dropdownAttributes = {};
  Map<String, List<String>> dropdownOptions = {};

  // Predefined dropdown options
  final Map<String, List<String>> predefinedOptions = {
    'unit': ['sqft', 'acres', 'sqm', 'yards'],
    'furnishing': ['Fully Furnished', 'Semi Furnished', 'Unfurnished'],
    'availability': ['Ready to Move', 'Under Construction', 'Upcoming'],
    'ownership': ['Freehold', 'Leasehold', 'Co-operative'],
    'waterSource': ['Borewell', 'Municipal', 'Well', 'Canal', 'Tanker'],
    'landType': [
      'Residential',
      'Commercial',
      'Agricultural',
      'Industrial',
      'Mixed Use'
    ],
    'parking': ['Yes', 'No'],
    'roomTypes': [
      'Single',
      'Double',
      'Suite',
      'Deluxe',
      'Executive',
      'Presidential'
    ],
    'businessType': [
      'Startup',
      'Small Business',
      'Enterprise',
      'Co-working',
      'Freelance'
    ],
    'serviceType': [
      'Gold Purchase',
      'Gold Sale',
      'Exchange',
      'Custom Design',
      'Repairs'
    ],
    'workingDays': ['Mon-Fri', 'Mon-Sat', 'All Days', 'Weekends Only'],
    'amenities': [
      'WiFi',
      'Parking',
      'Cafeteria',
      'Conference Room',
      'Security',
      'Power Backup'
    ],
    'industry': ['App Development', 'Web Development', 'Digital Marketing']
  };

  // Category-specific attribute templates
  final Map<String, List<Map<String, dynamic>>> categoryAttributes = {
    'villa': [
      {
        'key': 'bedrooms',
        'label': 'Bedrooms',
        'type': 'number',
        'hint': 'e.g., 3',
        'isRequired': true
      },
      {
        'key': 'bathrooms',
        'label': 'Bathrooms',
        'type': 'number',
        'hint': 'e.g., 2',
        'isRequired': true
      },
      {
        'key': 'sqft',
        'label': 'Area (sq.ft)',
        'type': 'number',
        'hint': 'e.g., 2500',
        'isRequired': true
      },
      {'key': 'floors', 'label': 'Floors', 'type': 'number', 'hint': 'e.g., 2'},
      {
        'key': 'furnishing',
        'label': 'Furnishing',
        'type': 'dropdown',
        'options': 'furnishing'
      },
      {'key': 'privatePool', 'label': 'Private Pool', 'type': 'boolean'},
      {'key': 'garden', 'label': 'Garden', 'type': 'boolean'},
      {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
      {'key': 'security', 'label': '24/7 Security', 'type': 'boolean'},
      {'key': 'backupGenerator', 'label': 'Power Backup', 'type': 'boolean'},
      {'key': 'servantRoom', 'label': 'Servant Room', 'type': 'boolean'},
    ],
    'hotel': [
      {
        'key': 'totalRooms',
        'label': 'Total Rooms',
        'type': 'number',
        'hint': 'e.g., 30',
        'isRequired': true
      },
      {
        'key': 'roomTypes',
        'label': 'Room Types',
        'type': 'multiselect',
        'options': 'roomTypes'
      },
      {
        'key': 'pricePerNight',
        'label': 'Price per Night (₹)',
        'type': 'number',
        'hint': 'e.g., 2500',
        'isRequired': true
      },
      {
        'key': 'starRating',
        'label': 'Star Rating',
        'type': 'dropdown',
        'options': ['1 Star', '2 Star', '3 Star', '4 Star', '5 Star']
      },
      {'key': 'restaurantAvailable', 'label': 'Restaurant', 'type': 'boolean'},
      {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
      {'key': 'wifi', 'label': 'WiFi', 'type': 'boolean'},
      {'key': 'swimmingPool', 'label': 'Swimming Pool', 'type': 'boolean'},
      {'key': 'gym', 'label': 'Gym', 'type': 'boolean'},
      {'key': 'spa', 'label': 'Spa', 'type': 'boolean'},
      {'key': 'conferenceHall', 'label': 'Conference Hall', 'type': 'boolean'},
      {
        'key': 'breakfastIncluded',
        'label': 'Breakfast Included',
        'type': 'boolean'
      },
      {
        'key': 'checkInTime',
        'label': 'Check-in Time',
        'type': 'text',
        'hint': 'e.g., 2:00 PM'
      },
      {
        'key': 'checkOutTime',
        'label': 'Check-out Time',
        'type': 'text',
        'hint': 'e.g., 11:00 AM'
      },
    ],
    'apartment': [
      {
        'key': 'bedrooms',
        'label': 'Bedrooms',
        'type': 'number',
        'hint': 'e.g., 2',
        'isRequired': true
      },
      {
        'key': 'bathrooms',
        'label': 'Bathrooms',
        'type': 'number',
        'hint': 'e.g., 2',
        'isRequired': true
      },
      {
        'key': 'sqft',
        'label': 'Area (sq.ft)',
        'type': 'number',
        'hint': 'e.g., 1200',
        'isRequired': true
      },
      {
        'key': 'floorNumber',
        'label': 'Floor Number',
        'type': 'number',
        'hint': 'e.g., 5'
      },
      {
        'key': 'totalFloors',
        'label': 'Total Floors',
        'type': 'number',
        'hint': 'e.g., 10'
      },
      {
        'key': 'furnishing',
        'label': 'Furnishing',
        'type': 'dropdown',
        'options': 'furnishing'
      },
      {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
      {'key': 'balcony', 'label': 'Balcony', 'type': 'boolean'},
      {'key': 'lift', 'label': 'Lift', 'type': 'boolean'},
      {'key': 'gym', 'label': 'Gym', 'type': 'boolean'},
      {'key': 'swimmingPool', 'label': 'Swimming Pool', 'type': 'boolean'},
      {'key': 'clubhouse', 'label': 'Clubhouse', 'type': 'boolean'},
      {'key': 'security', 'label': 'Security', 'type': 'boolean'},
      {
        'key': 'maintenance',
        'label': 'Maintenance (₹)',
        'type': 'number',
        'hint': 'e.g., 2000'
      },
    ],
    'farmhouse': [
      {
        'key': 'landSize',
        'label': 'Land Size',
        'type': 'number',
        'hint': 'Enter size',
        'isRequired': true
      },
      {
        'key': 'unit',
        'label': 'Unit',
        'type': 'dropdown',
        'options': 'unit',
        'isRequired': true
      },
      {
        'key': 'bedrooms',
        'label': 'Bedrooms',
        'type': 'number',
        'hint': 'e.g., 3',
        'isRequired': true
      },
      {
        'key': 'bathrooms',
        'label': 'Bathrooms',
        'type': 'number',
        'hint': 'e.g., 2'
      },
      {'key': 'farmHouseBuilt', 'label': 'Main House Built', 'type': 'boolean'},
      {
        'key': 'waterSource',
        'label': 'Water Source',
        'type': 'dropdown',
        'options': 'waterSource'
      },
      {
        'key': 'electricityAvailable',
        'label': 'Electricity',
        'type': 'boolean'
      },
      {'key': 'borewell', 'label': 'Borewell', 'type': 'boolean'},
      {'key': 'swimmingPool', 'label': 'Swimming Pool', 'type': 'boolean'},
      {'key': 'garden', 'label': 'Garden', 'type': 'boolean'},
      {'key': 'parking', 'label': 'Parking', 'type': 'boolean'},
      {
        'key': 'crops',
        'label': 'Crops Grown',
        'type': 'text',
        'hint': 'e.g., Rice, Sugarcane'
      },
      {
        'key': 'animals',
        'label': 'Animals',
        'type': 'text',
        'hint': 'e.g., Cows, Goats'
      },
    ],
    'gold shops': [
      {
        'key': 'shopName',
        'label': 'Shop Name',
        'type': 'text',
        'hint': 'e.g., Sri Lakshmi Gold Palace',
        'isRequired': true
      },
      {
        'key': 'establishedYear',
        'label': 'Established Year',
        'type': 'number',
        'hint': 'e.g., 2010'
      },
      {
        'key': 'services',
        'label': 'Services Offered',
        'type': 'multiselect',
        'options': 'serviceType'
      },
      {'key': 'certified', 'label': 'BIS Certified', 'type': 'boolean'},
      {
        'key': 'hallmarkAvailable',
        'label': 'Hallmark Jewellery',
        'type': 'boolean'
      },
      {
        'key': 'exchangeAvailable',
        'label': 'Exchange Available',
        'type': 'boolean'
      },
      {'key': 'customDesign', 'label': 'Custom Design', 'type': 'boolean'},
      {'key': 'repairsService', 'label': 'Repairs Service', 'type': 'boolean'},
      {
        'key': 'goldRate',
        'label': 'Today\'s Gold Rate (per gram)',
        'type': 'number',
        'hint': 'e.g., 5200'
      },
      {
        'key': 'silverRate',
        'label': 'Today\'s Silver Rate (per gram)',
        'type': 'number',
        'hint': 'e.g., 65'
      },
      {
        'key': 'makingCharge',
        'label': 'Making Charge (per gram)',
        'type': 'number',
        'hint': 'e.g., 450'
      },
      {
        'key': 'schemesAvailable',
        'label': 'Monthly Schemes',
        'type': 'boolean'
      },
      {'key': 'parking', 'label': 'Customer Parking', 'type': 'boolean'},
      {'key': 'security', 'label': 'Security', 'type': 'boolean'},
      {
        'key': 'workingHours',
        'label': 'Working Hours',
        'type': 'text',
        'hint': 'e.g., 10:00 AM - 9:00 PM'
      },
      {
        'key': 'workingDays',
        'label': 'Working Days',
        'type': 'dropdown',
        'options': 'workingDays'
      },
    ],
    'companies': [
      //  {'key': 'businessType', 'label': 'Business Type', 'type': 'dropdown', 'options': 'businessType', 'isRequired': true},
      {
        'key': 'industry',
        'label': 'Industry',
        'type': 'dropdown',
        'options': 'industry',
        'isRequired': true
      },
      {
        'key': 'foundedYear',
        'label': 'Founded Year',
        'type': 'number',
        'hint': 'e.g., 2020'
      },
      {
        'key': 'services',
        'label': 'Services Offered',
        'type': 'text',
        'hint': 'e.g., App Development, UI/UX Design, Cloud Solutions',
        'isRequired': true
      },
      {
        'key': 'technologies',
        'label': 'Technologies',
        'type': 'text',
        'hint': 'e.g., Flutter, React, Node.js, Python'
      },
      {
        'key': 'clients',
        'label': 'Notable Clients',
        'type': 'text',
        'hint': 'e.g., Startup Name, Enterprise Name'
      },
      // {'key': 'officeSpace', 'label': 'Office Space (sq.ft)', 'type': 'number', 'hint': 'e.g., 1500'},
      // {'key': 'meetingRooms', 'label': 'Meeting Rooms', 'type': 'number', 'hint': 'e.g., 2'},
      // {'key': 'amenities', 'label': 'Amenities', 'type': 'multiselect', 'options': 'amenities'},
      // {'key': 'wifi', 'label': 'WiFi Available', 'type': 'boolean'},
      // {'key': 'parking', 'label': 'Parking Available', 'type': 'boolean'},
      // {'key': 'cafeteria', 'label': 'Cafeteria', 'type': 'boolean'},
      // {'key': 'powerBackup', 'label': 'Power Backup', 'type': 'boolean'},
      {
        'key': 'workingHours',
        'label': 'Working Hours',
        'type': 'text',
        'hint': 'e.g., 10:00 AM - 07:00 PM'
      },
      {
        'key': 'workingDays',
        'label': 'Working Days',
        'type': 'dropdown',
        'options': 'workingDays'
      },
      // {'key': 'remoteWork', 'label': 'Remote Work Options', 'type': 'boolean'},
      // {'key': 'hiring', 'label': 'Currently Hiring', 'type': 'boolean'},
    ],
  };

  @override
  void initState() {
    super.initState();
    fetchCategories();
    _addFeatureField();
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

    super.dispose();
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

    // Add price field for all categories (as monthly rent/salary/price)
    String priceLabel = 'Price/Monthly Rent';
    if (categoryName.toLowerCase() == 'gold shops') {
      priceLabel = 'Starting Price (₹)';
    } else if (categoryName.toLowerCase() == 'companies') {
      priceLabel = 'Monthly Budget/Rent (₹)';
    } else if (categoryName.toLowerCase() == 'hotel') {
      priceLabel = 'Price per Night (₹)';
    }
    _addAttributeField('price', priceLabel, 'Enter amount',
        isRequired: true, isNumber: true);

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
    } else if (lowerCategory.contains('farm') ||
        lowerCategory.contains('farmhouse')) {
      attributes = categoryAttributes['farmhouse'];
    } else if (lowerCategory.contains('gold') ||
        lowerCategory.contains('shop')) {
      attributes = categoryAttributes['gold shops'];
    } else if (lowerCategory.contains('companies') ||
        lowerCategory.contains('startup')) {
      attributes = categoryAttributes['companies'];
    } else {
      // Default attributes for unknown categories
      attributes = [
        {
          'key': 'bedrooms',
          'label': 'Bedrooms',
          'type': 'number',
          'hint': 'e.g., 2'
        },
        {
          'key': 'bathrooms',
          'label': 'Bathrooms',
          'type': 'number',
          'hint': 'e.g., 2'
        },
        {
          'key': 'sqft',
          'label': 'Area (sq.ft)',
          'type': 'number',
          'hint': 'e.g., 1200'
        },
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
          _addAttributeField(key, label, hint,
              isNumber: true, isRequired: isRequired);
          break;
        case 'text':
          _addAttributeField(key, label, hint,
              isNumber: false, isRequired: isRequired);
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

    attributeValues[key] = {
      'label': label,
      'type': 'multiselect',
      'options': options,
      'selected': <String>[],
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
      setState(() {});
    }
  }

  // ===== NEW: Portfolio Functions =====
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

  void _removePortfolioItem(int index) {
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

  Future<void> _pickPortfolioLogo(int index) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 500,
        maxHeight: 500,
      );

      if (pickedFile != null) {
        setState(() {
          _portfolioItems[index]['logo'] = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error picking logo: $e'),
            backgroundColor: Colors.red),
      );
    }
  }

  // ===== NEW: Previous Events Functions =====
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

  void _removePreviousEvent(int index) {
    final event = _previousEvents[index];
    (event['title'] as TextEditingController).dispose();
    (event['description'] as TextEditingController).dispose();
    (event['location'] as TextEditingController).dispose();

    setState(() {
      _previousEvents.removeAt(index);
    });
  }

  Future<void> _pickEventImage(int index) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        setState(() {
          _previousEvents[index]['image'] = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _selectEventDate(int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _previousEvents[index]['eventDate'] = picked;
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
      _selectedImages.removeAt(index);
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
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
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
    attributeValues.forEach((key, value) {
      if (value['type'] == 'multiselect' && value.containsKey('selected')) {
        final selected = value['selected'] as List<String>;
        if (selected.isNotEmpty) {
          attributes[key] = selected;
        }
      }
    });

    return attributes;
  }

  // ===== NEW: Build portfolio items for API =====
  List<Map<String, dynamic>> _buildPortfolioData() {
    return _portfolioItems.map((item) {
      return {
        'name': (item['name'] as TextEditingController?)?.text ?? '',
        'playStoreLink':
            (item['playStoreLink'] as TextEditingController?)?.text ?? '',
        'appStoreLink':
            (item['appStoreLink'] as TextEditingController?)?.text ?? '',
        'website': (item['website'] as TextEditingController?)?.text ?? '',
        'description':
            (item['description'] as TextEditingController?)?.text ?? '',
      };
    }).where((item) {
      final name = item['name'];
      return name != null && name is String && name.isNotEmpty;
    }).toList();
  }

  // ===== NEW: Build previous events for API =====
  List<Map<String, dynamic>> _buildEventsData() {
    return _previousEvents
        .map((event) {
          return {
            'title': (event['title'] as TextEditingController).text,
            'description': (event['description'] as TextEditingController).text,
            'location': (event['location'] as TextEditingController).text,
            'eventDate': event['eventDate']?.toIso8601String(),
          };
        })
        .where((event) => event['title'].isNotEmpty)
        .toList();
  }

  Widget _buildMultiSelectField(String key, Map<String, dynamic> fieldData) {
    final options = fieldData['options'] as List<String>;
    final selectedValues = fieldData['selected'] as List<String>? ?? [];

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
                      fieldData['selected'] = selectedValues;
                    });
                  },
                  backgroundColor: Colors.grey.shade100,
                  selectedColor: const Color(0xFFE33629).withOpacity(0.2),
                  checkmarkColor: const Color(0xFFE33629),
                  labelStyle: TextStyle(
                    color:
                        isSelected ? const Color(0xFFE33629) : Colors.black87,
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

  // Future<void> _submitListing() async {
  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }

  //   if (selectedCategoryId == null) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please select a category'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   if (_selectedImages.isEmpty) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please add at least one image'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   // Validate required attributes
  //   bool hasRequiredFields = true;
  //   attributeValues.forEach((key, value) {
  //     // Skip price validation for gold shops and companies
  //     if (key == 'price' &&
  //         (selectedCategoryName?.toLowerCase() == 'gold shops' ||
  //          selectedCategoryName?.toLowerCase() == 'companies')) {
  //       return;
  //     }

  //     if (value['isRequired'] == true) {
  //       if (attributeControllers.containsKey(key) && attributeControllers[key]!.text.isEmpty) {
  //         hasRequiredFields = false;
  //       }
  //     }
  //   });

  //   if (!hasRequiredFields) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Please fill all required fields'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //     return;
  //   }

  //   setState(() {
  //     _isUploading = true;
  //   });

  //   try {
  //     final userId = await SharedPrefHelper.getUserId();
  //     if (userId == null) {
  //       throw Exception('User not logged in');
  //     }

  //     // Prepare the request
  //     var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse('${ApiConstants.baseUrl}/api/create/$selectedCategoryId'),
  //     );

  //     // Add basic fields
  //     request.fields['userId'] = userId;
  //     request.fields['name'] = _titleController.text;
  //     request.fields['description'] = _descriptionController.text;
  //     request.fields['address'] = _addressController.text;
  //     request.fields['contactNumber'] = _contactNumberController.text;
  //     request.fields['email'] = _emailController.text;
  //     request.fields['website'] = _websiteController.text;
  //     request.fields['latitude'] = _latitudeController.text.isNotEmpty
  //         ? _latitudeController.text
  //         : '17.4065';
  //     request.fields['longitude'] = _longitudeController.text.isNotEmpty
  //         ? _longitudeController.text
  //         : '78.4483';

  //     // Create contact object
  //     Map<String, dynamic> contactInfo = {
  //       'callNumber': _contactNumberController.text,
  //       'email': _emailController.text,
  //     };

  //     // Add website to contact if it exists
  //     if (_websiteController.text.isNotEmpty) {
  //       contactInfo['website'] = _websiteController.text;
  //     }

  //     // Add contact as JSON string
  //     request.fields['contact'] = json.encode(contactInfo);

  //     // Add attributes as JSON
  //     request.fields['attributes'] = json.encode(_buildAttributes());

  //     // ===== NEW: Add portfolio data =====
  //     final portfolioData = _buildPortfolioData();
  //     if (portfolioData.isNotEmpty) {
  //       request.fields['portfolio'] = json.encode(portfolioData);
  //     }

  //     // ===== NEW: Add previous events data =====
  //     final eventsData = _buildEventsData();
  //     if (eventsData.isNotEmpty) {
  //       request.fields['previousEvents'] = json.encode(eventsData);
  //     }

  //     // Add feature names if any
  //     if (_featureNameControllers.isNotEmpty && _featureNameControllers.any((c) => c.text.isNotEmpty)) {
  //       List<String> featureNames = _featureNameControllers
  //           .where((c) => c.text.isNotEmpty)
  //           .map((c) => c.text)
  //           .toList();
  //       request.fields['featureNames'] = json.encode(featureNames);
  //     }

  //     // Add main images
  //     for (var i = 0; i < _selectedImages.length; i++) {
  //       var file = await http.MultipartFile.fromPath(
  //         'images',
  //         _selectedImages[i].path,
  //       );
  //       request.files.add(file);
  //     }

  //     // Add feature images
  //     for (var i = 0; i < _featureImages.length; i++) {
  //       if (_featureImages[i].path.isNotEmpty) {
  //         var file = await http.MultipartFile.fromPath(
  //           'featureImages',
  //           _featureImages[i].path,
  //         );
  //         request.files.add(file);
  //       }
  //     }

  //     // ===== NEW: Add portfolio logos =====
  //     for (var i = 0; i < _portfolioItems.length; i++) {
  //       final logo = _portfolioItems[i]['logo'];
  //       if (logo != null && logo.path.isNotEmpty) {
  //         var file = await http.MultipartFile.fromPath(
  //           'portfolioLogos',
  //           logo.path,
  //         );
  //         request.files.add(file);
  //       }
  //     }

  //     // ===== NEW: Add event images =====
  //     for (var i = 0; i < _previousEvents.length; i++) {
  //       final image = _previousEvents[i]['image'];
  //       if (image != null && image.path.isNotEmpty) {
  //         var file = await http.MultipartFile.fromPath(
  //           'eventImages',
  //           image.path,
  //         );
  //         request.files.add(file);
  //       }
  //     }

  //     // Send request
  //     var response = await request.send();
  //     var responseData = await response.stream.bytesToString();
  //     var decodedData = json.decode(responseData);
  //     print("rrrrrrrrrrrrrrrrrrrrrrr${response.statusCode}");

  //     print("rrrrrrrrrrrrrrrrrrrrrrr$decodedData");

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(
  //             content: Text('Property listed successfully!'),
  //             backgroundColor: Colors.green,
  //           ),
  //         );

  //         // Navigate back
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const NavbarScreen()));
  //       }
  //     } else {
  //       throw Exception(decodedData['message'] ?? 'Failed to list property');
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error: $e'),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isUploading = false;
  //       });
  //     }
  //   }
  // }

  Future<void> _submitListing() async {
    final userId = SharedPrefHelper.getUserId();
    if (userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not found. Please login again.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

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

    if (_selectedImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one image'),
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

      // Prepare the request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${ApiConstants.baseUrl}/api/create/$selectedCategoryId'),
      );

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

      // ✅ FIX: Add feature names ONLY if there are features
      if (_featureNameControllers.isNotEmpty &&
          _featureNameControllers.any((c) => c.text.isNotEmpty)) {
        List<String> featureNames = _featureNameControllers
            .where((c) => c.text.isNotEmpty)
            .map((c) => c.text)
            .toList();
        if (featureNames.isNotEmpty) {
          // Your backend already handles featureNames from the request body
          request.fields['featureNames'] = json.encode(featureNames);
        }
      }

      // Add portfolio data
      final portfolioData = _buildPortfolioData();
      if (portfolioData.isNotEmpty) {
        request.fields['portfolio'] = json.encode(portfolioData);
      }

      // Add previous events data
      final eventsData = _buildEventsData();
      if (eventsData.isNotEmpty) {
        request.fields['previousEvents'] = json.encode(eventsData);
      }

      // ✅ ADD DEBUG PRINT
      print("========== FIELDS BEING SENT ==========");
      request.fields.forEach((key, value) {
        print("Field: $key = $value");
      });

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

      // Add portfolio logos
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

      // Add event images
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

      // ✅ ADD DEBUG PRINT FOR FILES
      print("========== FILES BEING SENT ==========");
      for (var file in request.files) {
        print("File field: ${file.field} - ${file.filename}");
      }

      // Send request
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var decodedData = json.decode(responseData);

      print("Response status: ${response.statusCode}");
      print("Response body: $decodedData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Property listed successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const NavbarScreen()));
        }
      } else {
        throw Exception(decodedData['message'] ?? 'Failed to list property');
      }
    } catch (e) {
      print("Submission error: $e");
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

  @override
  Widget build(BuildContext context) {
    return AppBackControl(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "List Property",
            style: TextStyle(
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
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Uploading property...'),
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
                                    border:
                                        Border.all(color: Colors.grey.shade200),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      childAspectRatio: 0.9,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      final category = categories[index];
                                      final isSelected =
                                          selectedCategoryId == category['id'];

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCategoryId = category['id'];
                                            selectedCategoryName =
                                                category['name'];
                                          });
                                          _initializeAttributeFields(
                                              category['name']);
                                        },
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
                                            color: isSelected
                                                ? null
                                                : Colors.grey.shade50,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: isSelected
                                                  ? const Color(0xFFE33629)
                                                  : Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: category['image'] !=
                                                            null &&
                                                        category['image']
                                                            .isNotEmpty
                                                    ? Image.network(
                                                        category['image'],
                                                        width: 20,
                                                        height: 20,
                                                        errorBuilder:
                                                            (_, __, ___) {
                                                          return Icon(
                                                            Icons.category,
                                                            size: 20,
                                                            color: isSelected
                                                                ? const Color(
                                                                    0xFFE33629)
                                                                : Colors.grey,
                                                          );
                                                        },
                                                      )
                                                    : Icon(
                                                        Icons.category,
                                                        size: 20,
                                                        color: isSelected
                                                            ? const Color(
                                                                0xFFE33629)
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

                      // Image Grid
                      if (_selectedImages.isNotEmpty)
                        Container(
                          height: 100,
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
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
                                        image:
                                            FileImage(_selectedImages[index]),
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
                                'Add Photos (${_selectedImages.length}/10)',
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
                          onPressed:
                              _isGettingLocation ? null : _getCurrentLocation,
                          icon: _isGettingLocation
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.my_location, size: 18),
                          label: Text(_isGettingLocation
                              ? 'Getting Location...'
                              : 'Get Current Location'),
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
                        if (selectedCategoryName?.toLowerCase() !=
                                'companies' &&
                            selectedCategoryName?.toLowerCase() !=
                                'gold shops') ...[
                          _buildTextField(
                            controller: attributeControllers['price'] ??
                                TextEditingController(),
                            label:
                                attributeValues['price']?['label'] ?? 'Price',
                            hint: attributeValues['price']?['hint'] ??
                                'Enter price',
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
                                          booleanAttributes[key] =
                                              value ?? false;
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 14),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: DropdownButton<String>(
                                        value: dropdownAttributes[key] ??
                                            (fieldData['options']
                                                    as List<String>?)
                                                ?.firstOrNull,
                                        isExpanded: true,
                                        underline: const SizedBox(),
                                        icon: const Icon(Icons.arrow_drop_down),
                                        onChanged: (value) {
                                          setState(() {
                                            dropdownAttributes[key] = value!;
                                          });
                                        },
                                        items: (fieldData['options']
                                                as List<String>)
                                            .map((String item) {
                                          return DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style:
                                                  const TextStyle(fontSize: 14),
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
                                    hint: fieldData['hint'] ??
                                        'Enter ${fieldData['label']}',
                                    keyboardType: fieldData['isNumber'] == true
                                        ? TextInputType.number
                                        : TextInputType.text,
                                    validator: fieldData['isRequired'] == true
                                        ? (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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

                      // ===== NEW: Portfolio Section =====
                      if (selectedCategoryName?.toLowerCase() ==
                          'companies') ...[
                        const Text(
                          "Portfolio (Optional)",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Portfolio Items
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            image: item['logo'] != null
                                                ? DecorationImage(
                                                    image:
                                                        FileImage(item['logo']),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      hintText:
                                          'Brief description of the project',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                    ),
                                  ),

                                  if (_portfolioItems.length > 1)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () =>
                                            _removePortfolioItem(index),
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

                      // ===== NEW: Previous Events Section =====
                      if (selectedCategoryName?.toLowerCase() == 'companies' ||
                          selectedCategoryName?.toLowerCase() == 'hotel' ||
                          selectedCategoryName?.toLowerCase() ==
                              'gold shops') ...[
                        const Text(
                          "Previous Events (Optional)",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Event Items
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            image: event['image'] != null
                                                ? DecorationImage(
                                                    image: FileImage(
                                                        event['image']),
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
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                              'Tap to upload',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey.shade500,
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
                                    controller: event['title'],
                                    decoration: InputDecoration(
                                      labelText: 'Event Title',
                                      labelStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                      hintText:
                                          'e.g., Annual Tech Conference 2024',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      hintText:
                                          'Brief description of the event',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                        border: Border.all(
                                            color: Colors.grey.shade300),
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
                                                color:
                                                    event['eventDate'] != null
                                                        ? Colors.black87
                                                        : Colors.grey.shade500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  if (_previousEvents.length > 1)
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () =>
                                            _removePreviousEvent(index),
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

                        // Feature Fields
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
                                          controller:
                                              _featureNameControllers[index],
                                          decoration: InputDecoration(
                                            labelText: 'Feature Name',
                                            labelStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade600,
                                            ),
                                            hintText: _getFeatureHint(
                                                selectedCategoryName),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
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
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.grey.shade300),
                                            image: _featureImages.length >
                                                        index &&
                                                    _featureImages[index]
                                                        .path
                                                        .isNotEmpty
                                                ? DecorationImage(
                                                    image: FileImage(
                                                        _featureImages[index]),
                                                    fit: BoxFit.cover,
                                                  )
                                                : null,
                                          ),
                                          child: _featureImages.length <=
                                                      index ||
                                                  _featureImages[index]
                                                      .path
                                                      .isEmpty
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
                                        onPressed: () =>
                                            _removeFeatureField(index),
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
                          child: const Text(
                            "List Property",
                            style: TextStyle(
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
      ),
    );
  }

  String _getExampleTitle(String? categoryName) {
    if (categoryName == null) return 'Luxurious Villa';

    switch (categoryName.toLowerCase()) {
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
        return 'Pixelmindsolutions - App Development';
      default:
        return 'Luxurious Property';
    }
  }

  String _getDescriptionHint(String? categoryName) {
    if (categoryName == null) return 'Describe your property...';

    switch (categoryName.toLowerCase()) {
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

    switch (categoryName.toLowerCase()) {
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
