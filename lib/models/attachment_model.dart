import 'dart:io';

class AttachmentModel {
  final File file;
  int? id;
  bool isUploading;
  bool isUploaded;
  bool isUploadFailed;

  AttachmentModel({
    required this.file,
    this.id,
    this.isUploading = false,
    this.isUploaded = false,
    this.isUploadFailed = false,
  });
}
