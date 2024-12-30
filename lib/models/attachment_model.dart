import 'dart:io';

class AttachmentModel {
  final File file;
  int? id;
  bool isUploading;
  bool isUploadFailed;

  AttachmentModel({
    required this.file,
    this.id,
    this.isUploading = false,
    this.isUploadFailed = false,
  });

  bool get isUploaded => id != null;
}
