import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flora_sense/features/identify/config/api_config.dart';
import 'package:flora_sense/features/identify/entities/plant_entity.dart';
import 'package:flora_sense/features/identify/exceptions.dart';
import 'package:flora_sense/features/identify/repositories/identify_repository.dart';
import 'package:flora_sense/features/identify/services/identify_api_service.dart';
import 'package:flora_sense/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'identify_api_test.mocks.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks(<Type>[Dio, File])
void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    // Load environment variables
    await dotenv.load(fileName: '.env');

    setupServiceLocators();
  });

  group('identifyRepository', () {
    late MockDio mockDio;
    late IdentifyRepository identifyRepository;
    late MockFile mockFile;

    setUp(() {
      mockDio = MockDio();

      final IdentifyApiService identifyApiService =
          IdentifyApiService(dio: mockDio);
      identifyRepository =
          IdentifyRepository(identifyApiService: identifyApiService);

      mockFile = MockFile();

      when(mockFile.path).thenReturn('assets/images/icons/natural-food.png');
    });

    test(
        'serverStatus - returns a boolean (true) if the http call completes successfully',
        () async {
      final String url =
          '${ApiConfigV2.baseUrl}${ApiConfigV2.serverStatusEndpoint}';
      when(mockDio.get(url))
          .thenAnswer((_) => Future<Response<dynamic>>.value(Response<dynamic>(
                requestOptions: RequestOptions(path: url),
                data: '{"status": "ok"}',
                statusCode: 200,
              )));

      expect(await identifyRepository.serverStatus(), isTrue);
    });

    test(
        'serverStatus - throws an IdentifyApiException if the http call completes with an error',
        () async {
      final String url =
          '${ApiConfigV2.baseUrl}${ApiConfigV2.serverStatusEndpoint}';
      when(mockDio.get(url))
          .thenAnswer((_) => Future<Response<dynamic>>.value(Response<dynamic>(
                requestOptions: RequestOptions(path: url),
                data: {},
                statusCode: 404,
              )));

      expect(() async => await identifyRepository.serverStatus(),
          throwsA(isA<IdentifyApiException>()));
    });

    test(
        'identify - returns a PlantEntity if the http call completes successfully',
        () async {
      final String jsonString = generateMockIdentifyResultJson();

      // Mock the post method to return a response for a multipart request
      final String url =
          '${ApiConfigV2.baseUrl}${ApiConfigV2.identifyAllEndpoint}?api-key=${dotenv.env['PLANTNET_API_KEY']}';

      when(mockDio.post(
        url,
        data: anyNamed('data'),
        options: anyNamed('options'),
      )).thenAnswer((_) async => Response<dynamic>(
            requestOptions: RequestOptions(
              path: url,
              method: 'POST',
            ),
            data: jsonString,
            statusCode: 200,
          ));

      final PlantEntity result = await identifyRepository.identify(mockFile);
      expect(result, isA<PlantEntity>());
    });
  });
}

String generateMockIdentifyResultJson() {
  final Map<String, dynamic> mockIdentifyResult = {
    "query": {
      "project": "all",
      "images": ["cc2ddeff6a93628781a8638435b05e4d"],
      "organs": ["auto"],
      "includeRelatedImages": true,
      "noReject": false
    },
    "language": "fa",
    "preferedReferential": "k-world-flora",
    "bestMatch": "Plumeria pudica Jacq.",
    "results": [
      {
        "score": 0.81218,
        "species": {
          "scientificNameWithoutAuthor": "Plumeria pudica",
          "scientificNameAuthorship": "Jacq.",
          "genus": {
            "scientificNameWithoutAuthor": "Plumeria",
            "scientificNameAuthorship": "",
            "scientificName": "Plumeria"
          },
          "family": {
            "scientificNameWithoutAuthor": "Apocynaceae",
            "scientificNameAuthorship": "",
            "scientificName": "Apocynaceae"
          },
          "commonNames": [],
          "scientificName": "Plumeria pudica Jacq."
        },
        "images": [
          {
            "organ": "flower",
            "author": "Tony Farrick",
            "license": "cc-by-sa",
            "date": {"timestamp": 1659233042063, "string": "۳۱ ژوئیه ۲۰۲۲"},
            "url": {
              "o":
                  "https://bs.plantnet.org/image/o/662dc28f9e8e9c4c479fb783ab96a28c38fcdb69",
              "m":
                  "https://bs.plantnet.org/image/m/662dc28f9e8e9c4c479fb783ab96a28c38fcdb69",
              "s":
                  "https://bs.plantnet.org/image/s/662dc28f9e8e9c4c479fb783ab96a28c38fcdb69"
            },
            "citation": "Tony Farrick / Pl@ntNet, cc-by-sa"
          },
          {
            "organ": "flower",
            "author": "Mejía Villavicencio Samuel",
            "license": "cc-by-sa",
            "date": {"timestamp": 1698063196009, "string": "۲۳ اکتبر ۲۰۲۳"},
            "url": {
              "o":
                  "https://bs.plantnet.org/image/o/50b80469245dcd505395ba078c53398984fae315",
              "m":
                  "https://bs.plantnet.org/image/m/50b80469245dcd505395ba078c53398984fae315",
              "s":
                  "https://bs.plantnet.org/image/s/50b80469245dcd505395ba078c53398984fae315"
            },
            "citation": "Mejía Villavicencio Samuel / Pl@ntNet, cc-by-sa"
          },
          // Add more images as needed
        ],
        "gbif": {"id": "3614691"},
        "powo": {"id": "81268-1"},
        "iucn": {"id": "151953739", "category": "LC"}
      },
      {
        "score": 0.02172,
        "species": {
          "scientificNameWithoutAuthor": "Plumeria alba",
          "scientificNameAuthorship": "L.",
          "genus": {
            "scientificNameWithoutAuthor": "Plumeria",
            "scientificNameAuthorship": "",
            "scientificName": "Plumeria"
          },
          "family": {
            "scientificNameWithoutAuthor": "Apocynaceae",
            "scientificNameAuthorship": "",
            "scientificName": "Apocynaceae"
          },
          "commonNames": [],
          "scientificName": "Plumeria alba L."
        },
        "images": [
          {
            "organ": "flower",
            "author": "Malachias Katia",
            "license": "cc-by-sa",
            "date": {"timestamp": 1673283094558, "string": "۹ ژانویه ۲۰۲۳"},
            "url": {
              "o":
                  "https://bs.plantnet.org/image/o/f03520b66a7ac6a83f1ef6e52359360d0656af66",
              "m":
                  "https://bs.plantnet.org/image/m/f03520b66a7ac6a83f1ef6e52359360d0656af66",
              "s":
                  "https://bs.plantnet.org/image/s/f03520b66a7ac6a83f1ef6e52359360d0656af66"
            },
            "citation": "Malachias Katia / Pl@ntNet, cc-by-sa"
          },
          // Add more images as needed
        ],
        "gbif": {"id": "3169673"},
        "powo": {"id": "81171-1"},
        "iucn": {"id": "208165050", "category": "LC"}
      },
      // Add more results as needed
    ],
    "version": "2024-05-30 (7.1)"
  };

  return jsonEncode(mockIdentifyResult);
}
