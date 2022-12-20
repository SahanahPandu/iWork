import 'general_worker_task.dart';

class TaskData {
  GeneralWorkerTask data;
  String status;
  String? message;

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
