import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tes_transisi/app/modules/controller/auth/Auth_Controller.dart';
import 'package:tes_transisi/app/modules/screen/auth/widget/form_inputfield_with_icon.dart';
import 'package:tes_transisi/app/modules/screen/auth/widget/graphic_header.dart';
import 'package:tes_transisi/app/modules/screen/auth/widget/label_button.dart';
import 'package:tes_transisi/app/modules/screen/auth/widget/primary_button.dart';
import 'package:tes_transisi/core/utils/validator.dart';

class RegisterPageScreen extends GetWidget<AuthController> {
  // AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isLoading == true
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          GraphicHeader(),
                          SizedBox(height: 24.0),
                          Text(
                            " REGISTER",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 12),
                          SizedBox(height: 12),
                          FormInputFieldWithIcon(
                            controller: _emailController,
                            iconPrefix: Icons.email,
                            labelText: 'email'.tr,
                            validator: Validator().email,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => null,
                            onSaved: (value) => _emailController.text = value!,
                          ),
                          SizedBox(height: 24),
                          FormInputFieldWithIcon(
                            controller: _passwordController,
                            iconPrefix: Icons.lock,
                            labelText: 'password'.tr,
                            validator: Validator().password,
                            obscureText: true,
                            onChanged: (value) => null,
                            onSaved: (value) =>
                                _passwordController.text = value!,
                            maxLines: 1,
                          ),
                          SizedBox(height: 36),
                          PrimaryButton(
                              labelText: 'Register'.tr,
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  SystemChannels.textInput.invokeMethod(
                                      'TextInput.hide'); //to hide the keyboard - if any
                                  controller.signUp(_emailController.text,
                                      _passwordController.text);
                                }
                              }),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have account ?"),
                              LabelButton(
                                labelText: 'LOGIN'.tr,
                                onPressed: () => Get.back(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
    });
  }
}
