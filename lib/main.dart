import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tes_transisi/app/modules/binding/binding.dart';
import 'package:tes_transisi/app/modules/controller/auth/Auth_Controller.dart';
import 'package:tes_transisi/app/modules/screen/auth/login/login_page_screen.dart';
import 'package:tes_transisi/app/modules/screen/home/home_page_screen.dart';
import 'package:tes_transisi/core/theme/app_theme.dart';
import 'package:tes_transisi/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    initialBinding: AuthBinding(),
    // onInit: Get.find<AuthController>().getUser,
    debugShowCheckedModeBanner: false,
    // initialRoute: Routes.SPLASH,
    theme: appTheme,
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
    home: Obx(() {
      if (Get.find<AuthController>().authToken!.isNotEmpty) {
        return HomePageScreen();
      }
      if (Get.find<AuthController>().authToken!.isEmpty) {
        return LoginPageScreen();
      }

      return CircularProgressIndicator();
    }),
  ));
}
