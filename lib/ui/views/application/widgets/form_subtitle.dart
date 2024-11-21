import 'package:flutter/material.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';

class FormSubtitle extends StatelessWidget {
  const FormSubtitle({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: ktsSmallMedium,
    );
  }
}
