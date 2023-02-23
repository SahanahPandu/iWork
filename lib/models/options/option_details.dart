import 'package:eswm/models/vc/status/vc_filter_status.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../models/ecuti/leave_types.dart';
import '../../models/report/obstacle_types.dart';
import '../report/report_status.dart';
import '../schedule/filter/schedule_filter_status.dart';

@JsonSerializable()
class OptionDetails {
  final dynamic generalStatus;
  final dynamic reportStatus;
  final dynamic akbkStatus;
  final dynamic ecutiStatus;

  @JsonKey(
    defaultValue: [],
  )
  final List<ScheduleFilterStatus?>? scheduleStatus;

  final dynamic isuStatus;
  final dynamic sahStatus;
  final dynamic workerSchedule;
  @JsonKey(
    defaultValue: [],
  )
  final List<VcStatus?>? vcStatus;
  final dynamic userTypes;

  @JsonKey(
    defaultValue: [],
  )
  final List<LeaveTypes?>? leaveTypes;

  @JsonKey(
    defaultValue: [],
  )
  final List<ObstacleTypes?>? obtacleTypes;

  OptionDetails({
    this.generalStatus,
    this.reportStatus,
    this.akbkStatus,
    this.ecutiStatus,
    this.scheduleStatus,
    this.isuStatus,
    this.sahStatus,
    this.workerSchedule,
    this.vcStatus,
    this.userTypes,
    this.leaveTypes,
    this.obtacleTypes,
  });

  factory OptionDetails.fromJson(json) => OptionDetails(
        generalStatus: json['general_status'],
        reportStatus: json['report_status'] != null
            ? json['report_status']
                .map<ReportStatus>(ReportStatus.fromJson)
                .toList()
            : json['report_status'],
        akbkStatus: json['akbk_status'],
        ecutiStatus: json['ecuti_status'],
        scheduleStatus: json['schedule_status'] != null
            ? json['schedule_status']
                .map<ScheduleFilterStatus>(ScheduleFilterStatus.fromJson)
                .toList()
            : json['schedule_status'],
        isuStatus: json['isu_status'],
        sahStatus: json['sah_status'],
        workerSchedule: json['worker_schedule'],
        vcStatus: json['vc_status'] != null
            ? json['vc_status'].map<VcStatus>(VcStatus.fromJson).toList()
            : json['vc_status'],
        userTypes: json['user_types'],
        leaveTypes: json['leave_types'] != null
            ? json['leave_types'].map<LeaveTypes>(LeaveTypes.fromJson).toList()
            : json['leave_types'],
        obtacleTypes: json['obstacle_types'] != null
            ? json['obstacle_types']
                .map<ObstacleTypes>(ObstacleTypes.fromJson)
                .toList()
            : json['obstacle_types'],
      );
}
