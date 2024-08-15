import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfigV2 {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get serverStatusEndpoint => '/v2/_status';
  static String get identifyAllEndpoint => '/v2/identify/all';
}
