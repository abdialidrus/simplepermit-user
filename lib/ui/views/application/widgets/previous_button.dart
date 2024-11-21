import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permit_user_app/ui/widgets/common/secondary_small_button/secondary_small_button.dart';

class PreviousButton extends StatelessWidget {
  const PreviousButton({required this.enabled, required this.onTap, super.key});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SecondarySmallButton(
      label: 'Previous'.toUpperCase(),
      onTap: onTap,
      leadingIcon: SvgPicture.asset('assets/icons/icon-arrow-left.svg'),
      enabled: enabled,
    );
  }
}
