import 'package:flutter/material.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/widgets/common/main_button/main_button.dart';

class MainSmallButton extends StatelessWidget {
  const MainSmallButton({
    required this.label,
    required this.onTap,
    super.key,
    this.trailingIcon,
    this.leadingIcon,
    this.enabled = true,
    this.backgroundColor,
  });

  final VoidCallback? onTap;
  final String label;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool? enabled;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return MainButton(
      onTap: onTap,
      label: label,
      cornerRadius: 8,
      paddingTop: 10,
      paddingBottom: 10,
      paddingLeft: 16,
      paddingRight: 16,
      labelStyle: ktsSmallMedium.copyWith(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      trailingIcon: trailingIcon,
      leadingIcon: leadingIcon,
      enabled: enabled,
    );
  }
}
