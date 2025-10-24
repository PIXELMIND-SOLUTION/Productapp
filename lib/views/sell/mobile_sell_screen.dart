import 'package:flutter/material.dart';

class MobileSellScreen extends StatefulWidget {
  const MobileSellScreen({super.key});

  @override
  State<MobileSellScreen> createState() => _MobileSellScreenState();
}

class _MobileSellScreenState extends State<MobileSellScreen> {
  String? selectedCategory;
  String? selectedBrand;
  String? selectedCondition;
  String? selectedAge;
  String? selectedWarranty;
  String? selectedNetworkType;
  bool originalBillAvailable = false;
  bool boxAvailable = false;
  bool chargersAvailable = false;
  bool negotiable = false;

  final TextEditingController modelController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

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
          'Mobile Sell',
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
              // Category Dropdown
              _buildDropdown(
                label: 'Category',
                value: selectedCategory,
                items: ['Smartphones', 'Feature Phones', 'Tablets'],
                onChanged: (val) => setState(() => selectedCategory = val),
              ),
              const SizedBox(height: 16),

              // Brand Dropdown
              _buildDropdown(
                label: 'Brand',
                value: selectedBrand,
                items: [
                  'Apple',
                  'Samsung',
                  'OnePlus',
                  'Xiaomi',
                  'Realme',
                  'Oppo',
                  'Vivo'
                ],
                onChanged: (val) => setState(() => selectedBrand = val),
              ),
              const SizedBox(height: 16),

              // Model Name TextField
              _buildTextField(
                label: 'Model Name',
                controller: modelController,
              ),
              const SizedBox(height: 16),

              // Description Section
              const Text(
                'Description',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: descriptionController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Product Description',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Phone Details Section
              const Text(
                'Phone Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Condition Dropdown
              _buildDropdown(
                label: 'Condition',
                value: selectedCondition,
                items: ['Like New', 'Excellent', 'Good', 'Fair'],
                onChanged: (val) => setState(() => selectedCondition = val),
              ),
              const SizedBox(height: 16),

              // Age of phone Dropdown
              _buildDropdown(
                label: 'Age of phone',
                value: selectedAge,
                items: [
                  'Less than 6 months',
                  '6-12 months',
                  '1-2 years',
                  '2+ years'
                ],
                onChanged: (val) => setState(() => selectedAge = val),
              ),
              const SizedBox(height: 16),

              // Warranty Dropdown
              _buildDropdown(
                label: 'Warranty',
                value: selectedWarranty,
                items: ['Valid', 'Expired', 'No Warranty'],
                onChanged: (val) => setState(() => selectedWarranty = val),
              ),
              const SizedBox(height: 16),

              // Original Bill Available Toggle
              _buildToggleRow('Original Bill Available', originalBillAvailable,
                  (val) {
                setState(() => originalBillAvailable = val);
              }),
              const SizedBox(height: 16),

              // Box Available Toggle
              _buildToggleRow('Box Available', boxAvailable, (val) {
                setState(() => boxAvailable = val);
              }),
              const SizedBox(height: 16),

              // Charger & Accessories Available Toggle
              _buildToggleRow(
                  'Charger & Accessories Available', chargersAvailable, (val) {
                setState(() => chargersAvailable = val);
              }),
              const SizedBox(height: 16),

              // Network Type Dropdown
              _buildDropdown(
                label: 'Network Type',
                value: selectedNetworkType,
                items: ['4G', '5G', '3G'],
                onChanged: (val) => setState(() => selectedNetworkType = val),
              ),
              const SizedBox(height: 24),

              // Price Section
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Selling Price (₹)',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12),
                  ),
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
                      value: negotiable,
                      onChanged: (val) => setState(() => negotiable = val!),
                      activeColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Negotiable',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Add photos Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 32,
                      color: Colors.grey.shade600,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add photos',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please add atleast one image and start supporting pictures to manage your product best features',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
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
                        Color(0xFF00A8E8), 
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
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              hint: Text(
                label,
                style: const TextStyle(color: Colors.grey),
              ),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleRow(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: Colors.cyan,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }

  @override
  void dispose() {
    modelController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
