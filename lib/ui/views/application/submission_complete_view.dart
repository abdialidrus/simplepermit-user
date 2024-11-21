import 'package:flutter/material.dart';
import 'package:stacked_permit_user_app/ui/common/app_typography.dart';
import 'package:stacked_permit_user_app/ui/common/ui_helpers.dart';
import 'package:stacked_permit_user_app/ui/widgets/common/main_small_button/main_small_button.dart';

class SubmissionCompleteView extends StatelessWidget {
  const SubmissionCompleteView({super.key, required this.onBackHome});

  final VoidCallback onBackHome;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpaceMedium,
          Text(
            'Thank you! Your application has been successfully submitted.',
            style: ktsExtraLargeSemiBold.copyWith(
              color: const Color(0xFF54595E),
              height: 1.2,
            ),
          ),
          verticalSpaceMedium,
          Text(
            '''
Your application has been received; email confirmation will be sent to you shortly.

Your community will contact you directly for any additional information and when permit is processed.  
 
Replace support@ buildingpermit portal.com  with:  info@simplepect.com
''',
            style: ktsSmallRegular.copyWith(color: const Color(0xFF4F4F4F)),
          ),
          const Spacer(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MainSmallButton(
                label: 'GO BACK TO HOME',
                onTap: onBackHome,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
