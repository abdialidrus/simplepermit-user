import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    required this.onTap,
    required this.label,
    required this.cornerRadius,
    required this.paddingTop,
    required this.paddingBottom,
    required this.paddingLeft,
    required this.paddingRight,
    required this.labelStyle,
    required this.backgroundColor,
    required this.leadingIcon,
    required this.trailingIcon,
    super.key,
    this.enabled = true,
  });

  final VoidCallback? onTap;
  final String label;
  final TextStyle labelStyle;
  final double cornerRadius;
  final double paddingTop;
  final double paddingBottom;
  final double paddingLeft;
  final double paddingRight;
  final Color backgroundColor;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled! ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: enabled! ? backgroundColor : Colors.grey.shade500,
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
        ),
        padding: EdgeInsets.only(
          top: paddingTop,
          bottom: paddingBottom,
          left: paddingLeft,
          right: paddingRight,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leadingIcon != null) ...[
                leadingIcon!,
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: labelStyle,
              ),
              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                trailingIcon!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
