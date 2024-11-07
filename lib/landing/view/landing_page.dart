import 'package:flutter/material.dart';
import 'package:simple_permit_user/common/widgets/main_large_button.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/landing-background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: const Color(0x800C0C26),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 48,
                horizontal: 24,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Streamline Your Permit \n Process',
                    style: ktsDisplaySmallSemiBold.copyWith(
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // ignore: lines_longer_than_80_chars
                    "Whether you're building a new home, renovating, or managing a commercial project, our easy-to-use portal helps you find, apply, and track your permits.",
                    style: ktsSmallRegular.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 12,
                      color: const Color(0xFF939393),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  MainLargeButton(
                    label: 'Get Started',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
