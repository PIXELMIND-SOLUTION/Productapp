import 'package:flutter/material.dart';
import 'package:product_app/views/home/home_screen.dart';
import 'package:product_app/views/home/navbar_screen.dart';
import 'package:product_app/views/home/option_screen.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
              'lib/assets/326d2930d9db1602b33b58791da49bcca71891d3.png', 
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            color: Colors.black.withOpacity(0.3), 
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: 50,
                          child: TextField(
                            decoration: const InputDecoration(
                              counterText: '',
                              border: UnderlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            textAlign: TextAlign.center,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Resend OTP",style: TextStyle(color: Colors.grey),),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 50,
                    //   child: DecoratedBox(
                    //     decoration: BoxDecoration(
                    //       gradient: const LinearGradient(
                    //         colors: [Color.fromARGB(255, 103, 203, 231), Color.fromARGB(255, 103, 203, 231),],
                    //       ),
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: ElevatedButton(
                    //       onPressed: () {
                    //         Navigator.push(context,MaterialPageRoute(builder: (context)=>NavbarScreen()));
                    //       },
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.transparent,
                    //         shadowColor: Colors.transparent,
                    //       ),
                    //       child: const Text("Verify",style: TextStyle(color: Colors.white,fontSize: 18),),
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
        begin: Alignment.centerLeft,
        end: Alignment.centerRight, // makes gradient left → right
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OptionScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: const Text(
        "Verify",
        style: TextStyle(color: Colors.white, fontSize: 18),
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
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _socialIcon(String assetPath) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 25,
      child: Image.asset(assetPath, height: 30),
    );
  }
}
