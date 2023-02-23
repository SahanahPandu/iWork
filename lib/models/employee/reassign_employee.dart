import 'package:json_annotation/json_annotation.dart';

class ReassignEmployee {
  final int workerScId;

  @JsonKey(defaultValue: 0)
  int isReassigned;

  @JsonKey(defaultValue: null)
  int? currUserId;

  @JsonKey(defaultValue: null)
  int? reassignId;

  @JsonKey(defaultValue: null)
  int? svId;

  ReassignEmployee({
    required this.workerScId,
    required this.isReassigned,
    required this.currUserId,
    this.reassignId,
    this.svId,
  });

  factory ReassignEmployee.fromJson(json) => ReassignEmployee(
        workerScId: json['worker_schedule_id'],
        isReassigned: json['is_reassigned'],
        currUserId: json['current_user_id'],
        reassignId: json['reasssign_user_id'],
        svId: json['supervisor_id'],
      );

  Map<String, dynamic> toJson() => {
        "worker_schedule_id": workerScId,
        "is_reassigned": isReassigned,
        "current_user_id": currUserId,
        "reasssign_user_id": reassignId,
        "supervisor_id": svId,
      };
}
