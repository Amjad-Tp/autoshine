import 'package:autoshine/models/vehicle_type_model.dart';
import 'package:autoshine/screens/cart_screen.dart';
import 'package:autoshine/screens/home/notification_screen.dart';
import 'package:autoshine/screens/home/search_screen.dart';
import 'package:autoshine/services/vehicle_services.dart';
import 'package:autoshine/values/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [rockBlue, darkTurquoise]),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40, right: 25, left: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<VehicleTypeModel?>(
              future: VehicleService.getUserVehicle(user?.uid ?? ''),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Text(
                    'No Vehicle',
                    style: TextStyle(color: whiteColor),
                  );
                }

                final vehicle = snapshot.data!;
                return RichText(
                  text: TextSpan(
                    style: TextStyle(fontSize: 20, color: whiteColor),
                    children: [
                      TextSpan(
                        text: '${vehicle.brandName}, ',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      TextSpan(text: vehicle.modelName),
                    ],
                  ),
                );
              },
            ),

            // Icons
            Row(
              children: [
                iconButton(Icons.search_rounded, () => Get.to(SearchScreen())),
                iconButton(
                  Icons.notifications_outlined,
                  () => Get.to(NotificationScreen()),
                ),
                iconButton(
                  Icons.shopping_cart_rounded,
                  () => Get.to(CartScreen()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//------Home Screen App bar------

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
      width: double.infinity,
      height: 185,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [rockBlue, darkTurquoise]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 25, right: 25),
          child: Column(
            children: [
              // Top Row: Welcome and Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Welcome Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello ${user?.displayName ?? 'Guest'},',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Welcome to AutoShine',
                        style: TextStyle(
                          color: whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  // Icons
                  Row(
                    children: [
                      iconButton(
                        Icons.search_rounded,
                        () => Get.to(SearchScreen()),
                      ),
                      iconButton(
                        Icons.notifications_outlined,
                        () => Get.to(NotificationScreen()),
                      ),
                      iconButton(
                        Icons.shopping_cart_rounded,
                        () => Get.to(CartScreen()),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Vehicle section with Add button
              FutureBuilder<VehicleTypeModel?>(
                future: VehicleService.getUserVehicle(user?.uid ?? ''),
                builder: (context, snapshot) {
                  final hasVehicle = snapshot.hasData && snapshot.data != null;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (hasVehicle)
                        Builder(
                          builder: (_) {
                            final vehicle = snapshot.data!;
                            return Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: whiteColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    child:
                                        vehicle.vehicleImagePath.isNotEmpty
                                            ? ClipOval(
                                              child: Image.network(
                                                vehicle.vehicleImagePath,
                                              ),
                                            )
                                            : Opacity(
                                              opacity: 0.4,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  3.0,
                                                ),
                                                child: Image.asset(
                                                  'assets/icons/before_login/suv_black.png',
                                                  fit: BoxFit.cover,
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ),
                                            ),
                                  ),
                                ),
                                const SizedBox(width: 7),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vehicle.brandName,
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        height: 1.1,
                                      ),
                                    ),
                                    Text(
                                      vehicle.modelName,
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 18,
                                        height: 1.1,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      TextButton.icon(
                        onPressed: () => Get.toNamed('/vehicletype'),
                        label: Text('Add Vehicle'),
                        icon: Icon(Icons.add_rounded),
                        style: TextButton.styleFrom(
                          foregroundColor: whiteColor,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget iconButton(IconData icon, VoidCallback navigation) {
  return InkWell(
    onTap: navigation,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(icon, color: whiteColor),
    ),
  );
}
