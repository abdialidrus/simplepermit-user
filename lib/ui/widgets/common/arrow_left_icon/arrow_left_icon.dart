import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ArrowLeftIcon extends StatelessWidget {
  const ArrowLeftIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/icon-arrow-left.svg',
      width: 17.5,
      height: 13.5,
    );
  }
}
