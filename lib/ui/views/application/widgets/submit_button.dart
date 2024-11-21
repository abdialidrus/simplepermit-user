import 'package:flutter/material.dart';
import 'package:stacked_permit_user_app/ui/widgets/common/main_small_button/main_small_button.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({required this.enabled, required this.onTap, super.key});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MainSmallButton(
      label: 'SUBMIT',
      onTap: onTap,
      enabled: enabled,
    );
  }
}
