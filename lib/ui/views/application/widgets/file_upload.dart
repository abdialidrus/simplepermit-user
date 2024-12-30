import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permit_user_app/models/attachment_model.dart';
import 'package:permit_user_app/ui/common/app_colors.dart';
import 'package:permit_user_app/ui/common/app_typography.dart';
import 'package:permit_user_app/ui/common/ui_helpers.dart';
import 'package:permit_user_app/ui/widgets/common/text_with_mid_ellipsis/text_with_mid_ellipsis.dart';
import 'package:permit_user_app/utils/file.dart';

class FileUpload extends StatelessWidget {
  const FileUpload({
    super.key,
    required this.onPickDocuments,
    required this.attachments,
    required this.onUploadButtonTap,
    required this.areDocumentsUploaded,
    required this.onDocumentDeleteTap,
    required this.onUploadAttachment,
  });

  final VoidCallback? onPickDocuments;
  final List<AttachmentModel> attachments;
  final VoidCallback onUploadButtonTap;
  final bool areDocumentsUploaded;
  final void Function(AttachmentModel) onDocumentDeleteTap;
  final void Function(AttachmentModel) onUploadAttachment;

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
                    if (attachments.isEmpty)
                      Text(
                        'No files selected',
                        style: ktsSmallRegular,
                      ),
                    ...attachments.map(
                      (e) {
                        return Row(
                          children: [
                            Expanded(
                              child: TextWithMidEllipsis(
                                FileUtils.getFileNameFromPath(e.file.path),
                                style: ktsSmallRegular,
                              ),
                            ),
                            horizontalSpaceSmall,
                            if (e.isUploading)
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(),
                              )
                            else
                              Row(
                                children: [
                                  if (e.isUploaded && !areDocumentsUploaded)
                                    const Icon(Icons.check_circle_rounded),
                                  // if (!e.isUploaded)
                                  //   IconButton(
                                  //     onPressed: () => onUploadAttachment(e),
                                  //     icon: const Icon(
                                  //       Icons.file_upload_rounded,
                                  //       size: 20,
                                  //     ),
                                  //     visualDensity: VisualDensity.compact,
                                  //   ),
                                  IconButton(
                                    onPressed: () => onDocumentDeleteTap(e),
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      size: 20,
                                    ),
                                    visualDensity: VisualDensity.compact,
                                  )
                                ],
                              )
                          ],
                        );
                      },
                    ),
                    if (attachments.isNotEmpty && areDocumentsUploaded) ...[
                      verticalSpaceMedium,
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Text(
                            'All documents uploaded',
                            style: ktsSmallRegular,
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.check_circle_rounded,
                            color: Colors.green,
                          ),
                          const Spacer()
                        ],
                      )
                      // else
                      //   SecondarySmallButton(
                      //     label: 'Upload all documents',
                      //     onTap: onUploadButtonTap,
                      //     enabled: !isAnyUploading && !areDocumentsUploaded,
                      //   ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
