import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = List.generate(
      6,
      (index) => 'assets/washing pictures/slider ${index + 1}.jpg',
    );

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Column(
        children: [
          HomeAppbar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  CarouselSlider(
                    items:
                        imagePaths.map((path) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                path,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          );
                        }).toList(),
                    options: CarouselOptions(
                      height: 160,
                      autoPlay: true,
                      initialPage: 0,
                      viewportFraction: .956,
                      enlargeFactor: 0.1,
                      enlargeCenterPage: true,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      elevation: 10,
                      color: whiteColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hello ${user?.displayName ?? 'Guest'},',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      'Services you may need...',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),

                                GestureDetector(
                                  onTap: () {
                                    // All Service page Navigation
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'See All',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 15,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 25,
                                    mainAxisSpacing: 25,
                                  ),
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[400],
                                  child: Icon(
                                    Icons.cleaning_services_rounded,
                                    color: whiteColor,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
