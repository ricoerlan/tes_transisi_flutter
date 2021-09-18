import 'dart:convert';
import 'package:dio/dio.dart';

class NetworkService {
  final dio = Dio();
  final baseUrl = "https://reqres.in/api/";

  Future<String> signIn(String email, String password) async {
    try {
      final response = await dio.post(baseUrl + 'login',
          data: FormData.fromMap(({"email": email, "password": password})));
      final responseLogin = jsonDecode(response.data);
      return responseLogin['token'];
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      Response response = await dio.post(baseUrl + 'register',
          data: FormData.fromMap(({"email": email, "password": password})));
      // if (response.statusCode == 200) {
      final responseLogin = jsonDecode(response.data);
      return responseLogin['token'];
      // } else {
      //   final responseLogin = jsonDecode(response.data);
      //   return responseLogin['error'];
      // }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Map<String, dynamic>> getAllEmployee() async {
    try {
      final response = await dio.get(baseUrl + 'users');
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getEmployeeDetail(int id) async {
    try {
      final response = await dio.get(baseUrl + 'users/$id');
      print("cuy ${response.data}");
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createEmployee(String name, String job) async {
    try {
      final response = await dio.post(baseUrl + 'users',
          data: FormData.fromMap(({"name": name, "job": job})));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateEmployeeDetail(int id, String name) async {
    try {
      final response = await dio.post(baseUrl + 'users/$id',
          data: FormData.fromMap(({
            "name": name,
          })));
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
