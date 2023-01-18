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
  /// Below is task schedule data extraction for Compactor Panel as Uri
  final Uri loadCompactorTaskUrl = (Uri.parse('$theBase/task/vehicle/details'));

  /// Task data extraction for Compactor Panel as String
  final loadCompactorTaskUrlTest = '$theBase/task/vehicle/details';

  /// Schedule Url
  /// Schedule data extraction for Compactor Panel as String
  final loadCompactorScheduleListUrl = '$theBase/schedule/schedules';

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
}
