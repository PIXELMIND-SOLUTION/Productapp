import 'package:flutter/material.dart';
import 'package:product_app/views/auth/otp_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              'lib/assets/326d2930d9db1602b33b58791da49bcca71891d3.png', // Your background image
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            color: Colors.black.withOpacity(0.3), // Optional overlay
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please Sign In to Continue",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Text(
                    //   "Mobile Number",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your Mobile Number",
                        labelText: 'Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 50,
                    //   child: DecoratedBox(
                    //     decoration: BoxDecoration(
                    //       gradient: const LinearGradient(
                    //         colors: [Color.fromARGB(255, 77, 208, 245), Color.fromARGB(255, 77, 208, 245)],
                    //       ),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.transparent,
                    //         shadowColor: Colors.transparent,
                    //       ),
                    //       child: const Text("Get OTP",style: TextStyle(color: Colors.white),),
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
  width: double.infinity,
  height: 50,
  child: DecoratedBox(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF00A8E8), // #00A8E8
          Color(0xFF2BBBAD), // #2BBBAD
        ],
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OtpScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: const Text(
        "Get OTP",
        style: TextStyle(color: Colors.white),
      ),
    ),
  ),
),

                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("Or"),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _socialIcon('lib/assets/google-logo.webp'),
                        _socialIcon('lib/assets/twitterimage.png'),
                        _socialIcon('lib/assets/fb_1695273515215_1695273522698.avif'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 25,
      child: Image.asset(assetPath, height: 30),
    );
  }
}
