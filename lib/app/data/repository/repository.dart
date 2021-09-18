import 'package:tes_transisi/app/data/models/employee.dart';
import 'package:tes_transisi/app/data/service/network_service.dart';
import 'package:tes_transisi/app/data/service/storage_service.dart';

class Repository {
  Future<String> signIn(String email, String password) async {
    try {
      final String token = await NetworkService().signIn(email, password);
      await StorageService().saveAuthToken(token);
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      final String token = await NetworkService().signUp(email, password);
      await StorageService().saveAuthToken(token);
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> retrieveAuthToken() async {
    try {
      String authToken = await StorageService().retrieveAuthToken();
      return authToken;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeAuthToken() async {
    try {
      bool isRemoved = await StorageService().removeAuthToken();
      return isRemoved;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Employee>> getAllEmployee() async {
    try {
      final employeeListRaw = await NetworkService().getAllEmployee();
      // List<Employee> dataBanner =
      //     employeeListRaw['data'].map((e) => Employee.fromJson(e)).toList();
      // List<Employee> employeeList = employeeListRaw['data']
      //     .map((mapEntry) => Employee.fromJson(mapEntry))
      //     .toList();
      List<Employee> employeeList =
          new EmployeeList.fromJson(employeeListRaw['data']).list;
      return employeeList;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> createEmployee(String name, String job) async {
    try {
      Map<String, dynamic> result =
          await NetworkService().createEmployee(name, job);
      return int.parse(result['id']);
    } catch (e) {
      rethrow;
    }
  }

  Future<Employee> getEmployeeDetail(int id) async {
    try {
      Map<String, dynamic> result =
          await NetworkService().getEmployeeDetail(id);
      Employee employee = Employee.fromJson(result);
      return employee;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateEmployeeDetail(int id, String name) async {
    try {
      await NetworkService().updateEmployeeDetail(id, name);
      return true;
    } catch (e) {
      return false;
    }
  }
}
