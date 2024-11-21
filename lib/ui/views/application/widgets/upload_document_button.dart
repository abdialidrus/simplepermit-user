import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';

class UploadDocumentButton extends StatelessWidget {
  const UploadDocumentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF495AFF),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/icon-document-upload.svg',
          ),
          const SizedBox(width: 4),
          Text(
            'UPLOAD',
            style: ktsLabelMedium.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
