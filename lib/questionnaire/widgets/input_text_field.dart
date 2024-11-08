import 'package:flutter/material.dart';
import 'package:simple_permit_user/theme/text_styles.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    this.label,
    this.hint,
    this.maxLines = 1,
  });

  final String? label;
  final String? hint;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          Text(
            label!,
            style: ktsLabelRegular,
          ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          minLines: maxLines,
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
          ),
        ),
      ],
    );
  }
}
