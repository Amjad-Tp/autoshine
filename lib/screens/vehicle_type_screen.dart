import 'package:autoshine/screens/add%20vehicle/bike_add_screen.dart';
import 'package:autoshine/screens/add%20vehicle/car_add_screen.dart';
import 'package:autoshine/values/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VehicleTypeScreen extends StatelessWidget {
  const VehicleTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: rockBlue,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final images = [
      Image.asset('assets/cars/innova.png', width: 300),
      Image.asset('assets/cars/himalayan.webp', width: 300),
      Image.asset('assets/cars/swift.png', width: 300),
      Image.asset('assets/cars/fortunure.png', width: 260),
      Image.asset('assets/cars/xpulse.png', width: 300),
      Image.asset('assets/cars/balano.png', width: 300),
    ];
    return Scaffold(
      backgroundColor: rockBlue,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: CarouselSlider(
                items: images,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enlargeFactor: 10,
                  initialPage: 0,
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 340,
                        child: Text(
                          'Choose Your Vehicle Type',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      vehicleButton(
                        '4 WHEELER',
                        'assets/cars/polo.png',
                        250,
                        () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => CarAddScreen()),
                        ),
                      ),
                      const SizedBox(height: 20),
                      vehicleButton(
                        '2 WHEELER',
                        'assets/cars/xpulse.png',
                        220,
                        () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => BikeAddScreen()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell vehicleButton(
    String type,
    String imagePath,
    double imageWidth,
    VoidCallback navigation,
  ) {
    return InkWell(
      onTap: navigation,
      child: Container(
        width: 350,
        height: 175,
        decoration: BoxDecoration(
          border: Border.all(color: darkTurquoise, width: 2),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'I have a',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.cyan,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              // top: 10,
              right: 0,
              bottom: 0,
              child: Image.asset(imagePath, width: imageWidth),
            ),
          ],
        ),
      ),
    );
  }
}
