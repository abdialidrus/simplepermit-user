import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permit_user_app/ui/widgets/common/main_small_button/main_small_button.dart';

class NextButton extends StatelessWidget {
  const NextButton({required this.enabled, required this.onTap, super.key});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MainSmallButton(
      label: 'Next'.toUpperCase(),
      onTap: onTap,
      trailingIcon: SvgPicture.asset('assets/icons/icon-arrow-right.svg'),
      enabled: enabled,
    );
  }
}
