import 'dart:io';
import 'package:dio/dio.dart';
import 'package:permit_user_app/app/app.logger.dart';
import 'package:permit_user_app/models/application_model.dart';
import 'package:permit_user_app/models/community_model.dart';
import 'package:permit_user_app/models/location_model.dart';

class ApplicationService {
  final log = getLogger('ApplicationService');

  final _dio = Dio();

  final String baseUrl = 'https://permit-api.brainfuelstation.com/api';

  final Map<String, dynamic> sampleCommunityResponse = {
    "success": true,
    "data": [
      {
        "communityId": 1,
        "communityName": "My Community",
        "workEmail": "contact@community.com",
        "phoneNumber": "1234567890",
        "state": "California",
        "city": "Los Angeles",
        "country": "USA",
        "zipcode": "90001",
        "street": "123 Community St",
        "region": "Region Name",
        "permitType": "Type A",
        "status": "Approved",
        "userId": 1
      }
    ],
    "pagination": {
      "totalCount": 20,
      "totalPages": 2,
      "currentPage": 1,
      "pageSize": 10
    }
  };

  Future<List<CommunityModel>> getNearbyCommunities(
      LocationModel locationModel) async {
    try {
      final endpoint = '$baseUrl/communities/nearby';
      final payload = {
        'state': locationModel.state,
        'city': locationModel.city,
        'country': locationModel.country,
        'street': locationModel.street,
        'permitType': locationModel.permitType,
      };

      final response = await _dio.post(endpoint, data: payload);

      if (response.statusCode == 200) {
        if (response.data['success'] != true) {
          throw Exception('Failed to get nearby communities');
        }

        final data = response.data['data'] as List;

        return data.map((e) => CommunityModel.fromJson(e)).toList();
      } else {
        log.e('Failed to get nearby communities: ${response.statusCode}');
        log.e(response.data);
        throw Exception('Failed to get nearby communities');
      }
    } catch (e) {
      log.e(e);
      throw Exception('Failed to get nearby communities');
    }
  }

  Future<void> submitApplication(ApplicationModel application) async {
    try {
      final endpoint = '$baseUrl/application';
      final payload = application.toJson();
      final response = await _dio.post(endpoint, data: payload);

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

  Future<List<int>> uploadDocuments(File file) async {
    try {
      final uploadUrl = '$baseUrl/attachments/upload-files';

      // Prepare the form data
      FormData formData = FormData();
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
