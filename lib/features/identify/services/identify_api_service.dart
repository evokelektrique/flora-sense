import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flora_sense/features/identify/config/api_config.dart';
import 'package:flora_sense/features/identify/entities/plant_entity.dart';
import 'package:flora_sense/features/identify/exceptions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class IdentifyApiService {
  final Dio dio;

  const IdentifyApiService({required this.dio});

  Future<PlantEntity> identify(File imageFile) async {
    log('API KEY: ${dotenv.env['PLANTNET_API_KEY']}');

    final String url =
        '${ApiConfigV2.baseUrl}${ApiConfigV2.identifyAllEndpoint}?api-key=${dotenv.env['PLANTNET_API_KEY']}';

    if (dotenv.env['PLANTNET_API_KEY']!.isEmpty) {
      throw IdentifyApiException('Failed to identify: EMPTY API KEY');
    }

    final FormData formData = FormData.fromMap(<String, dynamic>{
      'images': [await MultipartFile.fromFile(imageFile.path)],
      'organs': <String>['auto'],
    });

    try {
      final Response<dynamic> response = await dio.post(
        url,
        data: formData,
      );

      final List<dynamic> results = response.data['results'];

      if (results.isEmpty) {
        throw IdentifyApiException('No results found');
      }

      final Map<String, dynamic> firstResult = results.first;

      final Map<String, dynamic> jsonMatch = {
        'name': response.data['bestMatch'],
        'scientificNameWithoutAuthor': firstResult['species']
            ['scientificNameWithoutAuthor'],
        'score': firstResult['score'],
      };

      return PlantEntity.fromJson(jsonMatch);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          // Handling specific HTTP status codes
          switch (e.response!.statusCode) {
            case 401:
              throw IdentifyApiException(
                  'Failed to identify: Unauthorized - ${e.response!.statusCode}');
            case 404:
              throw IdentifyApiException(
                  'Failed to identify: Species Not Found');
            default:
              throw IdentifyApiException(
                  'Failed to identify: ${e.response!.statusCode}');
          }
        } else {
          // Handle network errors or request issues
          throw IdentifyApiException('Network error: ${e.message}');
        }
      } else {
        // Handle unexpected exceptions
        rethrow;
      }
    }
  }

  Future<bool> serverStatus() async {
    try {
      final Response<dynamic> response = await dio
          .get('${ApiConfigV2.baseUrl}${ApiConfigV2.serverStatusEndpoint}');
      if (response.statusCode == 200) {
        final dynamic data = jsonDecode(response.data);
        return data['status'] == 'ok';
      } else {
        throw IdentifyApiException(
            'Failed to check server status: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw IdentifyApiException('Network error: ${e.message}');
      } else {
        rethrow;
      }
    }
  }
}
