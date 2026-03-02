// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// class NearestHouseDetail extends StatefulWidget {
//   final Map<String, dynamic> house;

//   const NearestHouseDetail({
//     super.key,
//     required this.house,
//   });

//   @override
//   State<NearestHouseDetail> createState() => _NearestHouseDetailState();
// }

// class _NearestHouseDetailState extends State<NearestHouseDetail> {
//   bool isFavorite = false;

//   Future<void> _openWhatsApp(BuildContext context) async {
//     const String phoneNumber = '919961593179';

//     final String message = Uri.encodeComponent(
//       'Hi, I am interested in the property: ${widget.house['title'] ?? 'Property'} located at ${widget.house['location'] ?? 'Unknown location'}',
//     );

//     final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber?text=$message');

//     try {
//       if (await canLaunchUrl(whatsappUrl)) {
//         await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar(context, 'Could not open WhatsApp');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar(context, 'Error: $e');
//       }
//     }
//   }

//   Future<void> _makePhoneCall(BuildContext context) async {
//     const String phoneNumber = 'tel:+919961593179';

//     final Uri phoneUrl = Uri.parse(phoneNumber);

//     try {
//       if (await canLaunchUrl(phoneUrl)) {
//         await launchUrl(phoneUrl);
//       } else {
//         if (context.mounted) {
//           _showErrorSnackBar(context, 'Could not make phone call');
//         }
//       }
//     } catch (e) {
//       if (context.mounted) {
//         _showErrorSnackBar(context, 'Error: $e');
//       }
//     }
//   }

//   void _showErrorSnackBar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         behavior: SnackBarBehavior.floating,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: _PropertyImageHeader(
//                   imageUrl: widget.house['image'],
//                   title: widget.house['title'],
//                   isFavorite: isFavorite,
//                   onFavoriteTap: () {
//                     setState(() {
//                       isFavorite = !isFavorite;
//                     });
//                   },
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       /// Title
//                       Text(
//                         widget.house['title'] ?? 'Property',
//                         style: const TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.black87,
//                         ),
//                       ),

//                       const SizedBox(height: 6),

//                       /// Location
//                       Row(
//                         children: [
//                           Image.asset(
//                             'assets/images/map.png',
//                             width: 14,
//                             height: 14,
//                             errorBuilder: (_, __, ___) {
//                               return const Icon(Icons.location_on, size: 14);
//                             },
//                           ),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               widget.house['location'] ?? 'Unknown location',
//                               style: TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey.shade500,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 16),

//                       /// Stats Container
//                       Container(
//                         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade50,
//                           borderRadius: BorderRadius.circular(12),
//                           border: Border.all(color: Colors.grey.shade200),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             _StatItem(
//                               imagePath: 'assets/images/bed.png',
//                               value: widget.house['beds'] ?? '4 Bed',
//                             ),
//                             _Divider(),
//                             _StatItem(
//                               imagePath: 'assets/images/bath.png',
//                               value: widget.house['baths'] ?? '2 Bath',
//                             ),
//                             _Divider(),
//                             _StatItem(
//                               imagePath: 'assets/images/sqft.png',
//                               value: widget.house['area'] ?? '7,500 sqft',
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       /// Description
//                       const _SectionTitle("Description"),
//                       const SizedBox(height: 8),
//                       Text(
//                         widget.house['description'] ??
//                             'Beautiful property located in prime area with modern amenities and peaceful surroundings.',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade600,
//                           height: 1.6,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       /// Map Section
//                       const _SectionTitle("View on Map"),
//                       const SizedBox(height: 10),

//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(14),
//                         child: Container(
//                           width: double.infinity,
//                           height: 160,
//                           color: Colors.grey.shade200,
                      
//                          child: Image.asset(
//                             'assets/images/map.png',
//                             width: double.infinity,
//                             height: 160,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: _BottomActionBar(
//               onWhatsAppTap: () => _openWhatsApp(context),
//               onCallTap: () => _makePhoneCall(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Property Image Header (exact same as first UI) ───────────────────────────

// class _PropertyImageHeader extends StatelessWidget {
//   final String? imageUrl;
//   final String? title;
//   final bool isFavorite;
//   final VoidCallback onFavoriteTap;
//   final VoidCallback? onShareTap;

//   const _PropertyImageHeader({
//     required this.imageUrl,
//     required this.title,
//     required this.isFavorite,
//     required this.onFavoriteTap,
//     this.onShareTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // 🔥 Curved Bottom Image
//         ClipRRect(
//           borderRadius: const BorderRadius.vertical(
//             bottom: Radius.circular(30),
//           ),
//           child: SizedBox(
//             height: 375,
//             width: double.infinity,
//             child: imageUrl != null &&
//                     imageUrl!.toString().startsWith('http')
//                 ? Image.network(
//                     imageUrl!,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) {
//                       return Container(
//                         color: Colors.grey.shade300,
//                         child: const Center(
//                           child:
//                               Icon(Icons.image_not_supported, size: 50),
//                         ),
//                       );
//                     },
//                     loadingBuilder:
//                         (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Container(
//                         color: Colors.grey.shade200,
//                         child: const Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//                     },
//                   )
//                 : Container(
//                     color: Colors.grey.shade300,
//                     child: const Center(
//                       child:
//                           Icon(Icons.image_not_supported, size: 50),
//                     ),
//                   ),
//           ),
//         ),

//         // 🔙 Back Button
//         Positioned(
//           top: 44,
//           left: 14,
//           child: _CircleIconButton(
//             icon: Icons.arrow_back,
//             onTap: () => Navigator.pop(context),
//           ),
//         ),

//         // ❤️ + 🔗 Icons Right Side
//         Positioned(
//           top: 44,
//           right: 14,
//           child: Column(
//             children: [
//               _CircleIconButton(
//                 icon: isFavorite
//                     ? Icons.favorite
//                     : Icons.favorite_border,
//                 onTap: onFavoriteTap,
//               ),
//               const SizedBox(height: 12),
//               _CircleIconButton(
//                 icon: Icons.reply,
//                 onTap: onShareTap ?? () {

//                 },
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Circle Icon Button (exact same as first UI) ─────────────────────────────

// class _CircleIconButton extends StatelessWidget {
//   final IconData icon;
//   final VoidCallback onTap;

//   const _CircleIconButton({
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 36,
//         height: 36,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           shape: BoxShape.circle,
//         ),
//         child: Icon(icon, size: 18),
//       ),
//     );
//   }
// }

// // ── Section Title (exact same as first UI) ─────────────────────────────────

// class _SectionTitle extends StatelessWidget {
//   final String title;

//   const _SectionTitle(this.title);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 15,
//         fontWeight: FontWeight.w700,
//         color: Colors.black87,
//       ),
//     );
//   }
// }

// // ── Stat Item (exact same as first UI) ─────────────────────────────────────

// class _StatItem extends StatelessWidget {
//   final String imagePath;
//   final String value;

//   const _StatItem({
//     required this.imagePath,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Image.asset(
//           imagePath,
//           width: 16,
//           height: 16,
//           errorBuilder: (_, __, ___) {
//             return Container(
//               width: 16,
//               height: 16,
//               color: Colors.grey,
//             );
//           },
//         ),
//         const SizedBox(width: 6),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 12,
//             color: Colors.black87,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Divider (exact same as first UI) ───────────────────────────────────────

// class _Divider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 1,
//       height: 18,
//       color: Colors.grey.shade300,
//     );
//   }
// }

// // ── Bottom Action Bar (exact same as first UI) ─────────────────────────────

// class _BottomActionBar extends StatelessWidget {
//   final VoidCallback onWhatsAppTap;
//   final VoidCallback onCallTap;

//   const _BottomActionBar({
//     required this.onWhatsAppTap,
//     required this.onCallTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.07),
//             blurRadius: 12,
//             offset: const Offset(0, -3),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: GestureDetector(
//               onTap: onCallTap,
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE33629),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/images/whatsapp.png',
//                       width: 16,
//                       height: 16,
//                       color: Colors.white,
//                       errorBuilder: (_, __, ___) {
//                         return const Icon(Icons.phone, color: Colors.white, size: 16);
//                       },
//                     ),
//                     const SizedBox(width: 8),
//                     const Text(
//                       "Call",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: GestureDetector(
//               onTap: onWhatsAppTap,
//               child: Container(
//                 height: 48,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: Colors.grey.shade300),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/images/whatsapp.png',
//                       width: 18,
//                       height: 18,
//                       errorBuilder: (_, __, ___) {
//                         return const Icon(Icons.chat, size: 18);
//                       },
//                     ),
//                     const SizedBox(width: 8),
//                     const Text(
//                       "Whatsapp",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }























import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class NearestHouseDetail extends StatefulWidget {
  final Map<String, dynamic> house;

  const NearestHouseDetail({
    super.key,
    required this.house,
  });

  @override
  State<NearestHouseDetail> createState() => _NearestHouseDetailState();
}

class _NearestHouseDetailState extends State<NearestHouseDetail> {
  bool isFavorite = false;

  Future<void> _openWhatsApp(BuildContext context) async {
    const String phoneNumber = '919961593179';

    final String message = Uri.encodeComponent(
      'Hi, I am interested in the property: ${widget.house['title'] ?? 'Property'} located at ${widget.house['location'] ?? 'Unknown location'}',
    );

    final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber?text=$message');

    try {
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          _showErrorSnackBar(context, 'Could not open WhatsApp');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Error: $e');
      }
    }
  }

  Future<void> _makePhoneCall(BuildContext context) async {
    const String phoneNumber = 'tel:+919961593179';

    final Uri phoneUrl = Uri.parse(phoneNumber);

    try {
      if (await canLaunchUrl(phoneUrl)) {
        await launchUrl(phoneUrl);
      } else {
        if (context.mounted) {
          _showErrorSnackBar(context, 'Could not make phone call');
        }
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Error: $e');
      }
    }
  }

  Future<void> _shareProperty() async {
    try {
      // Create share text with property details
      String shareText = _generateShareText();
      
      // Share via share_plus
      await Share.share(
        shareText,
        subject: 'Check out this property: ${widget.house['title']}',
      );
      
      if (context.mounted) {
        _showSuccessSnackBar(context, 'Sharing options opened');
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Error sharing: $e');
      }
    }
  }

  String _generateShareText() {
    StringBuffer text = StringBuffer();
    
    text.writeln('🏠 *${widget.house['title'] ?? 'Property'}*');
    text.writeln('');
    text.writeln('📍 *Location:* ${widget.house['location'] ?? 'Unknown'}');
    text.writeln('💰 *Price:* ${widget.house['price'] ?? 'Contact for price'}');
    text.writeln('🛏️ *Beds:* ${widget.house['beds'] ?? '4 Bed'}');
    text.writeln('🚿 *Baths:* ${widget.house['baths'] ?? '2 Bath'}');
    text.writeln('📐 *Area:* ${widget.house['area'] ?? '7,500 sqft'}');
    text.writeln('');
    text.writeln('📝 *Description:*');
    text.writeln(widget.house['description'] ?? 'Beautiful property located in prime area with modern amenities and peaceful surroundings.');
    text.writeln('');
    text.writeln('Contact for more details:');
    text.writeln('📞 +91 9961593179');
    text.writeln('💬 WhatsApp: +91 9961593179');
    text.writeln('');
    text.writeln('Download our app to view more properties!');
    
    return text.toString();
  }

  Future<void> _shareWithImage() async {
    try {
      // Create share text
      String shareText = _generateShareText();
      
      // If you have image URL and want to share image as well
      // Note: This requires downloading the image first
      if (widget.house['image'] != null && widget.house['image'].toString().isNotEmpty) {
        // For sharing with image, you'd need to download the image first
        // This is a simplified version without image
        await Share.share(
          shareText,
          subject: 'Check out this property: ${widget.house['title']}',
        );
      } else {
        await Share.share(
          shareText,
          subject: 'Check out this property: ${widget.house['title']}',
        );
      }
      
      if (context.mounted) {
        _showSuccessSnackBar(context, 'Sharing options opened');
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, 'Error sharing: $e');
      }
    }
  }

  void _showShareOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.blue, size: 24),
                ),
                title: const Text('Share via...'),
                subtitle: const Text('Share to social media, messages, etc.'),
                onTap: () {
                  Navigator.pop(context);
                  _shareProperty();
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/whatsapp.png',
                    width: 24,
                    height: 24,
                    errorBuilder: (_, __, ___) {
                      return const Icon(Icons.chat, color: Colors.green, size: 24);
                    },
                  ),
                ),
                title: const Text('Share on WhatsApp'),
                subtitle: const Text('Send to WhatsApp contacts'),
                onTap: () {
                  Navigator.pop(context);
                  _openWhatsApp(context);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.copy, color: Colors.grey, size: 24),
                ),
                title: const Text('Copy Details'),
                subtitle: const Text('Copy property details to clipboard'),
                onTap: () {
                  Navigator.pop(context);
                  _copyToClipboard(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    String shareText = _generateShareText();
    await Share.share(shareText); // This will show share dialog
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _PropertyImageHeader(
                  imageUrl: widget.house['image'],
                  title: widget.house['title'],
                  isFavorite: isFavorite,
                  onFavoriteTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  onShareTap: _showShareOptions,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Text(
                        widget.house['title'] ?? 'Property',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// Location
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/map.png',
                            width: 14,
                            height: 14,
                            errorBuilder: (_, __, ___) {
                              return const Icon(Icons.location_on, size: 14);
                            },
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.house['location'] ?? 'Unknown location',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// Stats Container
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _StatItem(
                              imagePath: 'assets/images/bed.png',
                              value: widget.house['beds'] ?? '4 Bed',
                            ),
                            _Divider(),
                            _StatItem(
                              imagePath: 'assets/images/bath.png',
                              value: widget.house['baths'] ?? '2 Bath',
                            ),
                            _Divider(),
                            _StatItem(
                              imagePath: 'assets/images/sqft.png',
                              value: widget.house['area'] ?? '7,500 sqft',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Description
                      const _SectionTitle("Description"),
                      const SizedBox(height: 8),
                      Text(
                        widget.house['description'] ??
                            'Beautiful property located in prime area with modern amenities and peaceful surroundings.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// Map Section
                      const _SectionTitle("View on Map"),
                      const SizedBox(height: 10),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: GestureDetector(
                          onTap: () {
                            // You can add map navigation here
                          },
                          child: Container(
                            width: double.infinity,
                            height: 160,
                            color: Colors.grey.shade200,
                            child: Image.asset(
                              'assets/images/map.png',
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.map, size: 40, color: Colors.grey.shade400),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Tap to open map',
                                        style: TextStyle(color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _BottomActionBar(
              onWhatsAppTap: () => _openWhatsApp(context),
              onCallTap: () => _makePhoneCall(context),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Property Image Header (exact same as first UI) ───────────────────────────

class _PropertyImageHeader extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback? onShareTap;

  const _PropertyImageHeader({
    required this.imageUrl,
    required this.title,
    required this.isFavorite,
    required this.onFavoriteTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🔥 Curved Bottom Image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
          child: SizedBox(
            height: 375,
            width: double.infinity,
            child: imageUrl != null &&
                    imageUrl!.toString().startsWith('http')
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Center(
                          child:
                              Icon(Icons.image_not_supported, size: 50),
                        ),
                      );
                    },
                    loadingBuilder:
                        (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey.shade200,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  )
                : Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child:
                          Icon(Icons.image_not_supported, size: 50),
                    ),
                  ),
          ),
        ),

        // 🔙 Back Button
        Positioned(
          top: 44,
          left: 14,
          child: _CircleIconButton(
            icon: Icons.arrow_back,
            onTap: () => Navigator.pop(context),
          ),
        ),

        // ❤️ + 🔗 Icons Right Side
        Positioned(
          top: 44,
          right: 14,
          child: Column(
            children: [
              _CircleIconButton(
                icon: isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border,
                onTap: onFavoriteTap,
              ),
              const SizedBox(height: 12),
              _CircleIconButton(
                icon: Icons.reply,
                onTap: onShareTap ?? () {
                  // Default share if no callback provided
                  Share.share(
                    'Check out this property: $title\n\nDownload our app to view more properties!',
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Circle Icon Button (exact same as first UI) ─────────────────────────────

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}

// ── Section Title (exact same as first UI) ─────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }
}

// ── Stat Item (exact same as first UI) ─────────────────────────────────────

class _StatItem extends StatelessWidget {
  final String imagePath;
  final String value;

  const _StatItem({
    required this.imagePath,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath,
          width: 16,
          height: 16,
          errorBuilder: (_, __, ___) {
            return Container(
              width: 16,
              height: 16,
              color: Colors.grey,
            );
          },
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ── Divider (exact same as first UI) ───────────────────────────────────────

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 18,
      color: Colors.grey.shade300,
    );
  }
}

// ── Bottom Action Bar (exact same as first UI) ─────────────────────────────

class _BottomActionBar extends StatelessWidget {
  final VoidCallback onWhatsAppTap;
  final VoidCallback onCallTap;

  const _BottomActionBar({
    required this.onWhatsAppTap,
    required this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onCallTap,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFE33629),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/whatsapp.png',
                      width: 16,
                      height: 16,
                      color: Colors.white,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.phone, color: Colors.white, size: 16);
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Call",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onWhatsAppTap,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/whatsapp.png',
                      width: 18,
                      height: 18,
                      errorBuilder: (_, __, ___) {
                        return const Icon(Icons.chat, size: 18);
                      },
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Whatsapp",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}