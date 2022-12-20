import 'package:eswm/models/report/obstacle_types.dart';

class OptionDetails {
  final dynamic generalStatus;
  final dynamic reportStatus;
  final dynamic akbkStatus;
  final dynamic ecutiStatus;
  final dynamic scheduleStatus;
  final dynamic isuStatus;
  final dynamic sahStatus;
  final dynamic workerSchedule;
  final dynamic userTypes;
  final dynamic leaveTypes;
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
    this.userTypes,
    this.leaveTypes,
    this.obtacleTypes,
  });

  factory OptionDetails.fromJson(json) => OptionDetails(
        generalStatus: json['general_status'],
        reportStatus: json['report_status'],
        akbkStatus: json['akbk_status'],
        ecutiStatus: json['ecuti_status'],
        scheduleStatus: json['schedule_status'],
        isuStatus: json['isu_status'],
        sahStatus: json['sah_status'],
        workerSchedule: json['worker_schedule'],
        userTypes: json['user_types'],
        leaveTypes: json['leave_types'],
        obtacleTypes: json['obstacle_types']
            .map<ObstacleTypes>(ObstacleTypes.fromJson)
            .toList(),
      );
}
