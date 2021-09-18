import 'dart:io';

class Employee {
  int? id;
  String? email;
  String? name;
  String? lastName;
  String? avatar;
  File? image;

  Employee(
      {this.id, this.email, this.name, this.lastName, this.avatar, this.image});

  Employee.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        email = json['email'],
        name = json['first_name'] + json['last_name'],
        avatar = json['avatar'];
}

class EmployeeList {
  final List<Employee> list;

  EmployeeList({
    required this.list,
  });

  factory EmployeeList.fromJson(List<dynamic> parsedJson) {
    List<Employee> list = [];
    list = parsedJson.map((i) => Employee.fromJson(i)).toList();

    return new EmployeeList(list: list);
  }
}
