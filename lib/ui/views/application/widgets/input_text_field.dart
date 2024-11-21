import 'package:flutter/material.dart';
import 'package:stacked_permit_user_app/ui/common/app_typography.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.label,
    this.hint,
    this.maxLines = 1,
    this.showSuffixArrow = false,
  });

  final String? label;
  final String? hint;
  final String? Function(String?)? validator;
  final int? maxLines;
  final bool showSuffixArrow;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          decoration: InputDecoration(
            hintText: hint ?? label,
            hintStyle: ktsSmallRegular.copyWith(color: const Color(0x80000000)),
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(6),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(6),
            ),
            suffixIcon:
                showSuffixArrow ? const Icon(Icons.chevron_right) : null,
          ),
        ),
      ],
    );
  }
}
