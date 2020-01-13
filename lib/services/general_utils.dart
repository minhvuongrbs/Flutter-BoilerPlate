import 'shared_pref/shared_pref.dart';

Future<String> getAuthToken() async {
  final String authToken = SharedPref.sharedPref.getString(AUTH_TOKEN);
  return authToken;
}
