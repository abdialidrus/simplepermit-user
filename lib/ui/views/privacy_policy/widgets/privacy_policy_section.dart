import 'package:flutter/material.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';

class PrivacyPolicySection extends StatelessWidget {
  const PrivacyPolicySection(
      {super.key, required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: ktsLargeSemiBold,
        ),
        verticalSpaceExtraSmall,
        Text(
          description,
          style: ktsSmallRegular,
        ),
      ],
    );
  }
}
