import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_transisi/app/data/models/employee.dart';
import 'package:tes_transisi/app/data/repository/repository.dart';
import 'package:tes_transisi/app/modules/controller/home/HomePageController.dart';

class DetailEmployeePageController extends GetxController {
  final Repository repository;
  DetailEmployeePageController({required this.repository});

  Rx<Employee> _employee = Employee().obs;
  RxString _name = ''.obs;
  RxString _email = ''.obs;
  RxBool _isEnable = false.obs;
  Rx<Icon> _icon = Icon(Icons.edit).obs;

  Employee get employee => _employee.value;
  String get name => _name.value;
  String get email => _email.value;
  bool get isEnable => _isEnable.value;
  Icon get icon => _icon.value;
  set updateEmployee(Employee employee) => this._employee.value = employee;
  set updateName(String name) => this._name.value = name;
  set updateEmail(String email) => this._email.value = email;
  set updateIsEnable(bool isEnable) => this._isEnable.value = isEnable;
  set updateIcon(Icon icon) => this._icon.value = icon;

  Future<bool> updateEmployeeDetail(int id) async {
    try {
      await repository.updateEmployeeDetail(id, name);
      List<Employee> listEmployee =
          await Get.find<HomePageController>().getAllEmployee();
      for (int i = 0; i < listEmployee.length; i++) {
        if (listEmployee[i].id == id) {
          listEmployee[i].name = name;
        }

        Get.find<HomePageController>().updateEmployeeList = listEmployee;
      }
      Get.snackbar('Berhasil Merubah Data', '');
      return true;
    } catch (e) {
      Get.snackbar('Merubah Data Gagal', '');
      return false;
    }
  }
}
