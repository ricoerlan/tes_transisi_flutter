import 'package:get/get.dart';
import 'package:tes_transisi/app/data/models/employee.dart';
import 'package:tes_transisi/app/data/repository/repository.dart';

class HomePageController extends GetxController {
  final Repository repository;
  HomePageController({required this.repository});

  RxList<Employee> _employeeList = <Employee>[].obs;
  RxList<Employee> _filteredEmployeeList = <Employee>[].obs;
  RxBool _isFiltered = false.obs;

  List<Employee> get employeeList => _employeeList;
  List<Employee> get filteredEmployeeList => _filteredEmployeeList;
  bool get isFiltered => _isFiltered.value;
  set updateEmployeeList(List<Employee> employeeList) =>
      this._employeeList.value = employeeList;
  set updateFilteredEmployeeList(List<Employee> filteredEmployeeList) =>
      this._filteredEmployeeList.value = filteredEmployeeList;
  set updateIsFiltered(bool isFiltered) => this._isFiltered.value = isFiltered;

  @override
  void onInit() {
    getAllEmployee();
    super.onInit();
  }

  Future<List<Employee>> getAllEmployee() async {
    try {
      List<Employee> _result = await repository.getAllEmployee();
      updateEmployeeList = _result;
      return _result;
    } catch (e) {
      Get.snackbar('Load Data Gagal', 'Periksa Jaringan Anda');
      rethrow;
    }
  }

  void searchQuery(String keyword) async {
    List<Employee> allEmployee = await Repository().getAllEmployee();
    List<Employee> _employees = [];
    for (int i = 0; i < allEmployee.length; i++) {
      if (allEmployee[i].name!.toLowerCase().contains(keyword) ||
          allEmployee[i].email!.toLowerCase().contains(keyword)) {
        _employees.add(allEmployee[i]);
      }

      updateFilteredEmployeeList = _employees;
    }
  }
}
