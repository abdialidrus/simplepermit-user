import 'dart:io';
import 'package:dio/dio.dart';
import 'package:stacked_permit_user_app/app/app.logger.dart';
import 'package:stacked_permit_user_app/models/application_model.dart';

class ApplicationService {
  final log = getLogger('ApplicationService');

  final _dio = Dio();

  Future<void> submitApplication(ApplicationModel application) async {
    try {
      const endpoint =
          'https://permit-api.brainfuelstation.com/api/application';
      final response = await _dio.post(endpoint, data: application.toJson());

      if (response.statusCode == 200) {
        log.i('Application submitted successfully');
      } else {
        log.e('Failed to submit application: ${response.statusCode}');
        log.e(response.data);
        throw Exception('Failed to submit application');
      }
    } catch (e) {
      log.e(e);
      throw Exception('Failed to submit application');
    }
  }

  Future<List<int>> uploadDocuments(List<File> files) async {
    try {
      const uploadUrl =
          'https://permit-api.brainfuelstation.com/api/attachments/upload-files';

      // Prepare the form data
      FormData formData = FormData();
      for (var file in files) {
        if (file.existsSync()) {
          formData.files.add(
            MapEntry(
              'files', // Replace 'files' with your server's expected key
              await MultipartFile.fromFile(
                file.path,
                filename: file.path.split('/').last, // Extract the filename
              ),
            ),
          );
        }
      }

      // Make the POST request
      Response response = await _dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type':
                'multipart/form-data', // Optional, automatically set by Dio
          },
        ),
      );

      // Handle the response
      if (response.statusCode == 200) {
        log.i('Files uploaded successfully');
        log.i(response.data);

        if (response.data['success'] != true) {
          throw Exception('Failed to upload files');
        }

        List<dynamic> dynamicIdList = response.data['documentIds'];

        return dynamicIdList.map((dynamicId) => dynamicId as int).toList();
      } else {
        log.e('Failed to upload files: ${response.statusCode}');
        log.e(response.data);

        throw Exception('Failed to upload files');
      }
    } catch (e) {
      log.e(e);
      throw Exception('Failed to upload files');
    }
  }
}
