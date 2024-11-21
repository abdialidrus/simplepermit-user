import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import 'package:permit_user_app/ui/common/app_colors.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/widgets/common/secondary_small_button/secondary_small_button.dart';

class FileUpload extends StatelessWidget {
  const FileUpload({
    super.key,
    required this.onPickDocuments,
    required this.documentPaths,
  });

  final VoidCallback? onPickDocuments;
  final List<String> documentPaths;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          color: kcBlue,
          dashPattern: const [6],
          strokeWidth: 2,
          strokeCap: StrokeCap.round,
          radius: const Radius.circular(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.17,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset('assets/icons/upload-file-cloud.svg'),
                    verticalSpaceSmall,
                    RichText(
                      text: TextSpan(
                        style: ktsSmallRegular.copyWith(color: Colors.black),
                        children: [
                          const TextSpan(
                            text: 'Drag your file(s) or ',
                          ),
                          TextSpan(
                            text: 'browse',
                            style: ktsSmallSemiBold.copyWith(color: kcBlue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = onPickDocuments,
                          ),
                        ],
                      ),
                    ),
                    verticalSpaceTiny,
                    Text(
                      'Max 10 MB files are allowed',
                      style: ktsSmallRegular.copyWith(color: kcGrey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        verticalSpaceTiny,
        Text(
          'Only support .pdf file',
          style: ktsSmallRegular.copyWith(color: kcGrey),
        ),
        verticalSpaceSmall,
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(color: kcBlue),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (documentPaths.isEmpty)
                      Text(
                        'No files selected',
                        style: ktsSmallRegular,
                      ),
                    ...documentPaths.map(
                      (e) => SizedBox(
                        height: 20,
                        child: Marquee(
                          text: e,
                          style: ktsSmallRegular,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpaceSmall,
              SecondarySmallButton(
                label: 'Upload',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
