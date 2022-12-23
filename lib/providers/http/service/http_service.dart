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

  /// Task Schedules
  /// Below is task schedule data extraction for Compactor Panel
  final Uri loadCompactorTaskUrl = (Uri.parse('$theBase/task/vehicle/details'));

  final loadCompactorTaskUrlTest = '$theBase/task/vehicle/details';
}
