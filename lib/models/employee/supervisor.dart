import '../user/user_data.dart';

class Supervisor {
  dynamic data;
  String status;
  String? message;

  Supervisor({
    this.data,
    required this.status,
    this.message,
  });

  factory Supervisor.fromJson(json) => Supervisor(
        data: json['data']['supervisors'] != []
            ? json['data']['supervisors']
                .map<UserData>(UserData.fromJson)
                .toList()
            : [],
        status: json['status'],
        message: json['message'],
      );
}
