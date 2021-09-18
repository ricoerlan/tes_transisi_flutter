import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tes_transisi/app/data/models/employee.dart';
import 'package:tes_transisi/app/data/repository/repository.dart';
import 'package:tes_transisi/app/modules/controller/auth/Auth_Controller.dart';
import 'package:tes_transisi/app/modules/controller/detail_employee/DetailEmployeePageController.dart';
import 'package:tes_transisi/app/modules/controller/home/HomePageController.dart';
import 'package:tes_transisi/app/modules/screen/create_employee/create_employee_screen.dart';
import 'package:tes_transisi/app/modules/screen/detail_employee/detail_employee_screen.dart';

class HomePageScreen extends GetView<HomePageController> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text('Daftar Karyawan'),
            actions: [
              PopupMenuButton(
                  elevation: 50,
                  child: Container(
                      margin: EdgeInsets.all(8),
                      child: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.transparent,
                          // radius: 60.0,
                          child: ClipOval(child: Icon(Icons.more_vert)))),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                        PopupMenuItem<int>(value: 1, child: Text("Logout")),
                      ],
                  onSelected: (int value) {
                    switch (value) {
                      case 1:
                        Get.find<AuthController>().signOut();
                        break;
                      default:
                    }
                  })
            ]),
        body: Obx(() {
          if (controller.employeeList.isNotEmpty)
            return Container(
              child: Column(
                children: <Widget>[
                  Container(
                    // height: 60,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Coba "Emma" ',
                            border: InputBorder.none,
                            suffixIcon: Icon(
                              Icons.search,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          onSubmitted: (query) {
                            controller.searchQuery(query.toLowerCase());
                            controller.updateIsFiltered = true;
                            _textController.clear();
                          },
                          controller: _textController,
                          focusNode: _focusNode,
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: !controller.isFiltered
                            ? controller.employeeList.length
                            : controller.filteredEmployeeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Employee employee = !controller.isFiltered
                              ? controller.employeeList[index]
                              : controller.filteredEmployeeList[index];
                          return GestureDetector(
                            onTap: () {
                              DetailEmployeePageController detailController =
                                  Get.put(DetailEmployeePageController(
                                      repository: Repository()));
                              detailController.updateEmployee = employee;
                              // controller.updateIsFiltered = false;
                              // controller.updateFilteredEmployeeList = [];
                              // controller.getAllEmployee();
                              Get.to(() => DetailEmployeeScreen());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 15,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        border: Border.all(
                                          width: 2,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        // shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: employee.avatar!.isNotEmpty
                                          ? CircleAvatar(
                                              radius: 20,
                                              backgroundImage: NetworkImage(
                                                  employee.avatar!),
                                            )
                                          : employee.image != null
                                              ? Image.file(
                                                  employee.image!,
                                                  width: 40.0,
                                                  height: 40.0,
                                                  fit: BoxFit.fitHeight,
                                                )
                                              : Icon(
                                                  Icons.person,
                                                  size: 40,
                                                )),
                                  Container(
                                    // width: MediaQuery.of(context).size.width *
                                    //     0.65,
                                    padding: EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Column(children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                employee.name!,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              // Icon(Icons.star),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          employee.email!,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ]),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          return Center(child: CircularProgressIndicator());
        }),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(() => CreateEmployeeScreen());
          },
        ));
  }
}
