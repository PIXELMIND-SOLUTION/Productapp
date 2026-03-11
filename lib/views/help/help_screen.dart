// import 'package:flutter/material.dart';

// class HelpScreen extends StatelessWidget {
//   const HelpScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           'Help & Support',
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         leading: IconButton(onPressed: (){
//           Navigator.of(context).pop();
//         }, icon: Icon(Icons.arrow_back_ios)),
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildHeader(),
//             const SizedBox(height: 20),
//             _buildHelpCategories(),
//             const SizedBox(height: 24),
//             _buildFaqSection(),
//             const SizedBox(height: 24),
//             _buildContactSupport(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Row(
//         children: const [
//           Icon(Icons.support_agent, size: 40, color: Colors.blue),
//           SizedBox(width: 12),
//           Expanded(
//             child: Text(
//               'How can we help you?\nFind answers or contact our support team.',
//               style: TextStyle(fontSize: 15, color: Colors.black87),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHelpCategories() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Help Topics',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         GridView.count(
//           crossAxisCount: 2,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           children: const [
//             _HelpTile(
//               icon: Icons.shopping_bag,
//               title: 'Orders',
//             ),
//             _HelpTile(
//               icon: Icons.payments,
//               title: 'Payments',
//             ),
//             _HelpTile(
//               icon: Icons.store,
//               title: 'Product Listings',
//             ),
//             _HelpTile(
//               icon: Icons.person,
//               title: 'Account',
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildFaqSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         Text(
//           'Frequently Asked Questions',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 12),
//         _FaqTile(
//           question: 'How do I list a product?',
//           answer:
//               'Go to the Sell section, add product details, upload images, and publish your listing.',
//         ),
//         _FaqTile(
//           question: 'When will I receive my payment?',
//           answer:
//               'Payments are processed within 3–5 business days after order completion.',
//         ),
//         _FaqTile(
//           question: 'Can I edit my product after listing?',
//           answer:
//               'Yes, you can edit your product details anytime from My Listings.',
//         ),
//         _FaqTile(
//           question: 'How do I contact a buyer or seller?',
//           answer:
//               'Use the in-app chat feature available on each product page.',
//         ),
//       ],
//     );
//   }

//   Widget _buildContactSupport(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Need More Help?',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 12),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(14),
//           ),
//           child: Column(
//             children: [
//               // ListTile(
//               //   leading: const Icon(Icons.chat, color: Colors.green),
//               //   title: const Text('Live Chat'),
//               //   subtitle: const Text('Chat with our support team'),
//               //   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//               //   onTap: () {
//               //     // Navigate to chat screen
//               //   },
//               // ),
//               const Divider(),
//               ListTile(
//                 leading: const Icon(Icons.email, color: Colors.blue),
//                 title: const Text('Email Support'),
//                 subtitle: const Text('support@yourapp.com'),
//                 onTap: () {},
//               ),
//               const Divider(),
//               ListTile(
//                 leading: const Icon(Icons.call, color: Colors.orange),
//                 title: const Text('Call Us'),
//                 subtitle: const Text('+91 98765 43210'),
//                 onTap: () {},
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _HelpTile extends StatelessWidget {
//   final IconData icon;
//   final String title;

//   const _HelpTile({
//     required this.icon,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, size: 36, color: Colors.blue),
//           const SizedBox(height: 10),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _FaqTile extends StatelessWidget {
//   final String question;
//   final String answer;

//   const _FaqTile({
//     required this.question,
//     required this.answer,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ExpansionTile(
//       title: Text(
//         question,
//         style: const TextStyle(fontWeight: FontWeight.w500),
//       ),
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: Text(
//             answer,
//             style: const TextStyle(color: Colors.black54),
//           ),
//         ),
//       ],
//     );
//   }
// }




















import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Help & Support',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildHelpCategories(context),
                const SizedBox(height: 24),
                _buildFaqSection(),
                const SizedBox(height: 24),
                _buildContactSupport(context),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: const [
          Icon(Icons.support_agent, size: 40, color: Colors.blue),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'How can we help you?\nFind answers or contact our support team.',
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCategories(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 900
        ? 4
        : screenWidth > 600
            ? 3
            : 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Help Topics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: crossAxisCount,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: const [
            _HelpTile(
              icon: Icons.shopping_bag,
              title: 'Orders',
            ),
            _HelpTile(
              icon: Icons.payments,
              title: 'Payments',
            ),
            _HelpTile(
              icon: Icons.store,
              title: 'Product Listings',
            ),
            _HelpTile(
              icon: Icons.person,
              title: 'Account',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFaqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Frequently Asked Questions',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        _FaqTile(
          question: 'How do I list a product?',
          answer:
              'Go to the Sell section, add product details, upload images, and publish your listing.',
        ),
        _FaqTile(
          question: 'When will I receive my payment?',
          answer:
              'Payments are processed within 3–5 business days after order completion.',
        ),
        _FaqTile(
          question: 'Can I edit my product after listing?',
          answer:
              'Yes, you can edit your product details anytime from My Listings.',
        ),
        _FaqTile(
          question: 'How do I contact a buyer or seller?',
          answer:
              'Use the in-app chat feature available on each product page.',
        ),
      ],
    );
  }

  Widget _buildContactSupport(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Need More Help?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: isWideScreen
              ? Row(
                  children: [
                    Expanded(
                      child: _ContactTile(
                        icon: Icons.email,
                        color: Colors.blue,
                        title: 'Email Support',
                        subtitle: 'support@yourapp.com',
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _ContactTile(
                        icon: Icons.call,
                        color: Colors.orange,
                        title: 'Call Us',
                        subtitle: '+91 98765 43210',
                        onTap: () {},
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.blue),
                      title: const Text('Email Support'),
                      subtitle: const Text('support@yourapp.com'),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.call, color: Colors.orange),
                      title: const Text('Call Us'),
                      subtitle: const Text('+91 98765 43210'),
                      onTap: () {},
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _ContactTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _HelpTile({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: Colors.blue),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FaqTile extends StatelessWidget {
  final String question;
  final String answer;

  const _FaqTile({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}