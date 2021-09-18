import 'package:get/get.dart';
import 'package:tes_transisi/app/data/repository/repository.dart';
import 'package:tes_transisi/app/modules/controller/auth/Auth_Controller.dart';
import 'package:tes_transisi/app/modules/controller/home/HomePageController.dart';

class AuthBinding implements Bindings {
  Repository repository = Repository();

  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(
        () => HomePageController(repository: repository));
    Get.lazyPut<AuthController>(() => AuthController(repository: repository),
        fenix: true);
    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.find<AuthController>().getUser();
  }
}
