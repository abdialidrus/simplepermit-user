import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/views/home/widgets/user_type_menu_item.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/simplepermit-logo.png',
                    width: 123,
                    height: 39.21,
                  ),
                  TextButton(
                      onPressed: viewModel.navigateToPrivacyPolicyPage,
                      child: Text(
                        'Privacy Policy',
                        style: ktsSmallBold,
                      )),
                ],
              ),
            ),
            verticalSpaceSmall,
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Select User Type',
                        style: ktsMediumMedium,
                      ),
                      verticalSpaceLarge,
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisExtent: 200,
                          mainAxisSpacing: 16,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) => UserTypeMenuItem(
                          userType: userTypes[index],
                          onTap: (userType) {
                            viewModel.navigateToPermitApplicationPage(userType);
                          },
                        ),
                      ),
                      verticalSpaceLarge,
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

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
