import 'package:flutter/material.dart';
import 'package:product_app/Provider/auth/login_provider.dart';
import 'package:product_app/Provider/auth/otp_provider.dart';
import 'package:product_app/Provider/location/location_provider.dart';
import 'package:product_app/Provider/navbar_provider.dart';
import 'package:product_app/Provider/product/product_provider.dart';
import 'package:product_app/Provider/profile/profile_provider.dart';
import 'package:product_app/Provider/wishlist/wishlist_provider.dart';
import 'package:product_app/helper/helper_function.dart';
import 'package:provider/provider.dart';
import 'package:product_app/views/splash/logo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomNavbarProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => OtpProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: const MyApp(),
    ),
  ); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LogoScreen(),
    );
  }
}
