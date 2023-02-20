import '../user/user_data.dart';

class Employee {
  dynamic data;
  String status;
  String? message;

  Employee({
    this.data,
    required this.status,
    this.message,
  });

  factory Employee.fromJson(json) => Employee(
        data: json['data']['workers'] != []
            ? json['data']['workers'].map<UserData>(UserData.fromJson).toList()
            : [],
        status: json['status'],
        message: json['message'],
      );
}

// class Workers {
//   List<UserData> workersData;

//   Workers({
//     required this.workersData,
//   });

//   factory Workers.fromJson(json) => Workers(
//       workersData: json['workers'] != null && json['workers'] != []
//           ? json['workers'].map<UserData>(UserData.fromJson).toList()
//           : null);
// }
