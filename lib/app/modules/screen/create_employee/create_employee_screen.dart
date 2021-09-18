import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_transisi/app/data/repository/repository.dart';
import 'package:tes_transisi/app/modules/controller/create_employee/CreateEmployeePageController.dart';
import 'package:tes_transisi/app/modules/screen/auth/widget/form_inputfield_with_icon.dart';
import 'package:tes_transisi/app/modules/screen/auth/widget/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tes_transisi/core/utils/validator.dart';

class CreateEmployeeScreen extends GetView {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CreateEmployeePageController controller =
      Get.put(CreateEmployeePageController(repository: Repository()));
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _jobTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Tambah Karyawan',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: GetBuilder<CreateEmployeePageController>(
        init: CreateEmployeePageController(repository: Repository()),
        initState: (_) {},
        builder: (_) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 24),
                    Text(
                      "Form Tambah Karyawan",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 24),
                    Center(
                        child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade300,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60))),
                            // radius: 60,
                            // backgroundColor: appTheme.primaryColor,
                            child: controller.isPhotoPicked
                                ? Image.file(
                                    controller.photo,
                                    width: 200.0,
                                    height: 200.0,
                                    fit: BoxFit.fitHeight,
                                  )
                                : IconButton(
                                    iconSize: 60,
                                    onPressed: () async {
                                      XFile? image = await ImagePicker()
                                          .pickImage(
                                              source: ImageSource.gallery,
                                              imageQuality: 50,
                                              preferredCameraDevice:
                                                  CameraDevice.front);
                                      controller.updatePhoto =
                                          File(image!.path);
                                      controller.updateIsPhotoPicked = true;
                                    },
                                    icon: Icon(Icons.photo_camera_rounded)))),
                    SizedBox(height: 24),
                    SizedBox(height: 12),
                    FormInputFieldWithIcon(
                      controller: _nameTextController,
                      iconPrefix: Icons.email,
                      labelText: 'name'.tr,
                      validator: Validator().anyData,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => controller.updateName = value,
                      onSaved: (value) => controller.updateName = value!,
                    ),
                    SizedBox(height: 24),
                    FormInputFieldWithIcon(
                      controller: _emailTextController,
                      iconPrefix: Icons.person,
                      labelText: 'email'.tr,
                      validator: Validator().email,
                      onChanged: (value) => controller.updateEmail = value,
                      onSaved: (value) => controller.updateEmail = value!,
                      maxLines: 1,
                    ),
                    SizedBox(height: 24),
                    FormInputFieldWithIcon(
                      controller: _jobTextController,
                      iconPrefix: Icons.person,
                      labelText: 'job'.tr,
                      validator: Validator().anyData,
                      onChanged: (value) => controller.updateJob = value,
                      onSaved: (value) => controller.updateJob = value!,
                      maxLines: 1,
                    ),
                    SizedBox(height: 36),
                    PrimaryButton(
                        labelText: 'Tambah'.tr,
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            controller.createEmployee();
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageFromGalleryEx extends StatefulWidget {
  final source;
  ImageFromGalleryEx(this.source);

  @override
  ImageFromGalleryExState createState() => ImageFromGalleryExState(this.source);
}

class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
  var _image;
  var imagePicker;
  var source;

  ImageFromGalleryExState(this.source);

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image from Gallery")),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 52,
          ),
          Center(
            child: GestureDetector(
              onTap: () async {
                XFile image = await imagePicker.pickImage(
                    source: source,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image.path);
                });
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: _image != null
                    ? Image.file(
                        _image,
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.fitHeight,
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.red[200]),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
