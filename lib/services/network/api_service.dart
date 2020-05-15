import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/services/shared_pref/shared_pref.dart';

const BASE_URL = 'https://dev-api.timtour.vn/api/v1';

class ApiService {
  ApiService() {
    client = Dio();
    client.options.baseUrl = BASE_URL;
    client.options.connectTimeout = 5000;
    client.options.receiveTimeout = 30000;
    client.options.followRedirects = false;
    client.options.validateStatus = (status) {
      return status < 500;
    };
  }

  Dio client;

  void setToken(String authToken) {
    client.options.headers['Authorization'] = 'Bearer $authToken';
  }

  Future<void> clientSetup() async {
    final String authToken = SharedPref.sharedPref.getString(AUTH_TOKEN);
    if (authToken.isNotEmpty)
      client.options.headers['Authorization'] = 'Bearer $authToken';
  }
}
