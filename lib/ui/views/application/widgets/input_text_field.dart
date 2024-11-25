import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.label,
    this.hint,
    this.maxLines = 1,
    this.showSuffixArrow = false,
    this.enabled = true,
    this.onTap,
    this.digitsOnly = false,
    this.keyboardType = TextInputType.text,
  });

  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool showSuffixArrow;
  final TextEditingController controller;
  final bool? enabled;
  final VoidCallback? onTap;
  final bool? digitsOnly;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (label != null) ...[
            Text(
              label!,
              style: ktsLabelRegular,
            ),
            const SizedBox(height: 6),
          ],
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            minLines: maxLines,
            validator: validator,
            enabled: enabled,
            keyboardType: keyboardType,
            inputFormatters: [
              if (digitsOnly!) FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              hintText: hint ?? label,
              hintStyle:
                  ktsSmallRegular.copyWith(color: const Color(0x80000000)),
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(6),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(6),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(6),
              ),
              suffixIcon:
                  showSuffixArrow ? const Icon(Icons.chevron_right) : null,
            ),
          ),
        ],
      ),
    );
  }
}
