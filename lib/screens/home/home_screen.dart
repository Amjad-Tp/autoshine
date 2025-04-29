import 'package:autoshine/controller/user_service_controller.dart';
import 'package:autoshine/screens/all_services_screen.dart';
import 'package:autoshine/screens/service%20screen/services_details_screen.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceController = Get.put(UserServiceController());
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 16,
                            color: blackColor.withValues(alpha: .3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                                onTap: () => Get.to(() => AllServicesScreen()),
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

                          const SizedBox(height: 20),
                          Obx(() {
                            if (serviceController.isLoading.value) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 40,
                                ),
                                child: CircularProgressIndicator(
                                  color: blackColor,
                                ),
                              );
                            }

                            if (serviceController.services.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text('No services found'),
                              );
                            }

                            return GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 25,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 1 / 1.5,
                                  ),
                              itemCount: serviceController.services.length,
                              itemBuilder: (context, index) {
                                final service =
                                    serviceController.services[index];
                                return GestureDetector(
                                  onTap:
                                      () => Get.to(
                                        () => ServiceDetailsScreen(
                                          service: service,
                                        ),
                                      ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                          service.imageUrl,
                                        ),
                                        backgroundColor: Colors.grey[300],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        service.name,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                        ],
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
