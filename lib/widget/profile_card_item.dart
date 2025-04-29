import 'package:autoshine/functions/logout.dart';
import 'package:autoshine/values/colors.dart';
import 'package:autoshine/widget/custom_container.dart';
import 'package:flutter/material.dart';

class ProfileCardItem extends StatelessWidget {
  final VoidCallback? navigation;
  final String title;
  final String iconImagePath;
  const ProfileCardItem({
    super.key,
    this.navigation,
    required this.title,
    required this.iconImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigation,
      child: CustomContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFFBFE3F7),
                    child: Image.asset(iconImagePath, width: 22),
                  ),

                  const SizedBox(width: 15),

                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                ],
              ),

              Icon(Icons.arrow_forward_ios_rounded),
            ],
          ),
        ),
      ),
    );
  }
}

class LogoutCard extends StatelessWidget {
  const LogoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await logoutAlert(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              offset: Offset(0, 0),
              color: Colors.black.withValues(alpha: .2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 17),
          child: Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: const Color(0xFFFFCFB0),
                child: Image.asset(
                  'assets/icons/user profile/logout.png',
                  width: 25,
                ),
              ),

              const SizedBox(width: 15),

              Text(
                'Logout',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color(0xFFFF6C0B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
