import 'package:flutter/material.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/views/privacy_policy/widgets/privacy_policy_section.dart';
import 'package:stacked/stacked.dart';

import 'privacy_policy_viewmodel.dart';

class PrivacyPolicyView extends StackedView<PrivacyPolicyViewModel> {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PrivacyPolicyViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: ktsMediumSemiBold,
        ),
        centerTitle: false,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              verticalSpaceMedium,
              PrivacyPolicySection(
                title: 'Introduction',
                description:
                    'This Privacy Policy explains how we collect, use, and share information about users of our software and mobile application available through our website, Apple App Store, and Google Play Store. By using our site and app, you consent to our collection, use, and sharing of your information as described in this Privacy Policy.',
              ),
              verticalSpaceLarge,
              PrivacyPolicySection(
                title: 'Information We Collect:',
                description: '''
We may collect the following information about you when you use our app:
1.	Personal Information: We may collect your name, email address, phone number, and other personal information you provide when you register for our software and app, use our services, or contact us for support. 
2.	Usage Information: We may collect information about your usage of our software and app, such as the features you use, the pages you visit, the time and date of your visit, and your IP address. 
3.	Device Information: We may collect information about the device you use to access our software and app, such as the device type, operating system, and mobile network information.''',
              ),
              verticalSpaceLarge,
              PrivacyPolicySection(
                title: 'How We Use Your Information:',
                description: '''
We may use the information we collect for the following purposes:
1.	To provide our services to you and improve our software and app’s functionality. 
2.	To communicate with you about our software and app, including sending you promotional materials and updates. 
3.	To personalize your experience with our software and app, including providing you with customized content. 
4.	To analyze and improve the effectiveness of our software and app, including troubleshooting problems and performing data analysis.''',
              ),
              verticalSpaceLarge,
              PrivacyPolicySection(
                title: 'How We Share Your Information:',
                description: '''
We may share your information with third-party service providers who help us provide our software and app and services to you, such as analytics providers, email providers, and customer service providers.
We may also share your information if required by law or to protect our legal rights, such as in response to a court order or subpoena.
We will never sell your information to third parties for marketing purposes.''',
              ),
              verticalSpaceLarge,
              PrivacyPolicySection(
                title: 'Your Choices:',
                description: '''
You can opt-out of receiving promotional emails from us by following the instructions in the email or by contacting us at info@simplepermit.io.
You can also adjust your device settings to limit our collection and use of your information. Please note that if you limit our collection and use of your information, some features of our software and app may not work correctly.''',
              ),
              verticalSpaceLarge,
              PrivacyPolicySection(
                title: 'Data Retention:',
                description: '''
We will retain your information for as long as necessary to provide our software and app and services to you, or as required by law.''',
              ),
              verticalSpaceLarge,
              PrivacyPolicySection(
                title: 'Security:',
                description: '''
We take reasonable measures to protect your information from unauthorized access, disclosure, or modification. However, no data transmission over the internet can be guaranteed to be completely secure. Therefore, we cannot guarantee the security of your information.''',
              ),
              verticalSpaceLarge,
              PrivacyPolicySection(
                title: 'Changes to this Privacy Policy:',
                description: '''
We may update this Privacy Policy from time to time. If we make material changes, we will notify you by email or by posting a notice in our app. Your continued use of our software, website, and app after we make changes to this Privacy Policy will signify your acceptance of the new terms.''',
              ),
              verticalSpaceLarge,
              PrivacyPolicySection(
                title: 'Contact Us:',
                description: '''
If you have any questions or concerns about our Privacy Policy or our software, website, and app, please contact us at info@simplepermit.io.''',
              ),
              verticalSpaceLarge,
            ],
          ),
        ),
      ),
    );
  }

  @override
  PrivacyPolicyViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PrivacyPolicyViewModel();
}
