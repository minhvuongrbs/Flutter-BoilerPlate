import 'package:dio/dio.dart';
import 'package:gamerdual_flutter/services/locator.dart';
import 'package:gamerdual_flutter/services/network/api_service.dart';

class UserController {
  UserController() : apiClient = apiService.client;

  Dio apiClient;
  static ApiService apiService = locator<ApiService>();

}
