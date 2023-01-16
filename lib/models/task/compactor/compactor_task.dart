import 'dart:convert';

import 'data/data.dart';

CompactorTask compactorTaskFromJson(String str) =>
    CompactorTask.fromJson(json.decode(str));

String compactorTaskToJson(CompactorTask data) => json.encode(data.toJson());

class CompactorTask {
  CompactorTask({
    this.data,
    this.status,
    this.message,
  });

  Data? data;
  String? status;
  String? message;

  factory CompactorTask.fromJson(Map<String, dynamic> json) => CompactorTask(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "status": status,
        "message": message,
      };
}
