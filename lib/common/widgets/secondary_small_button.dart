import 'package:flutter/material.dart';
import 'package:simple_permit_user/common/widgets/main_button.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class SecondarySmallButton extends StatelessWidget {
  const SecondarySmallButton({
    required this.label,
    required this.onTap,
    super.key,
    this.trailingIcon,
    this.leadingIcon,
    this.enabled = true,
  });

  final VoidCallback? onTap;
  final String label;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool? enabled;

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
      backgroundColor: Theme.of(context).colorScheme.secondary,
      trailingIcon: trailingIcon,
      leadingIcon: leadingIcon,
      enabled: enabled,
    );
  }
}
