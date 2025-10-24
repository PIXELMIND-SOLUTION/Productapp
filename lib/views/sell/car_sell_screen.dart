import 'package:flutter/material.dart';

class CarSellScreen extends StatefulWidget {
  const CarSellScreen({super.key});

  @override
  State<CarSellScreen> createState() => _CarSellScreenState();
}

class _CarSellScreenState extends State<CarSellScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController kmDrivenController = TextEditingController();
  final TextEditingController sellingPriceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? selectedMake;
  String? selectedModel;
  String? selectedYear;
  String? selectedFuelType;
  String? selectedTransmission;
  String? selectedCity;
  String? selectedLocality;
  String? selectedPincode;
  bool isNegotiable = false;

  final List<String> makes = ['Ford', 'Honda', 'Toyota', 'Maruti', 'Hyundai'];
  final List<String> models = ['EcoSport', 'Figo', 'Aspire', 'Endeavour'];
  final List<String> years = ['2019', '2020', '2021', '2022', '2023', '2024'];
  final List<String> fuelTypes = ['Diesel', 'Petrol', 'CNG', 'Electric'];
  final List<String> transmissions = ['Manual', 'Automatic'];
  final List<String> cities = ['Hyderabad', 'Mumbai', 'Delhi', 'Bangalore'];
  final List<String> localities = ['Madhapur', 'Gachibowli', 'Hitech City'];
  final List<String> pincodes = ['Madhapur', 'Gachibowli', 'Hitech City'];

  @override
  void initState() {
    super.initState();
    selectedMake = 'Ford';
    selectedModel = 'EcoSport';
    selectedYear = '2019';
    selectedFuelType = 'Diesel';
    selectedTransmission = 'Manual';
    selectedCity = 'Hyderabad';
    selectedLocality = 'Madhapur';
    selectedPincode = 'Madhapur';
    kmDrivenController.text = '49000';
    sellingPriceController.text = '400000';
    nameController.text = 'Manoj Kumar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Car Sell',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Make',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: selectedMake,
                items: makes,
                onChanged: (value) => setState(() => selectedMake = value),
              ),
              const SizedBox(height: 16),

              // Model Dropdown
              const Text(
                'Model',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: selectedModel,
                items: models,
                onChanged: (value) => setState(() => selectedModel = value),
              ),
              const SizedBox(height: 16),

              // Description
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Product Description',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.cyan),
                  ),
                  contentPadding: const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 24),

              // Car Details Section
              const Text(
                'Car Details',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),

              // Year Dropdown
              const Text(
                'Year',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: selectedYear,
                items: years,
                onChanged: (value) => setState(() => selectedYear = value),
              ),
              const SizedBox(height: 16),

              // Fuel Type Dropdown
              const Text(
                'Fuel',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: selectedFuelType,
                items: fuelTypes,
                onChanged: (value) => setState(() => selectedFuelType = value),
              ),
              const SizedBox(height: 16),

              // Transmission Dropdown
              const Text(
                'Transmission',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: selectedTransmission,
                items: transmissions,
                onChanged: (value) =>
                    setState(() => selectedTransmission = value),
              ),
              const SizedBox(height: 16),

              // KM Driven
              const Text(
                'KM Driven',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: kmDrivenController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.cyan),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              const SizedBox(height: 24),

              // Price Section
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Selling Price
              const Text(
                'Selling Price (₹)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: sellingPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.cyan),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              const SizedBox(height: 12),

              // Negotiable Checkbox
              Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: isNegotiable,
                      onChanged: (value) =>
                          setState(() => isNegotiable = value ?? false),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      activeColor: Colors.cyan,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Negotiable',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Location Section
              const Text(
                'Location',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // City Dropdown
              const Text(
                'City',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: selectedCity,
                items: cities,
                onChanged: (value) => setState(() => selectedCity = value),
              ),
              const SizedBox(height: 16),

              // Locality Dropdown
              const Text(
                'Locality',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: selectedLocality,
                items: localities,
                onChanged: (value) => setState(() => selectedLocality = value),
              ),
              const SizedBox(height: 16),

              // Pincode Dropdown
              const Text(
                'Pincode',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              _buildDropdown(
                value: selectedPincode,
                items: pincodes,
                onChanged: (value) => setState(() => selectedPincode = value),
              ),
              const SizedBox(height: 24),

              // Contact Information Section
              const Text(
                'Contact information',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Name
              const Text(
                'Name',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.cyan),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
              ),
              const SizedBox(height: 24),

              // Add Photos Button
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_photo_alternate_outlined,
                        size: 32, color: Colors.grey[600]),
                    const SizedBox(height: 8),
                    Text(
                      'Add photos',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please click Submit button after uploading products to highlight your products from free.',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 24),

              // Post Now Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF00A8E8), // Top/Left color
                        Color(0xFF2BBBAD), // Bottom/Right color
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Post Now',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    kmDrivenController.dispose();
    sellingPriceController.dispose();
    nameController.dispose();
    super.dispose();
  }
}
