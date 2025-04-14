import 'package:autoshine/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      headerBackgroundColor: Colors.white,
      centerBackground: true,
      skipTextButton: Text(
        'Skip',
        style: TextStyle(color: blackColor, fontSize: 17),
      ),
      hasFloatingButton: false,
      trailing: Text(
        'Login',
        style: TextStyle(color: blackColor, fontSize: 17),
      ),
      trailingFunction: () => Navigator.pushReplacementNamed(context, '/login'),
      controllerColor: blackColor,

      background: [
        Image.asset('assets/others/splash.png'),
        Image.asset('assets/others/accessories.png'),
        Image.asset('assets/others/online-shop.png'),

        Image.asset('assets/others/car-wash.png'),
      ],
      totalPage: 4,
      speed: 1.8,
      pageBodies: [
        content(
          title: 'Sparkling Clean Rides',
          desc:
              'Fast, easy, and reliable car wash services at your fingertips!',
        ),
        content(
          title: 'Quality Assured',
          desc: 'Browse and buy car accessories anytime, anywhere.',
        ),
        content(
          title: 'Shop with Ease',
          desc: 'Top-notch products delivered to your door.',
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              SizedBox(height: 450),
              Text(
                'Welcome to',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 7),
              Text(
                'AutoShine',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
              ),
              Text(
                'Book Your Car Wash',
                style: GoogleFonts.allura(fontSize: 26, height: .9),
              ),
              const SizedBox(height: 50),

              InkWell(
                onTap: () => Navigator.pushReplacementNamed(context, '/login'),
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [rockBlue, darkTurquoise]),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Let's Start",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container content({required String title, required String desc}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(height: 480),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 25),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 19),
          ),
        ],
      ),
    );
  }
}
