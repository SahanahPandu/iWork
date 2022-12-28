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

  /// Task Schedules Url
  /// Below is task schedule data extraction for Compactor Panel
  final Uri loadCompactorTaskUrl = (Uri.parse('$theBase/task/vehicle/details'));

  final loadCompactorTaskUrlTest = '$theBase/task/vehicle/details';

  /// Load Vehicle Checklist Url
  final loadVehicleChecklist = '$theBase/task/vehicle-checklist';

  /// Update Vehicle Checklist Url
  final updateVehicleChecklist = '$theBase/task/checklist/update';
}
