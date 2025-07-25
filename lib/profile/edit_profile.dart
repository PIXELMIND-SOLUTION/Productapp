import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // Better UX
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(),
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                      'lib/assets/403079b6b3230e238d25d0e18c175d870e3223de.png',
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    // left: 80,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.black,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInputField(label: 'Name', hint: 'Manoj Kumar'),
            _buildInputField(label: 'Mobile Number', hint: '+6265165165'),
            _buildInputField(label: 'Email', hint: 'Manojkumar@gmail.com'),
            // const SizedBox(height: 30),
            // ElevatedButton(
            //   onPressed: () {
            //     // Save profile logic here
            //   },
            //   child: const Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12),
            //     child: Text('Save Changes'),
            //   ),
            // ),
            // const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required String hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
