import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/widgets/common/main_large_button/main_large_button.dart';

import 'landing_viewmodel.dart';

class LandingView extends StackedView<LandingViewModel> {
  const LandingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LandingViewModel viewModel,
    Widget? child,
  ) {
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
                  verticalSpaceMassive,
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
                    onTap: () {
                      viewModel.navigateToHomePage();
                    },
                  ),
                  verticalSpaceMassive,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  LandingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LandingViewModel();
}
