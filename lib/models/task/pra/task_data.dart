import 'package:json_annotation/json_annotation.dart';

import 'general_worker_task.dart';

class TaskData {
  GeneralWorkerTask data;
  final String status;

  @JsonKey(defaultValue: "")
  final String? message;

  TaskData({
    required this.data,
    required this.status,
    this.message,
  });

  factory TaskData.fromJson(json) => TaskData(
        data: GeneralWorkerTask.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}
