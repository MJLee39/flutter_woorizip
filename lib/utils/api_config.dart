import 'package:flutter_dotenv/flutter_dotenv.dart';

String getEnvVariable(String key) {
  final value = dotenv.env[key];
  if (value == null) {
    throw Exception('$key must be set in the environment.');
  }
  return value;
}

class ApiConfig {
  final String apiEndpointUrl;
  final String apiSubfixReadConditionUrl;

  ApiConfig()
      : apiEndpointUrl = getEnvVariable('API_ENDPOINT_URL'),
        apiSubfixReadConditionUrl = getEnvVariable('API_SUBFIX_READCONDITION_URL');
}
