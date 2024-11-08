import 'package:flutter/material.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class FormTitleLarge extends StatelessWidget {
  const FormTitleLarge({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title.toUpperCase(),
          style: ktsLargeMedium,
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: ktsSmallRegular.copyWith(
            color: const Color(0xFF667085),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
