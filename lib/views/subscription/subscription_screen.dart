import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedPlan = 1; // 0 for 1 month, 1 for 12 months

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B6FED),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with shield icon and close button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                     Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Color(0xFF6B6FED),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Circle icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 8,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            const Text(
              'Try Premium for free',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 24),

            // Features list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  _buildFeatureItem('Guided sessions on 100+ topics'),
                  const SizedBox(height: 12),
                  _buildFeatureItem('Courses to help you dive deeper'),
                  const SizedBox(height: 12),
                  _buildFeatureItem('Insights to uncover moods and triggers'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Subscription plans
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // 1 Month plan
                  GestureDetector(
                    onTap: () => setState(() => selectedPlan = 0),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: selectedPlan == 0
                              ? const Color(0xFF6B6FED)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '1 Month',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                '9,99 \$ / Month',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (selectedPlan == 0)
                                const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF6B6FED),
                                  size: 24,
                                )
                              else
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                      width: 2,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 12 Months plan with badge
                  GestureDetector(
                    onTap: () => setState(() => selectedPlan = 1),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              
                              color: selectedPlan == 1
                                  ? const Color(0xFF6B6FED)
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '12 Months',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '119,88 \$',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      const Text(
                                        '59,99 \$',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    '4,99 \$ / Month',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  if (selectedPlan == 1)
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF6B6FED),
                                      size: 24,
                                    )
                                  else
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Save 50% badge
                        Positioned(
                          top: -10,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6B4A),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'SAVE 50%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // App Bundle link
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  children: [
                    TextSpan(text: 'Get more with our App Bundle. '),
                    TextSpan(
                      text: 'Learn More',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Bottom section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      children: [
                        TextSpan(
                          text: 'Start your 7-day free trial',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: '. Cancel Anytime.'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 118, 59, 255),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Try free and subscribe',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Row(
      children: [
        const Icon(
          Icons.check,
          color: Colors.white,
          size: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}