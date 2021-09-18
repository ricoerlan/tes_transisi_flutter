import 'package:get/get.dart';

class Validator {
  Validator();

  String? email(String? value) {
    String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty)
      return 'Your email is empty';
    else if (!regex.hasMatch(value))
      return 'Check Your Email'.tr;
    else
      return null;
  }

  String? password(String? value) {
    String pattern = r'^.{6,}$';
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty)
      return 'Your password is empty';
    else if (!regex.hasMatch(value))
      return 'Check Your Password'.tr;
    else
      return null;
  }

  String? anyData(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty)
      return 'Your Data is empty';
    else if (!regex.hasMatch(value))
      return 'Check Your Data'.tr;
    else
      return null;
  }
}
