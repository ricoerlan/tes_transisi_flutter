import 'dart:io';

import 'package:get/get.dart';
import 'package:tes_transisi/app/data/models/employee.dart';
import 'package:tes_transisi/app/data/repository/repository.dart';
import 'package:tes_transisi/app/modules/controller/home/HomePageController.dart';

class CreateEmployeePageController extends GetxController {
  final Repository repository;
  CreateEmployeePageController({required this.repository});

  RxString _name = ''.obs;
  RxString _job = ''.obs;
  RxString _email = ''.obs;
  Rx<File> _photo = File('').obs;
  RxBool _isPhotoPicked = false.obs;

  String get name => _name.value;
  String get job => _job.value;
  String get email => _email.value;
  File get photo => _photo.value;
  bool get isPhotoPicked => _isPhotoPicked.value;
  set updateName(String name) => this._name.value = name;
  set updateJob(String job) => this._job.value = job;
  set updateEmail(String email) => this._email.value = email;
  set updatePhoto(File photo) => this._photo.value = photo;
  set updateIsPhotoPicked(bool isPhotoPicked) =>
      this._isPhotoPicked.value = isPhotoPicked;

  @override
  void onInit() {
    super.onInit();
  }

  void createEmployee() async {
    try {
      final _result = await repository.createEmployee(name, job);
      print("name $name");
      Get.find<HomePageController>().employeeList.add(
          Employee(id: _result, email: email, name: name, avatar: photo.path));
      Get.find<HomePageController>().update();
      Get.back();
      // return _result;
    } catch (e) {
      Get.snackbar('Tambah Karyawan Gagal', '');
      // return e;
    }
  }
}
