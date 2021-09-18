import 'package:get/get.dart';
import 'package:tes_transisi/app/modules/screen/auth/login/login_page_screen.dart';
import 'package:tes_transisi/app/modules/screen/create_employee/create_employee_screen.dart';
import 'package:tes_transisi/app/modules/screen/detail_employee/detail_employee_screen.dart';
import 'package:tes_transisi/app/modules/screen/home/home_page_screen.dart';

part './routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.Login, page: () => LoginPageScreen()),
    GetPage(name: Routes.Home, page: () => HomePageScreen()),
    GetPage(name: Routes.Detail_Employee, page: () => DetailEmployeeScreen()),
    GetPage(name: Routes.Create_Employee, page: () => CreateEmployeeScreen()),
  ];
}
