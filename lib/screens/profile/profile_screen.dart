import 'package:autoshine/screens/profile/saved_address.dart';
import 'package:autoshine/screens/profile/terms_contitions.dart';
import 'package:autoshine/screens/profile/wishlist.dart';
import 'package:autoshine/screens/support_screen.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_app_bar.dart';
import 'package:autoshine/widget/profile_card_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: Column(
        children: [
          CustomAppBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                child: Column(
                  children: [
                    Card(
                      color: whiteColor,
                      elevation: 7,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Image.asset(
                                'assets/icons/person male.png',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user?.displayName ?? 'Guest',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    user?.email ?? '',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 35),

                    //-----Saved Address
                    ProfileCardItem(
                      navigation: () => Get.to(SavedAddress()),
                      title: 'Saved Address',
                      iconImagePath: 'assets/icons/user profile/address.png',
                    ),

                    const SizedBox(height: 10),

                    //-----Location Permission
                    ProfileCardItem(
                      title: 'Location Permission',
                      iconImagePath: 'assets/icons/user profile/location.png',
                    ),

                    const SizedBox(height: 10),

                    //-----Wishlist
                    ProfileCardItem(
                      navigation: () => Get.to(Wishlist()),
                      title: 'WishList',
                      iconImagePath: 'assets/icons/user profile/wishlist.png',
                    ),

                    const SizedBox(height: 10),

                    //-----Terms and Conditions
                    ProfileCardItem(
                      navigation: () => Get.to(TermsContitions()),
                      title: 'Terms and Conditions',
                      iconImagePath: 'assets/icons/user profile/terms.png',
                    ),

                    const SizedBox(height: 10),

                    //-----Contact Support
                    ProfileCardItem(
                      navigation: () => Get.to(SupportScreen()),
                      title: 'Contact Support',
                      iconImagePath: 'assets/icons/user profile/support.png',
                    ),

                    const SizedBox(height: 25),

                    //-----Logout
                    LogoutCard(),
                    const SizedBox(height: 15),
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
