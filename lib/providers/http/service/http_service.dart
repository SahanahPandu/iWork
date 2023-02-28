import '../../../config/config.dart';

class HttpService {
  /// Base url
  // final Uri baseUrl = (Uri.parse('http://103.26.46.187:81/api'));

  /// Login url
  final Uri loginUrl = (Uri.parse('$theBase/login'));

  /// Logout url
  final Uri logoutUrl = (Uri.parse('$theBase/logout'));

  /// Update Device Id url
  final Uri updateIDUrl = (Uri.parse('$theBase/update_device_id'));

  /// Task Url
  /// Task data extraction for Compactor Panel as String
  final loadCompactorTaskUrlTest = '$theBase/task/vehicle/details';

  /// Task data extraction for Supervisor as String
  final loadSupervisorTaskUrl = '$theBase/task/list';

  /// Schedule Url
  /// Schedule data extraction for Compactor Panel as String
  final loadCompactorScheduleListUrl = '$theBase/schedule/schedules';

  /// Schedule details extraction as String
  final loadScheduleDetailUrl = '$theBase/schedule';

  /// Load Vehicle Checklist Url as String
  final loadVehicleChecklist = '$theBase/task/vehicle-checklist';

  /// Update Vehicle Checklist Url as String
  final updateVehicleChecklist = '$theBase/task/checklist/update';

  /// Update Vehicle Checklist Url as Uri
  final Uri updateVehicleChecklistTest =
      (Uri.parse('$theBase/task/checklist/update'));

  /// Update Start Work Time Url as Uri
  final Uri updateStartWorkTime = (Uri.parse('$theBase/task/start'));

  /// Update Stop Work Time Url as Uri
  final Uri updateStopWorkTime = (Uri.parse('$theBase/task/stop'));

  /// Update Worker Attendance Url as String
  final updateWorkerAttendanceUrl = '$theBase/task/confirmation-attendance';

  /// Load Vehicle Checklist Verification list Url as String
  final loadVehicleChecklistVerificationList =
      '$theBase/task/confirmation/list/vehicle-checklists';

  /// Load Workers Attendance Url as String
  final loadWorkersAttendanceList = '$theBase/task/confirmation/attendance';

  /// Load Report of Schedule Url as String
  final loadReportOfScheduleList = '$theBase/report/schedule';

  /// Load Request Worker List Url as String
  final loadRequestWorkerList =
      '$theBase/task/confirmation/list/request-workers';

  /// Update Request Worker Url as String
  final updateRequestWorkerUrl = '$theBase/task/confirmation/request-workers';

  /// Update Report for Approval Url as String
  final updateReportApproveUrl = '$theBase/report/update';

  /// Update e-Notice Url as String
  final updateEnotice = '$theBase/attendance/enotis/update';

  /// Update Attendance for clock in Url as String
  final updateClockIn = '$theBase/attendance/start-work';

  /// Update Attendance for clock in Url as String
  final updateClockOut = '$theBase/attendance/end-work';

  /// Get Filter Options Url as String
  final loadFilterOption = '$theBase/options';

  /// Update vehicle's location URL as String
  final updateLocationUrl = '$theBase/vehicle/new-vehicle-location';
}
