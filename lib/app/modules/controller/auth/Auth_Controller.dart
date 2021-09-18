import 'package:get/get.dart';
import 'package:tes_transisi/app/data/repository/repository.dart';

class AuthController extends GetxController {
  AuthController({required this.repository});
  Repository repository;
  RxString _authToken = ''.obs;
  RxBool _isloading = false.obs;

  String? get authToken => _authToken.value;
  bool? get isLoading => _isloading.value;

  set updateAuthToken(String token) => _authToken.value = token;

  @override
  void onInit() {
    retrieveAuthToken();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void signIn(String email, String password) async {
    _isloading.value = true;
    try {
      String _result = await repository.signIn(email, password);
      updateAuthToken = _result;
      Get.snackbar(
        "Welcome Back",
        "Login Successful",
      );
      // Get.back();
    } catch (e) {
      Get.snackbar("Error Signing In", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    _isloading.value = false;
  }

  void signUp(String email, String password) async {
    _isloading.value = true;
    try {
      String _result = await repository.signUp(email, password);
      updateAuthToken = _result;
      Get.snackbar(
        "Welcome",
        "Register Successful",
      );
      Get.back();
    } catch (e) {
      Get.snackbar("Error Signing Up", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    _isloading.value = false;
  }

  void signOut() async {
    _isloading.value = true;
    try {
      await repository.removeAuthToken();
      updateAuthToken = '';
    } catch (e) {
      Get.snackbar("Error Signing out", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    _isloading.value = false;
  }

  void retrieveAuthToken() async {
    String _result = await repository.retrieveAuthToken();
    updateAuthToken = _result;
  }
}
