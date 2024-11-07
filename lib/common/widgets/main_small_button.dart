import 'package:flutter/material.dart';
import 'package:simple_permit_user/common/widgets/main_button.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class MainSmallButton extends StatelessWidget {
  const MainSmallButton({
    required this.label,
    required this.onTap,
    super.key,
    this.trailingIcon,
    this.leadingIcon,
  });

  final VoidCallback? onTap;
  final String label;
  final Widget? leadingIcon;
  final Widget? trailingIcon;

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
      backgroundColor: Theme.of(context).colorScheme.primary,
      trailingIcon: trailingIcon,
      leadingIcon: leadingIcon,
    );
  }
}
