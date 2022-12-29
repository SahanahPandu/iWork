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
  /// Below is task schedule data extraction for Compactor Panel as Uri
  final Uri loadCompactorTaskUrl = (Uri.parse('$theBase/task/vehicle/details'));

  /// Task schedule data extraction for Compactor Panel as String
  final loadCompactorTaskUrlTest = '$theBase/task/vehicle/details';

  /// Load Vehicle Checklist Url as String
  final loadVehicleChecklist = '$theBase/task/vehicle-checklist';

  /// Update Vehicle Checklist Url as String
  final updateVehicleChecklist = '$theBase/task/checklist/update';

  /// Update Vehicle Checklist Url as Uri
  final Uri updateVehicleChecklistTest =
      (Uri.parse('$theBase/task/checklist/update'));
}
