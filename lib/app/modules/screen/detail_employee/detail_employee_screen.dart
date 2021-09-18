import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_transisi/app/data/models/employee.dart';
import 'package:tes_transisi/app/modules/controller/detail_employee/DetailEmployeePageController.dart';

class DetailEmployeeScreen extends GetView {
  final DetailEmployeePageController controller =
      Get.find<DetailEmployeePageController>();

  @override
  Widget build(BuildContext context) {
    final Employee employee = controller.employee;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Obx(() {
          return SingleChildScrollView(
              child: Stack(children: [
            ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: employee.avatar!.isNotEmpty
                    ? Image.network(
                        controller.employee.avatar!,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.contain,
                      )
                    : employee.image != null
                        ? Image.file(
                            employee.image!,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitHeight,
                          )
                        : Icon(
                            Icons.person,
                            size: MediaQuery.of(context).size.width,
                          )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    TextFormField(
                      enabled: controller.isEnable,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        )),
                        filled: true,
                        prefixIcon: Icon(Icons.person),
                        // labelText: labelText,
                      ),
                      initialValue: employee.name!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      onSaved: (value) => controller.updateName = value!,
                      onChanged: (value) => controller.updateName = value,
                      // validator: validator,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      enabled: controller.isEnable,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          )),
                          filled: true,
                          prefixIcon: Icon(Icons.email)),
                      initialValue: employee.email!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      onSaved: (value) => controller.updateEmail = value!,
                      onChanged: (value) => controller.updateEmail = value,
                      // validator: validator,
                    ),
                  ]),
            ),
          ]));
        }),
        floatingActionButton: Obx(() {
          return FloatingActionButton(
            child: controller.icon,
            onPressed: () async {
              controller.updateIsEnable = !controller.isEnable;
              if (controller.isEnable) {
                controller.updateIcon = Icon(Icons.save);
              } else {
                controller.updateIcon = Icon(Icons.edit);
                await controller.updateEmployeeDetail(employee.id!);
                print('saved');
              }
            },
          );
        }));
  }
}
