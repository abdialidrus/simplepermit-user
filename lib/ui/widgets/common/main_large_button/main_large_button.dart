import 'package:flutter/material.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/widgets/common/main_button/main_button.dart';

class MainLargeButton extends StatelessWidget {
  const MainLargeButton({
    required this.label,
    required this.onTap,
    super.key,
  });

  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MainButton(
      onTap: onTap,
      label: label,
      cornerRadius: 14,
      paddingTop: 16,
      paddingBottom: 16,
      paddingLeft: 16,
      paddingRight: 16,
      labelStyle: ktsSmallSemiBold.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      trailingIcon: null,
      leadingIcon: null,
    );
  }
}
