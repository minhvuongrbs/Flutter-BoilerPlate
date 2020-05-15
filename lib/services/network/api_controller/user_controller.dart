import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/services/locator.dart';

import '../api_service.dart';

class UserController {
  UserController() : apiClient = apiService.client;

  Dio apiClient;
  static ApiService apiService = locator<ApiService>();

}
