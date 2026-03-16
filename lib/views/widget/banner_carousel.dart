import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:product_app/constant/api_constant.dart';

class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {

  List banners = [];
  bool isLoading = true;

  final String apiUrl = "${ApiConstants.baseUrl}/api/admin/banner";

  @override
  void initState() {
    super.initState();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        setState(() {
          banners = data["banners"];
          isLoading = false;
        });

      } else {

        setState(() {
          isLoading = false;
        });

      }

    } catch (e) {

      debugPrint("Banner fetch error: $e");

      setState(() {
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (banners.isEmpty) {
      return const SizedBox();
    }

    return CarouselSlider.builder(
      itemCount: banners.length,
      itemBuilder: (context, index, realIndex) {

        final banner = banners[index];

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            banner["image"],
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        );
      },
      options: CarouselOptions(
        height: 110,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }
}