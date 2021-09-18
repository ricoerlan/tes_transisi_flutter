import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  saveAuthToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      preferences.setString("token", token);
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> retrieveAuthToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      String token = preferences.getString("token")!;
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeAuthToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      await preferences.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}
